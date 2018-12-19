function Y = Regressor_function(q, dq_r, ddq_r, ee)

[J, dJ] = Jacobian_DELTA(ee,q);

g_vec = [0; 0; -9.81];
g = 9.81;

Y = [J'*(g_vec + J*ddq_r + dJ*dq_r), ddq_r, g*cos(q)];

end