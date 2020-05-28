%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%File for generating periodic trajectory%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear all

nameDEF = 'q_sin1_def.txt';
nameVREP = 'q_sin1_vrep.txt';
nameCPP = 'q_sin1_cpp.txt';


%Global parameters of the trajectory
T = 20;
deltaT = 0.005;
N = 7;
t1 = 0:deltaT:T;
samples = T/deltaT;

%Joint limits
q_lim = [170 120 170 120 170 120 170]*pi/180;   %rad
qd_lim = [110, 110, 128, 128, 204, 184, 184]*pi/180;  %rad/s

data = [];
for t = 0:deltaT:T
    q = [1.4*sin(pi/4*t) 1.4*sin(pi/5*t) 1.8*sin(pi/6*t) 1.3*sin(pi/4*t-pi/6) 3*sin(pi/3*t) 2*sin(pi/6*t) 3*sin(pi/5*t)];
    %Control on joint limits
	for i=1:N
        if q(i) > q_lim(i)
            q(i) = q_lim(i);
        elseif q(i) < -q_lim(i)
            q(i) = -q_lim(i);
        end
    end
    data = [data; t, q];
end

%Building derivatives via differentiation
dq = TimeDerivative(q);
ddq = TimeDerivative(dq);

%Useful plots for validating feasibility
figure
for i=2:8
    subplot(4,2,i-1)
    plot(t1,data(:,i));
    xlabel('time [s]');
    ylabelstring = sprintf('q_%i [rad]',i-1);
    ylabel(ylabelstring);
    title("Positions");
    ylim([-2.9671 2.9671])
    grid
end

figure
for i=1:7
    subplot(4,2,i)
    plot(t1(1:end-1),dq(i,:));
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
    fprintf(fVREP, '%f %f %f %f %f %f %f %f\n', data(i,1), -data(i, 2), data(i,3),...
        data(i,4), data(i,5), -data(i,6), data(i,7), data(i,8));   
end

for j=2:8
    for i=1:dim
        fprintf(fCPP, '%f\t', data(i,j));
    end
    fprintf(fCPP, '\n');
end 
fprintf(fDEF, 'T = 20s, t = 0.005, different amplitudes and pulses');

fclose(fVREP);
fclose(fCPP);
fclose(fDEF);