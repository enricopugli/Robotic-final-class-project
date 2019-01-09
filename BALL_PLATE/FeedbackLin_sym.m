clear all

x = sym('x', [8 1], 'real'); % states
syms tau1 tau2; % inputs
syms m_b r_b I_b l_p I_p g;

% Lagrangian dynamic formulation
B12 = m_b + I_b/(r_b)^2;
B34 = [I_p + I_b + m_b*(x(1))^2,    m_b*x(1)*x(2)    ;
           m_b*x(1)*x(2)   , I_p + I_b + m_b*(x(2))^2]; 
B = blkdiag(B12,B12,B34);

C = m_b*[       0,           0,          -x(7)*x(1),            -x(7)*x(2);
                0,           0,          -x(8)*x(1),            -x(8)*x(2); 
         2*x(7)*x(1),       0,                0    ,       x(5)*x(2) + x(6)*x(1);
                0,    2*x(8)*x(2), x(5)*x(2) + x(6)*x(1),           0];

G = m_b*g*[sin(x(3)); sin(x(4)); x(1)*cos(x(3)); x(2)*cos(x(4))];

% Affine-in-control formulation 
f = [x(5:8); -B\(C*x(5:8) + G)];
H = [0 0; 0 0; 1 0; 0 1];
g1 = [zeros([4,1]); B\H(:,1)];
g2 = [zeros([4,1]); B\H(:,2)];

%%
            
y1 = x(1);
dy1 = jacobian(y1,x)*f;
ddy1 = jacobian(dy1,x)*f;
dddy1 = jacobian(ddy1,x)*f + jacobian(ddy1,x)*g1 + jacobian(ddy1,x)*g2;

y2 = x(2);
dy2 = jacobian(y2,x)*f;
ddy2 = jacobian(dy2,x)*f;
dddy2 = jacobian(ddy2,x)*f + jacobian(ddy2,x)*g1 + jacobian(ddy2,x)*g2;

%%

E = [jacobian(ddy1,x)*g1, jacobian(ddy1,x)*g2;
     jacobian(ddy2,x)*g1, jacobian(ddy2,x)*g2];

E_eq = subs(E, [x(3), x(4), x(5), x(6), x(7), x(8)], [0; 0; 0; 0; 0; 0]') 
 