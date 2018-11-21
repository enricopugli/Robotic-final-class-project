% DELTA ROBOT MODEL PARAMETERS

% Adimensional parameters for a regular shape of the working volume

% r = R/lB. r = 0.63 gives the most regular shape for the surface of the lower part of the working volume.
r = 0.63; % VERIFICA

% b = lAB/lB. If r > 0,484 and b > 1,75 there is no singularity occurrence within the robot working volume.
b = 2; % VERIFICA

% Motors parameters
Im = 0;

% Arms parameters
m_b = 1; % [kg]
l_a = 1; % [m]

% Elbow parameters
m_c = 0; % [Kg]

% Forearms parameters
m_ab = 0.2; % [Kg]
lAB = b*l_a;

% Base plate parameters
R = r*l_a;
theta = [0, 2*pi/3, 4*pi/3];

% Travelling plate parameters
m_n = 1; % [Kg]
m_p = 0; % [Kg] payload mass 
m_nt = m_n + m_p + m_ab; % [Kg] total mass contribute of the travelling plate


