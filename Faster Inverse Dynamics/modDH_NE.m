%% Newton-Euler routine for dynamic model of robots.
% note 2: this version is only for revolute joints

function tau = modDH_NE(q, dq, ddq, g, masses, inertias,...
                        R_matrices, r_im1_i_vectors, r_i_Ci_vectors,...
                        a0, w0, w0dot, F_last, M_last)

num_of_links = length(q);

W = zeros(3,num_of_links+1); % angular velocity
Wdot = zeros(3,num_of_links+1); % angular acceleration
A = zeros(3,num_of_links+1); % linear acceleration of frame
Ac = zeros(3,num_of_links+1); % linear acceleration of the center of mass
F = zeros(3,num_of_links+1); % forces
M = zeros(3,num_of_links+1); % momenta
tau = zeros(num_of_links,1); % joint torques

if isa(q,'sym')
    W = sym(W);
    Wdot = sym(Wdot);
    A = sym(A);
    Ac = sym(Ac);
    F = sym(F);
    M = sym(M);
    tau = sym(tau);
end

% initialize the algorithm
A(:,1) = a0 - g;
W(:,1) = w0;
Wdot(:,1) = w0dot;
F(:,num_of_links+1) = F_last;
M(:,num_of_links+1) = M_last;
r_im1_i_vectors = [r_im1_i_vectors,[0;0;0]];

% forward recursion
for i=1:num_of_links
    Ri = R_matrices{i};
    r_i_ip1 = r_im1_i_vectors(:,i);
    r_i_Ci = r_i_Ci_vectors(:,i);
    
    w_pre = W(:,i);
    wdot_pre = Wdot(:,i);
    a_pre = A(:,i);
    
    wi = Ri'*w_pre+[0;0;dq(i)];
    wi_dot = Ri'*wdot_pre + cross(Ri'*w_pre,[0;0;dq(i)]) + [0;0;ddq(i)];
    ai = Ri'*(cross(wdot_pre,r_i_ip1) + cross(w_pre,cross(w_pre,r_i_ip1))+a_pre);
    aci = cross(wi_dot,r_i_Ci) + cross(wi,cross(wi,r_i_Ci)) + ai;
    
    W(:,i+1) = wi;
    Wdot(:,i+1) = wi_dot;
    A(:,i+1) = ai;
    Ac(:,i+1) = aci;
    
    
end

% backward recursion
for i=num_of_links:-1:1
    
    mi = masses(i);
    Ii = inertias{i};
    R_ip1 = R_matrices{i+1};
    
    r_i_ip1 = r_im1_i_vectors(:,i+1);
    r_i_Ci = r_i_Ci_vectors(:,i);
    
    wi = W(:,i+1);
    wi_dot = Wdot(:,i+1);
    aci = Ac(:,i+1);
    f_post = F(:,i+1);
    mom_post = M(:,i+1);
    
    fi = R_ip1*f_post + mi*aci;
    momi = Ii*wi_dot + cross(wi,Ii*wi) + ...
       R_ip1*mom_post + cross(r_i_Ci,mi*aci) + ...
       cross(r_i_ip1,R_ip1*f_post);
    
    F(:,i) = fi;
    M(:,i) = momi;

    
end

for i=1:num_of_links
    tau(i) = modDH_finalloop_NE(i, M);
    
end

end