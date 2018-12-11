% Symbolic variables

q = sym('q', [3 1]);
dq = sym('dq', [3 1]);
ddq = sym('ddq', [3 1]);
ee = sym('ee', [3 1]);

% Load of parameters and symbolic parameters selection
% [theta, R, m_b, m_br, l_A, r_Gb, m_fb, l_B, m_n, m_nt, I_bi]  = Parameters_DELTA;

% Adimensional parameters for a regular shape of the working volume. From
% [2] pg. 405
% r_l = R/lA
r_l = 0.63; % VERIFICA
% b = l_B/l_A
b = 2; 

% Arms parameters
syms m_b; % [kg] Upper arms mass
syms m_c; % [Kg] Elbow mass
syms m_fb; % [Kg] Forearms mass
syms r_m; % Ratio of forearm mass at upper extremis

m_br = m_b + m_c + r_m*m_fb; 

l_A = 0.2; % [m] Upper arms length
l_B = b*l_A; % [m] Forearms length
r_Gb = l_A*(0.5*m_b + m_c + r_m*m_fb)/m_br; % center of the mass of upper arms

% Base plate parameters
R = r_l*l_A;
theta = [0, 2*pi/3, 4*pi/3];

% Payload parameters
syms m_p; % [Kg] payload mass

% Travelling plate parameters
syms m_n; % [Kg] 
m_nt = m_n + m_p + 3*(1-r_m*m_fb); % [Kg] total mass contribute of the travelling plate

% Motors parameters
k_r = 1; % Gear reduction ratio

% Inertia 
I_m = 0; % [Kg*m^2] Inertia of the motor
I_brake = 0; % [Kg*m^2] Inertia of the motor
I_bc = l_A^2*(m_b/3 + m_c + r_m*m_fb); % [Kg*m^2] Inertia of the arm
I_bi = (I_m + I_brake)*k_r^2 + I_bc; % [Kg*m^2] Total inertia contribution of each upper arm
% 
I_b = diag([I_bi, I_bi, I_bi]);

[J,dJ] = Jacobian_DELTA(ee, q);

B = (I_b + m_nt*(J'*J)); 

% Coriolis elements matrix
C = (J'*m_nt*dJ);

% Gravitational elements matrix
G_n = m_nt*[0; 0; -9.81];
% G_b = m_br*[0; 0; -9.81];

% tau_b =  r_Gb*[ cos(theta(1)); cos(theta(2)); -m_br*9.8*cos(theta(3))];

tau_Gb = r_Gb*9.81*m_br*[ cos(q(1)); cos(q(2)); cos(q(3))];

G = (J'*G_n + tau_Gb);
syms F;

Dyn = B*ddq + C*dq + F*dq + G;

function [J,dJ] = Jacobian_DELTA(ee, q)
% Give back Jacobian matrix and its derivative

[theta, R, ~, ~, l_A, ~, ~, ~, ~, ~, ~] = Parameters_DELTA;

fprintf('\nJacobian coputation\n');

for i=1:3
    
    fprintf('\nLoop %d started\n',i);
    tic
    
    % Rotation matrix from base plate frame to i-joint frame 
    R_b = R_base(theta(i));
    
    % Matrix with s_i vectors as columns
    S(:,i) = ee - R_b*([R 0 0]' - l_A*[cos(q(i)), 0, sin(q(i))]');
    
    % Matrix with b_i vectors as columns
    B(:,i) = R_b*l_A*[-sin(q(i)), 0, cos(q(i))]';
    
    % Matrix with db_i vectors as columns
    dB(:,i) = R_b*l_A*[-cos(q(i)); 0; -sin(q(i))];
    
    % Matrix with ds_i vectors as columns
    dS(:,i) = ee - R_b*l_A*[-sin(q(i)), 0, cos(q(i))]';
    
    toc
end

% Jacobian
J = S'\diag(diag(S'*B));

% Jacobian derivative
dSB = diag(diag(dS'*B)) + diag(diag(S'*dB)); 

dJ = inv(S')*(-dS'*J + dSB);
end