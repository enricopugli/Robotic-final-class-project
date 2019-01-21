clear all
clc

%% Model with input cooridinate change

tic
syms B g;

x = sym('x', [8 1], 'real'); % states

f = [x(5:8); 
     B*(x(7)*x(8)*x(2) + x(1)*x(7)^2 - g*sin(x(3))); 
     B*(x(7)*x(8)*x(1) + x(2)*x(8)^2 - g*sin(x(4)));
     0;
     0];

syms u1 u2; 
g1 = [0; 0; 0; 0; 0; 0; u1; 0];
g2 = [0; 0; 0; 0; 0; 0; 0; u2];

%% Simplified system
% % B1 = m_b/(I_b/r_b^2 + m_b);
% syms B1;
% f1 = [x(5:8); 
%       B1*(x(1)*x(7)^2 - g*sin(x(3))); 
%       B1*(x(2)*x(8)^2 - g*sin(x(4)));
%       0;
%       0];
% 
% g1 = [zeros([6,1]); u1; 0];
% g2 = [zeros([6,1]); 0; u1];


%% Feedback linearization of full system
            
y1 = x(1);
dy1 = jacobian(y1,x)*f;
ddy1 = jacobian(dy1,x)*f;
dddy1 = jacobian(ddy1,x)*f  + jacobian(ddy1,x)*g1 + jacobian(ddy1,x)*g2; 

y2 = x(2);
dy2 = jacobian(y2,x)*f;
ddy2 = jacobian(dy2,x)*f;
dddy2 = jacobian(ddy2,x)*f + jacobian(ddy2,x)*g1 + jacobian(ddy2,x)*g2;


%% Involutivity

ad_fng1 = liebracket(f,g1,x,6);
ad_fng2 = liebracket(f,g2,x,6);

invol = [ad_fng1, ad_fng2];
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

%% Stabilization via pole placement of the linearized system

% Afl = blkdiag(diag(ones(3,1),1), diag(ones(3,1),1));
% Bfl = [zeros(3,2);
%        1, 0; 
%        zeros(3,2);
%        0, 1];
% Cfl = [1, zeros(1,7);
%        zeros(1,4),1,zeros(1,3)];
% Dfl = zeros(2);   
       
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
% Afl1 = diag(ones(3,1),1);
% Bfl1 = [zeros(3,1);
%        1];
% Cfl1 = [1, zeros(1,3)];
% Dfl1 = 0;
% 
% Sfl1 = ss(Afl1, Bfl1, Cfl1, Dfl1);
% tf_fl1 = tf(Sfl1);
% 
% stable_poles1 = -[1, 2, 3, 4];
% 
% K1 = place(Afl1, Bfl1, stable_poles1);
% 
% S1 = ss(Afl1 - Bfl1*K1, Bfl1, Cfl1, Dfl1);
% 
% tf_fl1_stab = tf(S1);
