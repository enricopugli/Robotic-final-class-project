A1 = [0 1 0;
      0 0 1;
      0 0 0];

A = blkdiag(A1,A1);

B = [0 0;
     0 0;
     1 0;
     0 0;
     0 0;
     0 1];
 
C = [1 0 0 0 0 0;
     0 0 0 1 0 0];

D = zeros(2,2);
 
sys_MIMO = ss(A,B,C,D);

tf_1 = tf(sys_MIMO);


x = sym('x', [8 1], 'real'); % states
syms tau1 tau2; % inputs
syms m_b r_b I_b l_p I_p;
% Lagrangian dynamic formulation
B12 = m_b + I_b/(r_b)^2;
B34 = [I_p + I_b + m_b*(x(1))^2,    m_b*x(1)*x(2)    ;
           m_b*x(1)*x(2)   , I_p + I_b + m_b*(x(2))^2]; 
B = blkdiag(B12,B12,B34);

C = m_b*[       0,           0,          -x(7)*x(1),            -x(7)*x(2);
                0,           0,          -x(8)*x(1),            -x(8)*x(2); 
         2*x(7)*x(1),       0,                0    ,       x(5)*x(2) + x(6)*x(1);
                0,    2*x(8)*x(2), x(5)*x(2) + x(6)*x(1),           0];
