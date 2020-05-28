%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Parameters identification%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all

%Defining the paths in which the files are located
paths = {'trajCopy/TRAIN1','trajCopy/TRAIN2',...
    'trajCopy/TRAIN3'};

simulations = length(paths);
conditioning = zeros(simulations,1);

%Init final stacked matrices
tauTOT = [];
YTOT =  [];

for simulation = 1:simulations
    
    path = paths{simulation};
    
    %Global variables
    N = 7;
    p = 64;
    deltat = 0.005;
    cd(path);
	
    %Read positions file
    q_file = dlmread("positions.txt");
    rows = size(q_file); 
	rows = rows(1);
    samples = rows/N;
    temp = zeros(N,samples);
    
	for i=1:samples
        temp(:,i) = q_file(N*(i-1)+1:N*(i-1)+N);
    end
    q = temp;

    %Read torques file
    tau_file = dlmread("torquesvector.txt");
    rows = size(tau_file); rows = rows(1);
    samples = rows/N;
    temp = zeros(N,samples);

    for i=1:samples
        temp(:,i) = tau_file(N*(i-1)+1:N*(i-1)+N);
    end
    tau = temp;

    %Build dq, ddq and filter
    qFILT = NoncasualButterworthFilter(q);
    dq = TimeDerivative(q);
    dqFILT = NoncasualButterworthFilter(dq);
    ddq = TimeDerivative(qd);
    ddqFILT = NoncasualButterworthFilter(ddq);
    tauFILT = NoncasualButterworthFilter(tau);

	%Building torques column vector
    for i=1:samples
        if i==1
            tau_stack_filt = tauFILT(:,i);
        else
            tau_stack_filt = [tau_stack_filt;tauFILT(:,i)];
        end
    end
    

    t = 0:deltat:samples*deltat;
    t = t(1:end-1);

    cd('../..');


    %Build regressor matrix
    d3 = 0.4;
    d5 = 0.39;
    Y = zeros(N*samples, p);
    %Evaluation of Y
    for i=1:samples
        Y(N*(i-1)+1:N*(i-1)+N, :) = Regressor(qFILT(:, i), dqFILT(:, i), ddqFILT(:, i), d3, d5);
    end
    
	%Concatenating Y and \tau
    tauTOT = [tauTOT;tau_stack_filt];
    YTOT = [YTOT;Y];
end

%Identification via pseudoinverse
greekPi = pinv(YTOT)*tauTOT;
dlmwrite('greekPi.txt',greekPi);