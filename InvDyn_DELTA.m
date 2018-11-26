function ddq = InvDyn_DELTA(tau, ee, q, dq, m_br, r_Gb, theta, m_nt, I_bi, l_A, R)

% References:
% [1] Olsson, A. (2009). Modelling and control of a Delta-3 robot, (February).
% [2] Codourey, A. (1998). Dynamic Modeling of Parallel Robots for Computed-Torque Control Implementation, 17(12), 1325–1336.

% B, C, G matrices
[B, C, G] = BCG_DELTA(ee, q, m_br, r_Gb, theta, m_nt, I_bi, l_A, R);

% Inverse dynamic
ddq = B\(tau - C*dq' - G); % Think adding friction coefficient of the manipulator (from [1] pg 27) 

end