% Ball and plate:

syms B g;

x = sym('x', [8 1], 'real'); % states

f = [x(5:8); 
     B*(x(7)*x(8)*x(2) + x(1)*x(7)^2 - g*sin(x(3))); 
     B*(x(7)*x(8)*x(1) + x(2)*x(8)^2 - g*sin(x(4)));
     0;
     0];

g1 = [0; 0; 0; 0; 0; 0; 1; 0];
g2 = [0; 0; 0; 0; 0; 0; 0; 1];

%%
ad_fg1 = liebracket(f,g1,x,6);
ad_fg2 = liebracket(f,g2,x,6);

%%
adgad1fg1 =jacobian(ad_fg1(:,2),x)*g1 - jacobian(g1,x)*ad_fg1(:,2);
adgad2fg1 =jacobian(ad_fg1(:,3),x)*g1 - jacobian(g1,x)*ad_fg1(:,3);
adgad3fg1 =jacobian(ad_fg1(:,4),x)*g1 - jacobian(g1,x)*ad_fg1(:,4);
adgad4fg1 =jacobian(ad_fg1(:,5),x)*g1 - jacobian(g1,x)*ad_fg1(:,5);
adgad5fg1 =jacobian(ad_fg1(:,6),x)*g1 - jacobian(g1,x)*ad_fg1(:,6);
adgad6fg1 =jacobian(ad_fg1(:,7),x)*g1 - jacobian(g1,x)*ad_fg1(:,7);

adgad1fg2 =jacobian(ad_fg2(:,2),x)*g2 - jacobian(g2,x)*ad_fg2(:,2);
adgad2fg2 =jacobian(ad_fg2(:,3),x)*g2 - jacobian(g2,x)*ad_fg2(:,3);
adgad3fg2 =jacobian(ad_fg2(:,4),x)*g2 - jacobian(g2,x)*ad_fg2(:,4);
adgad4fg2 =jacobian(ad_fg2(:,5),x)*g2 - jacobian(g2,x)*ad_fg2(:,5);
adgad5fg2 =jacobian(ad_fg2(:,6),x)*g2 - jacobian(g2,x)*ad_fg2(:,6);
adgad6fg2 =jacobian(ad_fg2(:,7),x)*g2 - jacobian(g2,x)*ad_fg2(:,7);
