
syms x_ee y_ee z_ee q1 q2 q3 l_A l_B R

% System of equations

eqns = [(x_ee - (cos(q1))*(l_A*cos(q1) + R))^2 + (y_ee + (R + l_A*cos(q1))*sin(q1))^2 + (z_ee + l_A*sin(q1))^2 - l_B^2 == 0,...
        (x_ee - (cos(q2))*(l_A*cos(q2) + R))^2 + (y_ee + (R + l_A*cos(q2))*sin(q2))^2 + (z_ee + l_A*sin(q2))^2 - l_B^2 == 0,...
        (x_ee - (cos(q3))*(l_A*cos(q3) + R))^2 + (y_ee + (R + l_A*cos(q3))*sin(q3))^2 + (z_ee + l_A*sin(q3))^2 - l_B^2 == 0,...
         q1 < pi/2,...
         q2 < pi/2,...
         q3 < pi/2,...
         z_ee < 0];

% Direct kinematic solution
fprintf('\n###############################\n')
fprintf('start solving direct kinematic \n')
fprintf('###############################\n')
tic
vars1 = [x_ee, y_ee, z_ee];
S = solve(eqns, vars1);
toc

% Inverse kinematic solution
% fprintf('start solving inverse kinematic \n')
% tic
% vars2 = [q1, q2, q3];
% [solq1, sloq2, sloq3] = solve(eqns, vars2);
% toc
% 
