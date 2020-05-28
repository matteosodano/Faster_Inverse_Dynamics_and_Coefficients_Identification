%%%%%%%%%%%%
%VALIDATION%
%%%%%%%%%%%%

%In this file we evaluate the identified parameters on a test trajectory


%Definitions
N=7;
deltat = 0.005;
d3 = 0.4;
d5 = 0.39;


q = dlmread('lab_traj/TEST/positions.txt');

samples = length(q)/N;
temp = zeros(N,samples);

%Reordering data into a [#joints,#samples] matrix
for i=1:samples
    temp(:,i) = q(N*(i-1)+1:N*(i-1)+N);
end
q = temp;
    
	
tau = dlmread('lab_traj/TEST/torquesvector.txt');


temp = zeros(N,samples);

%Reordering data into a [#joints,#samples] matrix
for i=1:samples
    temp(:,i) = tau(N*(i-1)+1:N*(i-1)+N);
end
tau = temp;
    
%Reading the identified parameters	
coeff = dlmread('greekPi.txt');


%Build q, dq, ddq and filter
qFILT = NoncasualButterworthFilter(q);
dq = TimeDerivative(q);
dqFILT = NoncasualButterworthFilter(dq);
ddq = TimeDerivative(dq);
ddqFILT = NoncasualButterworthFilter(ddq);
tauFILT = NoncasualButterworthFilter(tau);

%Evaluating the new estimation of torques
tau_hat = zeros(size(q));
for i=1:samples
    q = qFILT(:,i);
    dq = dqFILT(:,i);
    ddq = ddqFILT(:,i);
    Y = Regressor(q,dq,ddq,d3,d5);
    tau_hat(:, i) = Y*coeff;
end


t=0:deltat:samples*deltat;

%Plot of the results
figure
for i=1:7
    subplot(4,2,i)
    plot(t(1:end-1),tauFILT(i,:), t(1:end-1), tau_hat(i,:), 'LineWidth', 2);
    grid
    xlabel('Time [s]');
    ylabel(sprintf('$\\tau_%i$ [Nm]', i), 'Interpreter', 'latex');
end