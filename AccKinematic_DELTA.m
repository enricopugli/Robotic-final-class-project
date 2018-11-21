function ddee = AccKinematic_DELTA(ee, q, dq, ddq) 

% dee is called ddXn the reference text 

dq1 = dq(1);
dq2 = dq(2);
dq3 = dq(3);

s = nan(3);
for i=1:3
    for j=1:3
        R_b = R_base(theta(i));
        s(i,j) = ee - R_b*([R 0 0]' - [l_a*cos(q(i)) 0 l_a*sin(q(i))]');
    end
end

[J, s, b, db] = Jacobian_DELTA(ee, q);

s1 = s(1,:)';
s2 = s(2,:)';
s3 = s(3,:)';

b1 = b(1,:)';
b2 = b(2,:)';
b3 = b(3,:)';

db1 = db(1,:)';
db2 = db(2,:)';
db3 = db(3,:)';

dee = J*ddq;

ds1 = dee - b1*dq1;
ds2 = dee - b2*dq2;
ds3 = dee - b3*dq3;

ddee = [s1'; s2'; s3']\(-[ds1'; ds2'; ds3']*J + diag([ds1'*b1 + s1'*db1; ds2'*b2 + s2'*db2; ds3'*b3 + s3'*db3])); 

end

