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
%%
% syms B g;
% 
% x = sym('x', [8 1], 'real'); % states
% 
% f = [x(5:8); 
%      B*(x(1)*x(7)^2 - g*sin(x(3))); 
%      B*(x(2)*x(8)^2 - g*sin(x(4)));
%      0;
%      0];
% 
% g1 = [0; 0; 0; 0; 0; 0; 1; 0];
% g2 = [0; 0; 0; 0; 0; 0; 0; 1];
% 
h1 = [x(1), zeros(1,7)];
h2 = [0, x(2), zeros(1,6)];
h = [x(1); x(2)];
%%
% ad_fnh1 = liebracket(f,h1,x,7);
% 
% ad_fnh2 = liebracket(f,h2,x,7);
% 
% ad_fnh3 = liebracket(f,h3,x,7);
% 
% ad_fnh4 = liebracket(f,h4,x,7);

%%
% O = [ad_fnh1, ad_fnh2, ad_fnh3, ad_fnh4];

O = h;
for i=3:2:15
O = [O;jacobian(O(i-2:i-1),x)*f];
end

Og1 = jacobian(O(1:2),x)*g1;

for i=3:2:15
Og1 = [Og1;jacobian(O(i:i+1),x)*g1];
end

Og2 = jacobian(O(1:2),x)*g2;

for i=3:2:15
Og2 = [Og2;jacobian(O(i:i+1),x)*g2];
end

O = [O; Og1; Og2];


%%
dO = jacobian(O,x);
dO18 = dO(1:8,1:8);
E = [dO18(:,1:2),dO18(:,5:6),dO18(:,3:4),dO18(:,7:8)];

%%

