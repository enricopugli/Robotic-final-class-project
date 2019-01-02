function ee = fun_DirKin_Clavel(q)

[theta, R, ~, ~, l_A, ~, ~, l_B, ~, ~, ~] = Parameters_DELTA;

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
    -E(1)*F(2) + E(1)*F(3) + E(2)*F(1) - E(2)*F(3) - E(3)*F(1) + E(3)*F(2);
    -E(1)*D(2) + E(1)*D(3) + E(2)*D(1) - E(2)*D(3) - E(3)*D(1) + E(3)*D(2);
     F(1)*D(2) - F(1)*D(3) - F(2)*D(1) + F(2)*D(3) + F(3)*D(1) - F(3)*D(2);
    -F(1)*G(2) + F(1)*G(3) + F(2)*G(1) - F(2)*G(3) - F(3)*G(1) + F(3)*G(2)];

L = (H(5)^2 + H(1)^2)/H(2)^2 + 1;

M = 2*(H(5)*H(4) + H(1)*H(3))/H(2)^2 - (H(5)*E(1) + H(1)*F(1))/H(2) - G(1);

N = (H(4)^2 + H(3)^2)/H(2)^2 - (H(4)*E(1) + H(3)*F(1))/H(2) + D(1);

ee = nan(3,1);
ee2 = nan(3,1);

ee(3) = (-M + sqrt(M^2 - 4*L*N))/(2*L);

ee(1) = ee(3)*H(5)/H(2) + H(4)/H(2);

ee(2) = ee(3)*H(1)/H(2) + H(3)/H(2);

ee2(3) = (-M - sqrt(M^2 - 4*L*N))/(2*L);

ee2(1) = ee2(3)*H(5)/H(2) + H(4)/H(2);

ee2(2) = ee2(3)*H(1)/H(2) + H(3)/H(2);
 


% if ee2(3) < 0 
%     ee = ee2;
% end

if ee(3) > ee2(3)
    ee = ee2;
end

end