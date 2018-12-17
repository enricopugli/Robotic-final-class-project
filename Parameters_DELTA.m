function [theta, R, m_b, m_br, l_A, r_Gb, m_fb, l_B, m_n, m_nt, I_bi] = Parameters_DELTA
% [theta, R, m_b, m_br, l_A, r_Gb, m_fb, l_B, m_n, m_nt, I_bi]

% References:
% [1] Olsson, A. (2009). Modelling and control of a Delta-3 robot, (February).
% [2] Rey, L., & Clavel, R. (n.d.). The Delta Parallel Robot.
% [3] Clavel, R. (1991). Conception d’un robot parallele rapide à 4 degres de liberté.

% Adimensional parameters for a regular shape of the working volume. From
% [2] pg. 405
% r_l = R/lA
r_l = 0.63; % VERIFICA
% b = l_B/l_A
b = 2; 

% Parameters from [3] pg 63

% Arms parameters
m_b = 0.1; % [kg] Upper arms mass
m_c = 0.018; % [Kg] Elbow mass
m_fb = 0.045; % [Kg] Forearms mass
r_m = 2/3; % Ratio of forearm mass at upper extremis
m_br = m_b + m_c + r_m*m_fb; 

l_A = 0.2; % [m] Upper arms length
l_B = b*l_A; % [m] Forearms length
r_Gb = l_A*(0.5*m_b + m_c + r_m*m_fb)/m_br; % center of the mass of upper arms

% Base plate parameters
R = r_l*l_A;
theta = [0, 2*pi/3, 4*pi/3];

% Payload parameters
m_p = 0; % [Kg] payload mass

% Travelling plate parameters
m_n = .1; % [Kg] 
m_nt = m_n + m_p + 3*(1-r_m)*m_fb; % [Kg] total mass contribute of the travelling plate

% Motors parameters
k_r = 1; % Gear reduction ratio

% Inertia 
I_m = 0; % [Kg*m^2] Inertia of the motor
I_brake = 0; % [Kg*m^2] Inertia of the motor
I_bc = l_A^2*(m_b/3 + m_c + r_m*m_fb); % [Kg*m^2] Inertia of the arm
I_bi = (I_m + I_brake)*k_r^2 + I_bc; % [Kg*m^2] Total inertia contribution of each upper arm
end

