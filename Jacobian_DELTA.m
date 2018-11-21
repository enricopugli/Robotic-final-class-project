function J = Jacobian_DELTA(ee, q)

% Load Delta robot parameters
Parameters;

% Base plate fixed rotation matrix

s = nan(3);
for i=1:3
    for j=1:3
        R_b = R_base(theta(i));
        s(i,j) = ee - R_b*([R 0 0]' - [l_a*cos(q(i)) 0 l_a*sin(q(i))]');
    end
end

% Jacobian
J = [s1'; s2'; s3']*diag([s1'*b1 s2'*b2 s2'*b3]);

end