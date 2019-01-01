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

%% Lie brackets
tic
fprintf('\n## 1');
LieBr0r = g1;
fprintf('\n## 2');
LieBr2r = jacobian(g1,x)*f - jacobian(f,x)*g1;
fprintf('\n## 3');
LieBr4r = jacobian(LieBr2r,x)*f - jacobian(f,x)*LieBr2r;
fprintf('\n## 4');
LieBr6r = jacobian(LieBr4r,x)*f - jacobian(f,x)*LieBr4r;

fprintf('\n## 5');
LieBr1r = g2;
fprintf('\n## 6');
LieBr3r = jacobian(g2,x)*f - jacobian(f,x)*g2;
fprintf('\n## 7');
LieBr5r = jacobian(LieBr3r,x)*f - jacobian(f,x)*LieBr3r;
fprintf('\n## 8\n');
LieBr7r = jacobian(LieBr5r,x)*f - jacobian(f,x)*LieBr5r;

LieBr8r = f;
toc

%% Nonlinear controllability
% Accessibility distribution:
R_matrix = [LieBr0r  LieBr1r  LieBr2r  LieBr3r LieBr4r  LieBr5r  LieBr6r  LieBr8r];
% rank(R_matrix) = 8 --> the system is accessible
rank(R_matrix)

R1_matrix = [LieBr0r  LieBr1r  LieBr2r  LieBr3r LieBr4r  LieBr5r  LieBr6r  LieBr7r];
% rank(R1_matrix) = 8 --> the system is strongly accessible
rank(R1_matrix)

%%
% ad_fng1 = liebracket(f,g1,x,8);