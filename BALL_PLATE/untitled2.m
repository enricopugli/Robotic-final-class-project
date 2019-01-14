% load('E_diagonal_form_of_Q.mat');
% 
% syms x1 x2 x3 x4 x5 x6 x7 x8;
% 
% sol1 = solve(det_E == 0, x1)
% sol2 = solve(det_E == 0, x2)
% sol3 = solve(det_E == 0, x3)

PID = 10;

L = PID*S;

Fp = feedback(L,eye(2));

step(Fp);