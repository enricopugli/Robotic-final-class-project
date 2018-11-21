function [J, s, b, db] = Jacobian_DELTA(ee, q)

% Load Delta robot parameters
Parameters;

%
s = nan(3);
b = nan(3);
db = nan(3);

for i=1:3
    for j=1:3
        R_b = R_base(theta(i));
        s(i,j) = ee - R_b*([R 0 0]' - [l_a*cos(q(i)) 0 l_a*sin(q(i))]');
        b(i,j) = R_b*[l_a*sin(q(i)) 0 l_a*cos(q(i))]';
        db(i,j) = R_b*[-l_a*cos(q(i)); 0; -l_a*sin(q(i))];
    end
end

s1 = s(1,:)';
s2 = s(2,:)';
s3 = s(3,:)';

b1 = b(1,:)';
b2 = b(2,:)';
b3 = b(3,:)';

% Jacobian
J = [s1'; s2'; s3']*diag([s1'*b1 s2'*b2 s2'*b3]);

end