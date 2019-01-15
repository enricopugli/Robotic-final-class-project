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

%%
ad_fng1 = liebracket(f,g1,x,7);

%%
ad_fng2 = liebracket(f,g2,x,7);

%%
Q = [ad_fng1, ad_fng2];

