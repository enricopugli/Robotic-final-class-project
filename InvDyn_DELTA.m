function ddq = InvDyn_DELTA(tau, q, dq)

% From references:
% Olsson, A. (2009). Modeling and control of a Delta-3 robot, (February).
% Codourey, A. (1998). Dynamic Modeling of Parallel Robots for Computed-Torque Control Implementation, 17(12), 1325–1336.

q1 = q(1);
q2 = q(2);
q3 = q(3);

dq1 = dq(1);
dq2 = dq(2);
dq3 = dq(3);

% Load parameters
Parameters;

% Inertia
I_bti = Im + lA^2*(m_b/3 + mC + 2*m_ab/3);    
I_bt = diag([I_bti; I_bti; I_bti]);

% Delta robot Jacobian
[J, ~, ~, ~]  = Jacobian_DELTA(ee, q);

% Inverse dynamic
ddq = I_bt\(tau - J'*m_nt*ddX);

end