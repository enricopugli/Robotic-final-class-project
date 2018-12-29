clear x B C G tau1 tau2;
clc

% Parameters:
[m_b, r_b, I_b, l_p, I_p] = Parameters_BP;

% Symbolic variables:
x = sym('x', [8 1], 'real'); % states
syms tau1 tau2; % inputs

% Lagrangian dynamic formulation
[B, C, G] = BCG_BP(x(1:4), x(5:8));

% Affine-in-control formulation 
f = [x(5:8); -B\(C*x(5:8) + G)];
H = [0 0; 0 0; 1 0; 0 1];
g1 = [zeros([4,1]); B\H(:,1)];
g2 = [zeros([4,1]); B\H(:,2)];

%% Nonlinear controllability
tic
fprintf('\n## 1');
LieBr0r = g1;
LieBr1r = g2;
fprintf('\n## 2');
LieBr2r = jacobian(g1,x)*f - jacobian(f,x)*g1;
fprintf('\n## 3');
LieBr3r = jacobian(LieBr2r,x)*f - jacobian(f,x)*LieBr2r;
fprintf('\n## 4');
LieBr4r = jacobian(LieBr3r,x)*f - jacobian(f,x)*LieBr3r;
fprintf('\n## 5');
LieBr5r = jacobian(LieBr4r,x)*f - jacobian(f,x)*LieBr4r;
fprintf('\n## 6');
LieBr6r = jacobian(LieBr5r,x)*f - jacobian(f,x)*LieBr5r;
fprintf('\n## 7');
LieBr7r = jacobian(LieBr6r,x)*f - jacobian(f,x)*LieBr6r;
fprintf('\n## 8');
LieBr8r = jacobian(LieBr7r,x)*f - jacobian(f,x)*LieBr7r;
toc
%%

% ad_fng1 = liebracket(f,g1,x,8);