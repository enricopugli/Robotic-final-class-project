clear all;
% syms x_ee y_ee z_ee q1 q2 q3 l_A l_B R

syms x_ee y_ee z_ee q1 q2 q3 


[theta, R, ~, ~, l_A, ~, ~, l_B, ~, ~, ~] = Parameters_DELTA;

% System of equations

% eqns = [(x_ee - (cos(q1))*(l_A*cos(q1) + R))^2 + (y_ee + (R + l_A*cos(q1))*sin(q1))^2 + (z_ee + l_A*sin(q1))^2 - l_B^2 == 0,...
%         (x_ee - (cos(q2))*(l_A*cos(q2) + R))^2 + (y_ee + (R + l_A*cos(q2))*sin(q2))^2 + (z_ee + l_A*sin(q2))^2 - l_B^2 == 0,...
%         (x_ee - (cos(q3))*(l_A*cos(q3) + R))^2 + (y_ee + (R + l_A*cos(q3))*sin(q3))^2 + (z_ee + l_A*sin(q3))^2 - l_B^2 == 0,...
%          q1 < pi/2,...
%          q2 < pi/2,...
%          q3 < pi/2,...
%          z_ee < 0];

c = cos(theta);
s = sin(theta);

eqns = [(x_ee - c(1)*(l_A*cos(q1) + R))^2 + (y_ee + (R + l_A*cos(q1))*s(1))^2 + (z_ee + l_A*sin(q1))^2 - l_B^2 == 0,...
        (x_ee - c(2)*(l_A*cos(q2) + R))^2 + (y_ee + (R + l_A*cos(q2))*s(2))^2 + (z_ee + l_A*sin(q2))^2 - l_B^2 == 0,...
        (x_ee - c(3)*(l_A*cos(q3) + R))^2 + (y_ee + (R + l_A*cos(q3))*s(3))^2 + (z_ee + l_A*sin(q3))^2 - l_B^2 == 0];

% Direct kinematic solution
fprintf('\n###############################\n')
fprintf('start solving direct kinematic \n')
fprintf('###############################\n')
tic
vars1 = [x_ee, y_ee, z_ee];
Sdir = solve(eqns, vars1(3) < 0, vars1);
toc

q1 = pi/4;
q2 = pi/4;
q3 = pi/4;
gino = double(subs(Sdir.z_ee(2)))
% % Inverse kinematic solution
% fprintf('\n###############################\n')
% fprintf('start solving inverse kinematic \n')
% fprintf('###############################\n')
% tic
% vars2 = [q1, q2, q3];
% Sinv = solve(eqns, vars2);
% toc

save