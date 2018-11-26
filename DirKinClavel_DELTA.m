% Reference:
% Clavel, R. (1991). Conception d’un robot parallele rapide à 4 degres de liberté.

q = pi/4 * ones(3,1);

[theta, R, m_b, m_br, l_A, r_Gb, m_fb, l_B, m_n, m_nt, I_bi] = Parameters_DELTA;

D = nan(3,1);
E = nan(3,1);
F = nan(3,1);
G = nan(3,1);

for i = 1:3
   D(i) = -l_B^2 + l_A^2 + R^2 + 2*R*l_A*cos(q(i));
   
   E(i) = 2*(R + l_A*cos(q(i)))*cos(theta(i));
   
   F(i) = 2*(R + l_A*cos(q(i)))*sin(theta(i));
   
   G(i) = -2*l_A*sin(q(i)); 
end

H = [E(1)*G(2) - E(1)*G(3) - E(2)*G(1) + E(2)*G(3) + E(3)*G(1) - E(3)*G(2);
    -E(1)*F(2) + E(1)*F(3) + E(2)*F(1) - E(2)*F(3) - E(3)*F(1) + E(3)*G(2);
    -E(1)*D(1) + E(1)*D(3) + E(2)*D(1) - E(2)*D(3) - E(3)*D(1) + E(3)*D(2);
     F(1)*D(2) - F(1)*D(3) - F(2)*D(1) + F(2)*D(3) + F(3)*D(1) - F(3)*D(2);
    -F(1)*G(2) + F(1)*G(3) + F(2)*G(1) - F(2)*G(3) - F(3)*G(1) + F(3)*G(2)];

L = (H(5)^2 + H(1)^2)/H(2)^2 + 1;

M = 2*(H(5)*H(4) + H(1)*H(3))/H(2)^2 - (H(5)*E(1) + H(1)*F(1))/H(2) + G(1);

N = 2*(H(4)^2 + H(3)^2)/H(2)^2 - (H(4)*E(1) + H(3)*F(1))/H(2) + D(1);

ee1 = nan(3,1);
ee2 = nan(3,1);

ee1(3) = (-M + sqrt(M^2 - 4*L*N))/(2*L);

ee1(1) = ee1(3)*H(5)/H(2) + H(4)/H(2);

ee1(2) = ee1(3)*H(1)/H(2) + H(3)/H(2);

ee2(3) = (-M - sqrt(M^2 - 4*L*N))/(2*L);

ee2(1) = ee2(3)*H(5)/H(2) + H(4)/H(2);

ee2(2) = ee2(3)*H(1)/H(2) + H(3)/H(2);