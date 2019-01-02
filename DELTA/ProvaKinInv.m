[theta, R, m_b, m_br, l_A, r_Gb, m_fb, l_B, m_n, m_nt, I_bi] = Parameters_DELTA;

z_ee = -sqrt(4 - (1/sqrt(2) + R)^2) - 1/sqrt(2);
z_ee
ee = [0 , 0, z_ee]';

q = InvKin_DELTA(ee)