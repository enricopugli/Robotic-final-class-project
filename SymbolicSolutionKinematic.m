clear all;

syms x_ee y_ee z_ee q1 q2 q3 

[theta, R, ~, ~, l_A, ~, ~, l_B, ~, ~, ~] = Parameters_DELTA;

% System of equations

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





