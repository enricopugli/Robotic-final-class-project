p_in = [0.12; 0.12; -.3];
p_end = [0; 0; -.4];

v_in = zeros(3,1);
v_end = zeros(3,1);

q_in = InvKin_DELTA(p_in);
q_end = InvKin_DELTA(p_end);

tf= .5;

param_traj = nan(4,3);

for i=1:3
    
    c = [q_in(i); q_end(i); v_in(i); v_end(i)];

    A = [0,    0,    0,   1;
         0,    0,    1,   0;
         tf^3, tf^2, tf,  1;
         3*tf, 2*tf, 1,   0];

    param_traj(:,i) = A\c; 

end

dq_param_traj = [3*param_traj(1,:); 2*param_traj(2,:); param_traj(3,:)];
ddq_param_traj = [6*param_traj(1,:); 2*param_traj(2,:)];
    
filename = 'param_traj';
save(filename, 'param_traj', 'dq_param_traj', 'ddq_param_traj');
