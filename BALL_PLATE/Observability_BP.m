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
E18 = [dO18(:,1:2),dO18(:,5:6),dO18(:,3:4),dO18(:,7:8)];
E = [dO(:,1:2),dO(:,5:6),dO(:,3:4),dO(:,7:8)];

%%
E58 = E(:,5:8);
E_x1x200 = subs(E58, [x(1),x(2)], [0, 0]);
fprintf('0 0 ');
fprintf('################\n');
% 
% subs(E58, [x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8)], [0, 0, 0, pi/2, 0, 0, 0, 0]);
% detSUB = det(ans);
% fprintf('0 0 0 pi/2 0 0 0 0\n');
% disp(detSUB);
% fprintf('################\n');
% 
% subs(E58, [x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8)], [0, 0, pi/2, 0, 0, 0, 0, 0]);
% detSUB = det(ans);
% fprintf('0 0 pi/2 0 0 0 0 0\n');
% disp(detSUB);
% fprintf('################\n');
% 
subs(E58, [x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8)], [0, 0, 0, 0, 0, 0, 0, 0]);
detSUB = det(ans);
fprintf('0 0 0 0 0 0 0 0\n');
disp(detSUB);
fprintf('################\n');
% 
% subs(E58, [x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8)], [0, 0, 0, 0, g/2, 0, 1, 0]);
% detSUB = det(ans);
% fprintf('0 0 0 0 g/2 0 1 0\n');
% disp(detSUB);
% fprintf('################\n');
% 
% subs(E58, [x(1),x(2),x(3),x(4), x(5), x(6),x(7),x(8)], [0, 0, 0, 0, g, 0, 1, 0]);
% detSUB = det(ans);
% fprintf('0 0 0 0, g, 0 1 0\n');
% disp(detSUB);
% fprintf('################\n');
% 
% subs(E58, [x(1),x(2),x(3),x(4), x(5), x(6),x(7),x(8)], [0, 0, 0, 0, 0, g, 0, 1]);
% detSUB = det(ans);
% fprintf('0 0 0 0, 0, g, 0, 1\n');
% disp(detSUB);
% fprintf('################\n');
% 
% subs(E58, [x(1),x(2),x(3),x(4), x(5), x(6),x(7),x(8)], [0, 0, 0, 0, 0, g/2, 0, 1]);
% detSUB = det(ans);
% fprintf('0 0 0 0, 0, g/2, 0, 1\n');
% disp(detSUB);
% fprintf('################\n');
% 
% 
% subs(E58, [x(3),x(4)], [0, 0]);
% detSUB = det(ans);
% fprintf('x3 x4 0 0\n');
% disp(detSUB);
% fprintf('################\n');
% 
% ESUB = subs(E58, x(1), 0);
% detSUB = det(ESUB);
% fprintf('x1 0\n');
% disp(detSUB);
% fprintf('################\n');
%%
j = 1;
for i=1:6
    disp(j)
    E(j:j+7,5:8)
    j = j+8;
end    

j = 1;
for i=1:6
    disp(j)
    E_x1x200(j:j+7,1:4)
    j = j+8;
end    

%%
E_1 = [E(1:4,:);E(21:22,:);E(7:20,:);E(5:6,:);E(23:48,:)];
E_2 = [E(1:7,:);E(24,:);E(9:23,:);E(8,:);E(25:48,:)];

% con queste x1 = 0, x2=0;
E_3 = [E(21,5:8);E(22,5:8);E(23,5:8);E(6,5:8)];
E_4 = [E(37,5:8);E(38,5:8);E(5,5:8);E(40,5:8)];

% con queste x5 = 0, x6=0;
E58 = E(:,5:8);
E_x1x200 = subs(E58, [x(1),x(2)], [0, 0]);
fprintf('0 0 ');
fprintf('################\n');
E_5 = [E_x1x200(5:6,:); E_x1x200(39:40,:)];
E_6 = [E_x1x200(5:6,:); E_x1x200(23:24,:)];

E_x1x2x5x600 = subs(E58, [x(1),x(2), x(5),x(6)], [0, 0, 0, 0]);
fprintf('0 0 ');
fprintf('################\n');
j = 1;
for i=1:6
    disp(j)
    E_x1x2x5x600(j:j+7,1:4)
    j = j+8;
end    
% in questo caso si conclude con 5-8

% x4 x5 0 0
E58 = E(:,5:8);
E_x3x400 = subs(E58, [x(3),x(4)], [0, 0]);
fprintf('0 0 ');
fprintf('################\n');

j = 1;
for i=1:6
    disp(j)
    E_x3x400(j:j+7,1:4)
    j = j+8;
end    

E_7 = [E_x3x400(5:6,:);E_x3x400(23:24,:)]; %det si annulla per x5 = 0
E_8 = [E_x3x400(5:6,:);E_x3x400(39:40,:)]; %det si annulla per x6 = 0

E_x3x4x5x600 = subs(E58, [x(3),x(4),x(5),x(6)], [0, 0, 0,0]);
fprintf('0 0 ');
fprintf('################\n');

j = 1;
for i=1:6
    disp(j)
    E_x3x4x5x600(j:j+7,1:4)
    j = j+8;
end    

% si conclude per 5-8

%x1=0; x4=0
E58 = E(:,5:8);
E_x1x400 = subs(E58, [x(1),x(4)], [0, 0]);
fprintf('0 0 ');
fprintf('################\n');

j = 1;
for i=1:6
    disp(j)
    E_x1x400(j:j+7,1:4)
    j = j+8;
end    

