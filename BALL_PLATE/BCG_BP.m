function [B, C, G] = BCG_BP(q, dq)

[m_b, r_b, I_b, ~, I_p] = Parameters_BP;

g = 9.81;

% Mass matrix
B12 = m_b + I_b/(r_b)^2;
B34 = [I_p + I_b + m_b*(q(1))^2,    m_b*q(1)*q(2)    ;
           m_b*q(1)*q(2)   , I_p + I_b + m_b*(q(2))^2]; 
B = blkdiag(B12,B12,B34);

% Coriolis elements matrix
C = m_b*[       0,           0,          -dq(3)*q(1),            -dq(3)*q(2);
                0,           0,          -dq(4)*q(1),            -dq(4)*q(2); 
         2*dq(3)*q(1),       0,                0    ,       dq(1)*q(2) + dq(2)*q(1);
                0,    2*dq(4)*q(2), dq(1)*q(2) + dq(2)*q(1),           0];

% Gravitational elements matrix
G = m_b*g*[sin(q(3)); sin(q(4)); q(1)*cos(q(3)); q(2)*cos(q(4))];

end
