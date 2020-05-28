close all;
clear;
clc;

%% Robot dynamic and kinematic parameters
load_Kuka_kinematic_pars;
load_Kuka_dynamic_pars;
[r_i_Ci_vectors, inertias] = modDH_modifyDynamicData(r_i_Ci_vectors, inertias);

%% Data needed for the algorithm
num_of_joints = 7;

% Load data of interest
% data = dlmread('traj1/qNE.txt');
% data = dlmread('traj2/qNE.txt');
 data = dlmread('traj3/qNE.txt');
% data = dlmread('traj4/qNE.txt');

%% Repeat trajectories
total_data = [];
time = data(:, 1);
total_time = [];

for i=1:1
    total_data = [total_data; data];
    total_time = [total_time; data(:, 1) + (i-1)*time(end)];
end

%% Data needed for the algorithm (2)
data = total_data;
time = total_time;
deltat = time(2) - time(1);
positions = data(:, 2:8);

num_of_samples = length(time);

%% Initializations
POS_DES = zeros(num_of_joints,num_of_samples);
POSFILT = zeros(num_of_joints,num_of_samples);
VEL = zeros(num_of_joints,num_of_samples);
VEL_DES = zeros(num_of_joints,num_of_samples);
VELFILT = zeros(num_of_joints,num_of_samples);
ACC = zeros(num_of_joints,num_of_samples);
ACC_DES = zeros(num_of_joints,num_of_samples);
ACCFILT = zeros(num_of_joints,num_of_samples);

w0 = [0;0;0];
w0dot = [0;0;0];
a0 = [0;0;0];
F_last = [0;0;0];
M_last = [0;0;0];

POS = positions';

%% Filtering of the joint positions
POSFILT = NoncausalButterworthFilter(POS);

%% Joint velocities and joint accelerations obtained by differentiation + filtering
for j = 1:num_of_joints
    
    VEL(j, :) = TimeDerivative(POSFILT(j, :), deltat);
    VELFILT(j, :) = NoncausalButterworthFilter(VEL(j, :));
    ACC(j, :) = TimeDerivative(VEL(j, :), deltat);   
    ACCFILT(j, :) = NoncausalButterworthFilter(ACC(j, :));                 
   
end

t = time;
Q = POSFILT;
dQ = VELFILT;
ddQ = ACCFILT;


%% Newton - Euler algorithm
TAU_HAT = zeros(num_of_joints,num_of_samples);

for i=1:num_of_samples
    
    % current joint positions, velocities, accelerations
    q = Q(:,i);
    dq = dQ(:,i);
    ddq = ddQ(:,i);
        
    % rotation matrices according to modified DH convention
    R1=modDH_R(q(1),alphamod(1));
    R2=modDH_R(q(2),alphamod(2));
    R3=modDH_R(q(3),alphamod(3));
    R4=modDH_R(q(4),alphamod(4));
    R5=modDH_R(q(5),alphamod(5));
    R6=modDH_R(q(6),alphamod(6));
    R7=modDH_R(q(7),alphamod(7));
    
    % creation of a cell array with rotation matrices
    R_matrices{1} = R1;
    R_matrices{2} = R2;
    R_matrices{3} = R3;
    R_matrices{4} = R4;
    R_matrices{5} = R5;
    R_matrices{6} = R6;
    R_matrices{7} = R7;
    R_matrices{8} = eye(3);
    
    % r_i-1_i - NOTE: if d does not depend on time, this block can be
    % located outside the loop, since it not time dependent
    % using p(d,a,alpha)
    r_0_1 = modDH_p(0,0,alphamod(1));
    r_1_2 = modDH_p(0,0,alphamod(2));
    r_2_3 = modDH_p(d(3),0,alphamod(3));
    r_3_4 = modDH_p(0,0,alphamod(4));
    r_4_5 = modDH_p(d(5),0,alphamod(5));
    r_5_6 = modDH_p(0,0,alphamod(6));
    r_6_7 = modDH_p(0,0,alphamod(7));
    
    r_im1_i_vectors = [r_0_1,r_1_2,r_2_3,r_3_4,r_4_5,r_5_6,r_6_7];
    
    % N-E iteration    
    tau_hat = modDH_NE(q, dq, ddq, g, masses, inertias, ...
                       R_matrices, r_im1_i_vectors, r_i_Ci_vectors, ...
                       a0, w0, w0dot, F_last, M_last);

    TAU_HAT(:,i) = tau_hat;
end