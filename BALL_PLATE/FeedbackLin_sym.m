clear all
clc

% Parameters:
% [m_b, r_b, I_b, l_p, I_p] = Parameters_BP;
% g = 9.81;
syms m_b r_b I_b l_p I_p g;

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
% B1 = m_b/(I_b/r_b^2 + m_b);
syms B1;
f1 = [x(5:8); 
      B1*(x(1)*x(7)^2 - g*sin(x(3))); 
      B1*(x(2)*x(8)^2 - g*sin(x(4)));
      0;
      0];

g1 = [zeros([6,1]); u1; 0];
g2 = [zeros([6,1]); 0; u1];
  
%% Approximated Feedback linearization of the simplified system
            
y1 = x(1);
dy1 = jacobian(y1,x)*f1;
ddy1 = jacobian(dy1,x)*f1;
dddy1 = jacobian(ddy1,x)*f1; % + jacobian(ddy1,x)*g1 + jacobian(ddy1,x)*g2; 
ddddy1 = jacobian(dddy1,x)*f1 + jacobian(dddy1,x)*g1 + jacobian(dddy1,x)*g2;

y2 = x(2);
dy2 = jacobian(y2,x)*f1;
ddy2 = jacobian(dy2,x)*f1;
dddy2 = jacobian(ddy2,x)*f1; % + jacobian(ddy2,x)*g1 + jacobian(ddy2,x)*g2;
ddddy2 = jacobian(dddy2,x)*f1 + jacobian(dddy2,x)*g1 + jacobian(dddy2,x)*g2;

%% Stabilization via pole placement

Afl = blkdiag(diag(ones(3,1),1), diag(ones(3,1),1));
Bfl = [zeros(3,2);
       1, 0; 
       zeros(3,2);
       0, 1];
Cfl = [1, zeros(1,7);
       zeros(1,4),1,zeros(1,3)];
Dfl = zeros(2);   
       
% stable_poles = -[1,2,3,4,5,6,7,8];
% 
% K = place(Afl, Bfl, stable_poles);
% 
% S = ss(Afl - Bfl*K, Bfl, Cfl, Dfl);
% 
% PID = -.25;
% 
% L = PID*S;
% 
% Fp = feedback(L,eye(2));

Sfl = ss(Afl, Bfl, Cfl, Dfl);

tf_fl = tf(Sfl);

%% Controllo primo sistema disaccoppiato
Afl1 = diag(ones(3,1),1);
Bfl1 = [zeros(3,1);
       1];
Cfl1 = [1, zeros(1,3)];
Dfl1 = 0;

Sfl1 = ss(Afl1, Bfl1, Cfl1, Dfl1);
tf_fl1 = tf(Sfl1);

stable_poles1 = -[1, 2, 3, 4];

K1 = place(Afl1, Bfl1, stable_poles1);

S1 = ss(Afl1 - Bfl1*K1, Bfl1, Cfl1, Dfl1);

tf_fl1_stab = tf(S1);
