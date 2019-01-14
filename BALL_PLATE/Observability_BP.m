
syms B g;

x = sym('x', [8 1], 'real'); % states

f = [x(5:8); 
     B*(x(1)*x(7)^2 - g*sin(x(3))); 
     B*(x(2)*x(8)^2 - g*sin(x(4)));
     0;
     0];

g1 = [0; 0; 0; 0; 0; 0; 1; 0];
g2 = [0; 0; 0; 0; 0; 0; 0; 1];

h1 = [x(1), zeros(1,7)];
h2 = [0, x(2), zeros(1,6)];

%%
ad_fnh1 = liebracket(f,h1,x,7);

%%
ad_fnh2 = liebracket(f,h2,x,7);

