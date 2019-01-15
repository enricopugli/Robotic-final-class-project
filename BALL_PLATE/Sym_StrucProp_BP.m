clear all
clc

% Parameters:
[m_b, r_b, I_b, l_p, I_p] = Parameters_BP;
g = 9.81;

% Symbolic variables:
x = sym('x', [8 1], 'real'); % states
syms u1 u2; % inputs

% Lagrangian dynamic formulation
[B, C, G] = BCG_BP(x(1:4), x(5:8));

% Affine-in-control formulation 
f = [x(5:8); -B\(C*x(5:8) + G)];
H = [0 0; 0 0; 1 0; 0 1];
g1 = [zeros([4,1]); B\H(:,1)];
g2 = [zeros([4,1]); B\H(:,2)];

%% Simplified system
B1 = m_b/(I_b/r_b^2 + m_b);
f1 = [x(5:8); 
      B1*(x(1)*x(7)^2 - g*sin(x(3))); 
      B1*(x(2)*x(8)^2 - g*sin(x(4)));
      0;
      0];

%% Linearized system
xeq = zeros(1,8);
H_ = [0 0; 0 0; u1 0; 0 u2];
g1_ = [zeros([4,1]); B\H_(:,1)];
g2_ = [zeros([4,1]); B\H_(:,2)];

Alin = jacobian(f,x) + jacobian(g1_,x) + jacobian(g2_,x) ;
Alin = double(subs(Alin, [x(1), x(2), x(3), x(4), x(5), x(6), x(7), x(8), u1, u2], zeros(1,10)));

Blin = jacobian(g1_, [u1;u2]) + jacobian(g2_, [u1;u2]);
Blin = double(subs(Blin, [x(1), x(2), x(3), x(4), x(5), x(6), x(7), x(8), u1, u2], zeros(1,10)));

Clin = [eye(2); zeros(6,2)]';

Dlin = zeros(2);

Co = ctrb(Alin,Blin);
disp(Co)
rank(Co)

%% Control of the linearized system

% K = place(Alin, Blin, -[1000,1100,1300,1400,1500,1600,1700,1800]);
K = place(Alin, Blin, -[1,2,3,4,5,6,7,8]);

S = ss(Alin - Blin*K, Blin, Clin, Dlin);

PID = -.25;

L = PID*S;

Fp = feedback(L,eye(2));

step(Fp)
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
R_matrix = [LieBr0r  LieBr1r  LieBr2r  LieBr3r LieBr4r  LieBr5r  LieBr6r  LieBr8r];
% rank(R_matrix) = 8 --> the system is strongly accessible

R_eq = subs(R_matrix, [x(3), x(4), x(5), x(6)], zeros(1,4));

%% Lie brackets simplified system
tic
fprintf('\n## 1');
LieBrSim0r = g1;
fprintf('\n## 2');
LieBrSim2r = jacobian(g1,x)*f1 - jacobian(f1,x)*g1;
fprintf('\n## 3');
LieBrSim4r = jacobian(LieBr2r,x)*f1 - jacobian(f1,x)*LieBr2r;
fprintf('\n## 4');
LieBrSim6r = jacobian(LieBr4r,x)*f1 - jacobian(f1,x)*LieBr4r;

fprintf('\n## 5');
LieBrSim1r = g2;
fprintf('\n## 6');
LieBrSim3r = jacobian(g2,x)*f1 - jacobian(f1,x)*g2;
fprintf('\n## 7');
LieBrSim5r = jacobian(LieBr3r,x)*f1 - jacobian(f1,x)*LieBr3r;
fprintf('\n## 8\n');
LieBrSim7r = jacobian(LieBr5r,x)*f1 - jacobian(f1,x)*LieBr5r;

LieBrSim8r = f1;
toc

%% Nonlinear controllability
R1_matrix = [LieBrSim0r  LieBrSim1r  LieBrSim2r  LieBrSim3r LieBrSim4r  LieBrSim5r  LieBrSim6r LieBrSim6r LieBrSim7r LieBrSim8r];
% rank(R_matrix) = 8 --> the system is strongly accessible

R1_eq = subs(R1_matrix, [x(3), x(4), x(5), x(6), x(7), x(8)], zeros(1,6));

rank(R1_eq)
%% Nonlinear observability

dH = [[1 0 0 0 0 0 0 0]', [0 1 0 0 0 0 0 0]', [0 0 0 0 1 0 0 0]', [0 0 0 0 0 1 0 0]'];
dH1 = dH(:,1);
dH2 = dH(:,2);
dH3 = dH(:,3);
dH4 = dH(:,4);

LieBrOb5 = jacobian(dH1,x)*f + jacobian(f,x)*dH1;
LieBrOb6 = jacobian(dH2,x)*f + jacobian(f,x)*dH2;
LieBrOb7 = jacobian(dH3,x)*f + jacobian(f,x)*dH3;
LieBrOb8 = jacobian(dH4,x)*f + jacobian(f,x)*dH4;

LieBrOb9 = jacobian(dH1,x)*g1 + jacobian(g1,x)*dH1;
LieBrOb10 = jacobian(dH2,x)*g1 + jacobian(g1,x)*dH2;
LieBrOb11 = jacobian(dH3,x)*g1 + jacobian(g1,x)*dH3;
LieBrOb12 = jacobian(dH4,x)*g1 + jacobian(g1,x)*dH4;

LieBrOb13 = jacobian(dH1,x)*g2 + jacobian(g2,x)*dH1;
LieBrOb14 = jacobian(dH2,x)*g2 + jacobian(g2,x)*dH2;
LieBrOb15 = jacobian(dH3,x)*g2 + jacobian(g2,x)*dH3;
LieBrOb16 = jacobian(dH4,x)*g2 + jacobian(g2,x)*dH4;

LieBrOb17 = jacobian(LieBrOb9,x)*f + jacobian(f,x)*LieBrOb9;
LieBrOb18 = jacobian(LieBrOb10,x)*f + jacobian(f,x)*LieBrOb10;
LieBrOb19 = jacobian(LieBrOb11,x)*f + jacobian(f,x)*LieBrOb11;
LieBrOb20 = jacobian(LieBrOb12,x)*f + jacobian(f,x)*LieBrOb12;


Ob_matrix = [dH LieBrOb5 LieBrOb6 LieBrOb7 LieBrOb8 LieBrOb9 LieBrOb10 LieBrOb11 LieBrOb12 LieBrOb13 LieBrOb14 LieBrOb15 LieBrOb16 LieBrOb17 LieBrOb18 LieBrOb19 LieBrOb20];

rank(Ob_matrix)

% rank = 8 taking 1:6 + 17:18 columns

%% Feedback linearization control

y1 = x(1);
dy1 = jacobian(y1,x)*f;
ddy1 = jacobian(dy1,x)*f;
dddy1 = jacobian(ddy1,x)*f + jacobian(ddy1,x)*g1 + jacobian(ddy1,x)*g2;

y2 = x(2);
dy2 = jacobian(y2,x)*f;
ddy2 = jacobian(dy2,x)*f;
dddy2 = jacobian(ddy2,x)*f + jacobian(ddy2,x)*g1 + jacobian(ddy2,x)*g2;

% grado relativo totale r = 6 ==> n-r=2
