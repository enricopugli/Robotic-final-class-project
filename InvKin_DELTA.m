function q = InvKin_DELTA(ee)
%Computation of the inverse kinematic of the Delta robot

% Loading parameters
[theta, R, ~, ~, l_A, ~, ~, l_B, ~, ~, ~] = Parameters_DELTA;

R_b1 = R_base(theta(1));
R_b2 = R_base(theta(2));
R_b3 = R_base(theta(3));
p = [R_b1*ee, R_b2*ee, R_b3*ee]; 
q = nan(3,1);

for li=1:3
    
    x0 = p(1,li);
    y0 = p(2,li);
    z0 = p(3,li);
    A = l_A^2 - l_B^2 - R^2 + x0^2 + y0^2 + z0^2;
    B = 2*x0 - 2*R;

    a = 4*z0^2 + B^2;
    b = 4*R*z0^2 + A*B;
    c = A^2 + 4*R^2*z0^2 - 4*l_A^2*z0^2;
        
    x = (b + sqrt(b^2 - a*c))/a; 
    
    z = (A - B*x)/(2*z0);
    
    q(li) = - asin(z/l_A); 
    
    if x-R < 0
        q(li) = pi - q(li);
    end
end

end

