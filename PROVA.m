[theta, R, m_b, m_br, l_A, r_Gb, m_fb, l_B, m_n, m_nt, I_bi] = Parameters_DELTA;

% Lancia la simulazione con il controllo PD
sim('PID_DELTA');

% Salvataggio di un valore delle q, dq e ddq
index = 120;
q_p = q(index,:)';
dq_p = dq(index,:)';
ddq_p = ddq(index,:)';

ee_p = fun_DirKin_Clavel(q_p);

[B, C , G, F] = BCG_DELTA(ee_p,q_p);

[J,dJ] = Jacobian_DELTA(ee_p,q_p);

g_vec = [0; 0; -9.81];
g = 9.81;

% Regressore:
Y = [J'*(g_vec + J*ddq_p + dJ*dq_p), ddq_p, g*cos(q_p)];

% Calcolo delle tau
tau1 = B*ddq_p + C*dq_p + F*dq_p + G

pi_vec = [m_nt; I_bi; r_Gb*m_br];

tau2 = Y*pi_vec + F*dq_p