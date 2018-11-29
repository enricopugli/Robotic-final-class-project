function R_b = R_base(theta) 
% Rotation from base plate to ith motor frame
R_b = [cos(theta)  -sin(theta) 0;
       sin(theta)  cos(theta) 0;
          0           0      1];
end