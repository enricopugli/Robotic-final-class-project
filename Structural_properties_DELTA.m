close all;
clear A B C D;

[A, B, C, D] = linmod('DELTA_model');

sys_mimo_DELTA = ss(A,B,C,D);

% Controllability
Co = ctrb(A,B);

if rank(Co) == length(A) 
   fprintf('\nThe linearized system is fully controllable, so it is the non-linear system');
end    

% Observability
Ob = obsv(A,C);

if rank(Ob) == length(A)
   fprintf('\nThe linearized system is fully observable, so it is the non-linear system\n');
end 
