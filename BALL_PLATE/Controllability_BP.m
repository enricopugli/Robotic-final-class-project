%% Model with input cooridinate change

tic
syms B g;

x = sym('x', [8 1], 'real'); % states

f = [x(5:8); 
     B*(x(7)*x(8)*x(2) + x(1)*x(7)^2 - g*sin(x(3))); 
     B*(x(7)*x(8)*x(1) + x(2)*x(8)^2 - g*sin(x(4)));
     0;
     0];

g1 = [0; 0; 0; 0; 0; 0; 1; 0];
g2 = [0; 0; 0; 0; 0; 0; 0; 1];

%% Simplified model with coordinate change: 
tic
syms B g;

x = sym('x', [8 1], 'real'); % states

f = [x(5:8); 
     B*(x(1)*x(7)^2 - g*sin(x(3))); 
     B*(x(2)*x(8)^2 - g*sin(x(4)));
     0;
     0];

g1 = [0; 0; 0; 0; 0; 0; 1; 0];
g2 = [0; 0; 0; 0; 0; 0; 0; 1];
load('E_diagonal_form_of_Q.mat'); % matrice E dopo inversione delle righe

%%
ad_fng1 = liebracket(f,g1,x,7);

%%
ad_fng2 = liebracket(f,g2,x,7);

%%
Q = [ad_fng1, ad_fng2];
load('E_diagonal_form_of_Q.mat'); % matrice E dopo inversione delle righe
%% Columns and row swapping for original model
% Q_swap = [Q(:,7),Q(:,2:6),Q(:,1),Q(:,8:16)];
% Q_swap = [Q_swap(:,1:7),Q_swap(:,9),Q_swap(:,8),Q_swap(:,10:16)];
% Q_swap = [Q_swap(:,1:3),Q_swap(:,10),Q_swap(:,5:9),Q_swap(:,4), Q_swap(:,11:16)];
% Q_swap = [Q_swap(:,3),Q_swap(:,1:2),Q_swap(:,4:16)];

%% Analisi della matrice E

E_det_el = diag(E);

