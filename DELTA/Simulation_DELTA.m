close all

[theta, R, m_b, m_br, l_A, r_Gb, m_fb, l_B, m_n, m_nt, I_bi] = Parameters_DELTA;

l_BP = R*sqrt(3);
a_BP = 2;
h_BP = 0.05;
color_BP = [0 .8 .3];

% Plot base platform
X = [l_BP/2  0  -l_BP/2]; 
Y = [-R      R      -R];
Z = [a_BP    a_BP   a_BP]; 
BP1 = fill3(X, Y, Z, color_BP);
hold on
BP2 = fill3(X, Y, Z+h_BP, color_BP);

Face2 = [l_BP/2 -R a_BP; l_BP/2 -R a_BP+h_BP; -l_BP/2 -R a_BP+h_BP; -l_BP/2 -R a_BP];
BP3 = fill3(Face2(:,1),Face2(:,2),Face2(:,3), color_BP);

Face3 = [l_BP/2 -R a_BP; l_BP/2 -R a_BP+h_BP; -l_BP/2 -R a_BP+h_BP; -l_BP/2 -R a_BP];
BP3 = fill3(Face3(:,1),Face3(:,2),Face3(:,3), color_BP);

grid on
axis equal
% [1 1 1 1];
% [0 1 1 0]; 
% [0 0 1 1];
% 
% [0 0 1 1];
% [0 1 1 0];
% [0 0 0 0];

