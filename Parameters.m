% DELTA ROBOT MODEL PARAMETERS

%
% Adimensional parameters for a regular shape of the working volume
%

% r = R/lA. r = 0.63 gives the most regular shape for the surface of the lower part of the working volume.
r = 0.63;

% b = lB/lA. If r > 0,484 and b > 1,75 there is no singularity occurrence within the robot working volume.
b = 2;

%
% Arms parameters
%

mA = 1; % [kg]
lA = 1; % [m]

%
% Base plate parameters
%

R = r*lA;
theta1 = 0;
theta2 = 120;
theta3 = 240;

%
% Forearms parameters
%

mB = 2;
lB = b*lA;

%
% Inertia TODO
%
