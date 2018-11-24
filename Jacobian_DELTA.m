function [J, dJ] = Jacobian_DELTA(ee, q)
% Give back Jacobian matrix and its derivative

% Initialize matrices
S = nan(3);
B = nan(3);
dB = nan(3);
dS = nan(3);

for i=1:3
    % Rotation matrix from base plate frame to i-joint frame 
    R_b = R_base(theta(i));
    
    % Matrix with s_i vectors as columns
    S(:,i) = ee - R_b*([R 0 0]' - l_A*[cos(q(i)), 0, sin(q(i))]');
    
    % Matrix with b_i vectors as columns
    B(:,i) = R_b*l_A*[-sin(q(i)), 0, cos(q(i))]';
    
    % Matrix with db_i vectors as columns
    dB(:,i) = R_b*l_A*[-cos(q(i)); 0; -sin(q(i))];
    
    % Matrix with ds_i vectors as columns
    dS(:,i) = ee - R_b*l_A*[-sin(q(i)), 0, cos(q(i))]';
end

% Jacobian
J = S'\diag(diag(S'*B));

% Jacobian derivative
dSB = diag(diag(dS'*B)) + diag(diag(S'*dB)); 
dJ = S'\(-dS'*J + dSB);
end