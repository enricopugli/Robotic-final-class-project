function [m_b, r_b, I_b, l_p, I_p] = Parameters_BP
% [m_b, r_b, I_b, l_p, I_p]

% Ball
% Material: glass
d_b = 2600; % density [Kg/m^3]
r_b = .01; % [m]
v_b = (4*pi*r_b^3)/3; % [m^3]
m_b = v_b*d_b; % [Kg]
I_b = (2/5)*m_b*r_b^2; % [Kg*m^2] 

% Plate
% Material: alluminium
d_p = 2700; % density [Kg/m^3]
l_p = 0.60; % [m] old: 0.24
h_p = .003; % [m]
v_p = h_p*l_p^2; % [m^3]
m_p = v_p*d_p; % [Kg]
I_p = (m_p*l_p^2)/6; % [Kg*m^2]
end