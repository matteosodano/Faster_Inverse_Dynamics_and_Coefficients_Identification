clear all 
close all


%Read positions file
q = dlmread('lab_traj/q_c.txt');

[N,samples] = size(q);
deltat = 0.005;


%Build q, dq, ddq and filter
qFILT = NoncasualButterworthFilter(q);
dq = TimeDerivative(q);
dqFILT = NoncasualButterworthFilter(dq);
ddq = TimeDerivative(dq);
ddqFILT = NoncasualButterworthFilter(ddq);
tauFILT = NoncasualButterworthFilter(tau);

%Calling the function Regressor for computing Y
d3 = 0.4;
d5 = 0.39;
p = 64;
Y = zeros(N*samples, p);
for i=1:samples
    Y(N*(i-1)+1:N*(i-1)+N, :) = Regressor(qFILT(:, i), dqFILT(:, i), ddqFILT(:, i), d3, d5);
end

%Evaluate the conditioning
disp(cond(Y));