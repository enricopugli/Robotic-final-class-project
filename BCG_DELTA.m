function [B, C, G] = BCG_DELTA(ee, q)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% Arms intertia matrix
I_b = diag([I_bi, I_bi, I_bi]);

% Jacobian and its derivative
[J, dJ] = Jacobian_DELTA(ee,q);

% Inertia elements matrix
B = (I_b + m_nt*(J'*J)); 

% Coriolis elements matrix
C = (J'*m_nt*dJ);

% Gravitational elements matrix
G_n = m_nt*[0, 0, -9.8];
G_b = m_br*[0, 0, -9.8];
G = -(J'*G_n + r_Gb*G_b*cos(theta'));

end

