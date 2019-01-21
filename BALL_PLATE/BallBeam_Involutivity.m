% Ball and plate:

syms B;

x = sym('x', [4 1], 'real'); % states

f = [x(3:4); 
     B*(x(1)*x(4)^2 - g*sin(x(2))); 
     0];

g = [0; 0; 0; 1];

%%
ad_fg = liebracket(f,g,x,2)

%%
adgad2fg =jacobian(ad_fg(:,3),x)*g - jacobian(g,x)*ad_fg(:,3);
