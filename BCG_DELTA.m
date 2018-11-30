function [B, C, G, F] = BCG_DELTA(ee, q)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

[theta, ~, ~, m_br, ~, r_Gb, ~, ~, ~, m_nt, I_bi] = Parameters_DELTA;

% Arms intertia matrix
I_b = diag([I_bi, I_bi, I_bi]);

% Jacobian and its derivative
[J, dJ] = Jacobian_DELTA(ee,q);

% Inertia elements matrix
B = (I_b + m_nt*(J'*J)); 

% Coriolis elements matrix
C = (J'*m_nt*dJ);

% Gravitational elements matrix
G_n = m_nt*[0; 0; -9.81];
G_b = m_br*[0; 0; -9.81];

% tau_b =  r_Gb*[ cos(theta(1)); cos(theta(2)); -m_br*9.8*cos(theta(3))];

tau_Gb =  r_Gb*9.81*m_br*[ cos(q(1)); cos(q(2)); cos(q(3))];

G = (J'*G_n + tau_Gb);
F = 0.6;

end

