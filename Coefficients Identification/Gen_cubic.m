%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%File for generating cubic trajectory%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear all

cd lab_traj

nameDEF = 'q_c_def_72.txt';
nameVREP = 'q_c_vrep_72.txt';
nameCPP = 'q_c_72.txt';


%Trajectory definition
deltaT = 0.005;
N = 7;
t_step = 3;
num_traj=7;
T = t_step*num_traj;
samples = T/deltaT;

%Joint limits
q_lim = [170 120 170 120 170 120 170]*pi/180;   %rad
qd_lim = [110, 110, 128, 128, 204, 184, 184]*pi/180;  %rad/s

%Init trajectories
TRAJ1 = zeros(N, t_step/deltaT);
TRAJ2 = zeros(N, t_step/deltaT);
TRAJ3 = zeros(N, t_step/deltaT);
TRAJ4 = zeros(N, t_step/deltaT);
TRAJ5 = zeros(N, t_step/deltaT);
TRAJ6 = zeros(N, t_step/deltaT);
TRAJ7 = zeros(N, t_step/deltaT);


%Knots
q_0 = [pi/2; pi/4; 150*pi/180; -45*pi/180; 90*pi/180; -50*pi/180; 34*pi/180];
q_fin1 = [pi/2; 3/7*pi; pi/2; -100*pi/180; 150*pi/180; 0*pi/180; 150*pi/180];
q_fin2 = [pi/6; -pi/4; pi/6; -pi/6; -pi/2; 0; 120*pi/180];
q_fin3 = [pi/2; pi/3; -pi/2; pi/4; -150*pi/180; -110*pi/180; 100*pi/180];
q_fin4 = [pi/2; -pi/3; -120*pi/180; -pi/6; pi/3; 110*pi/180; -70*pi/180];
q_fin5 = [-pi/4; 70*pi/180; -pi/4; 0; -150*pi/180; pi/2; -45*pi/180];
q_fin6 = [-160*pi/180; -70*pi/180; pi/2; -100*pi/180; 130*pi/180; -69*pi/180; -100*pi/180];  
q_fin7 = [-pi/2;0;130*pi/180;pi/4;0;-pi/2;0];

t = 0:deltaT:T;

%Trajectory 1
for i=1:N
    a = -2/(t_step^3) * (q_fin1(i)-q_0(i));
    b = 3/(t_step^2) * (q_fin1(i)-q_0(i));
    for j=1:t_step/deltaT
        TRAJ1(i,j) = a*t(j)^3 + b*t(j)^2 + q_0(i);
    end
end



%Trajectory 2
for i=1:N
    a = -2/(t_step^3) * (q_fin2(i)-q_fin1(i));
    b = 3/(t_step^2) * (q_fin2(i)-q_fin1(i));
    for j=1:t_step/deltaT
        TRAJ2(i,j) = a*t(j)^3 + b*t(j)^2 + q_fin1(i);
    end
end

%Trajectory 3
for i=1:N
    a = -2/(t_step^3) * (q_fin3(i)-q_fin2(i));
    b = 3/(t_step^2) * (q_fin3(i)-q_fin2(i));
    for j=1:t_step/deltaT
        TRAJ3(i,j) = a*t(j)^3 + b*t(j)^2 + q_fin2(i);
    end
end

%Trajectory 4
for i=1:N
    a = -2/(t_step^3) * (q_fin4(i)-q_fin3(i));
    b = 3/(t_step^2) * (q_fin4(i)-q_fin3(i));
    for j=1:t_step/deltaT
        TRAJ4(i,j) = a*t(j)^3 + b*t(j)^2 + q_fin3(i);
    end
end

%Trajectory 5
for i=1:N
    a = -2/(t_step^3) * (q_fin5(i)-q_fin4(i));
    b = 3/(t_step^2) * (q_fin5(i)-q_fin4(i));
    for j=1:t_step/deltaT
        TRAJ5(i,j) = a*t(j)^3 + b*t(j)^2 + q_fin4(i);
    end
end

%Trajectory 6
for i=1:N
    a = -2/(t_step^3) * (q_fin6(i)-q_fin5(i));
    b = 3/(t_step^2) * (q_fin6(i)-q_fin5(i));
    for j=1:t_step/deltaT
        TRAJ6(i,j) = a*t(j)^3 + b*t(j)^2 + q_fin5(i);
    end
end

%Last Trajectory
for i=1:N
    a = -2/(t_step^3) * (q_fin7(i)-q_fin6(i));
    b = 3/(t_step^2) * (q_fin7(i)-q_fin6(i));
    for j=1:t_step/deltaT+1
        TRAJ7(i,j) = a*t(j)^3 + b*t(j)^2 + q_fin6(i);
    end
end

%Building the whole trajectory
q = [TRAJ1, TRAJ2, TRAJ3, TRAJ4, TRAJ5, TRAJ6, TRAJ7];

%Building dq and ddq via differentiation
dq = TimeDerivative(q);
ddq = TimeDerivative(dq);

%Useful plots for verifying feasibility
figure
for i=1:7
    subplot(4,2,i)
    plot(t,q(i,:),'b',t,q_lim(i)*ones(size(t)),'--',...
        t,-q_lim(i)*ones(size(t)),'--');
    xlabel('time [s]');
    ylabelstring = sprintf('q_%i [rad]',i);
    ylabel(ylabelstring);
    title("Positions");
    ylim([-3.2 3.2])
    grid
end

figure
for i=1:7
    subplot(4,2,i)
    plot(t(1:end-1),dq(i,:),t,qd_lim(i)*ones(size(t)),...
        t,-qd_lim(i)*ones(size(t)));
    xlabel('time [s]');
    ylabelstring = sprintf('dq_%i [rad/s]',i);
    ylabel(ylabelstring);
    title("Velocities");
    grid
end

%Print the trajectories on files for VREP and for the FRI
fVREP = fopen(nameVREP, 'wt');
fDEF = fopen(nameDEF, 'wt');
fCPP = fopen(nameCPP, 'wt');
dim = T/deltaT + 1;
for i=1:dim
    fprintf(fVREP, '%f %f %f %f %f %f %f %f\n', t(i), -q(1, i), q(2,i), q(3,i), q(4,i), -q(5,i), q(6,i), q(7,i));   
end

for j=1:N
    for i=1:samples
        fprintf(fCPP, '%f\t', q(j,i));
    end
    fprintf(fCPP, '\n');
end 
fprintf(fDEF, 'T = 12s, t_step = 2, deltaT = 0.005;');

fclose(fVREP);
fclose(fCPP);
fclose(fDEF);
cd('../')