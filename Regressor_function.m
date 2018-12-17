function Y = Regressor_function(q, dq_r, ddq_r, ee)

[J, dJ] = Jacobian_DELTA(ee,q);

G = [0; 0; -9.81];

Y = [J'*(G + J*ddq_r + dJ*dq_r), ddq_r, G.*cos(q)];

end