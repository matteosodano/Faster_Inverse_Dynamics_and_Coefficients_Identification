%clc
T = 21;  %total execution time in seconds
configs = load('lab_traj/1---q_c_vrep_69.txt');


%{
configs = configs';

%the input path was computed as a reference for the real robot.
%We neeed therefore to adjust the sign of joints q2 and q6 that have an opposite 
%orientation in VRep with respect to the real system
configs(2,:) = -configs(2,:);
configs(6,:) = -configs(6,:);

cols = size(configs,2);

%repeate the path three times
%configs(:,end+1:end+2*cols) = [configs(:,:) configs(:,:)];

%repeat last configuration
for i=1:cols
    configs(:,end+1) = configs(:,end);
end


%add a line of time instants
delta = T/(size(configs,2)-1);
times = 0:delta:T;

configs(2:8,:) = configs (1:7,:);
configs(1,:) = times;

%transpose for simulink reading
configs = configs';
%}