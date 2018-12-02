function Visualizzatore_statico(ee)
[theta, R, ~, ~, l_A, ~, ~, ~, ~, ~, ~] = Parameters_DELTA;

q = InvKin_DELTA(ee);

P1 = [R; 0; 0];
P2 = R_base(theta(2))*P1;
P3 = R_base(theta(3))*P1;

P_1 = 2*rotz(60)*P1;
P_2 = 2*rotz(60)*P2;
P_3 = 2*rotz(60)*P3;

axis_lim = .6;
grid on 
axis([-axis_lim axis_lim -axis_lim axis_lim -axis_lim axis_lim]);

hold on
% disegno del piatto superiore
% line([P1(1) P2(1)],[P1(2) P2(2)],[P1(3) P2(3)]);
% line([P2(1) P3(1)],[P2(2) P3(2)],[P2(3) P3(3)]);
% line([P1(1) P3(1)],[P1(2) P3(2)],[P1(3) P3(3)]);
line([P_1(1) P_2(1)],[P_1(2) P_2(2)],[P_1(3) P_2(3)]);
line([P_2(1) P_3(1)],[P_2(2) P_3(2)],[P_2(3) P_3(3)]);
line([P_1(1) P_3(1)],[P_1(2) P_3(2)],[P_1(3) P_3(3)]);

plot3(P1(1), P1(2), P1(3), 'or');
plot3(P2(1), P2(2), P2(3), 'or');
plot3(P3(1), P3(2), P3(3), 'or');

% disegno delle braccia
% disegno delle spalle

grid on 
axis([-axis_lim axis_lim -axis_lim axis_lim -axis_lim axis_lim]);

hold on

plot3(ee(1), ee(2), ee(3), 'r'); 

line([0 R/2],[0 0],[0 0], 'Color',[.5 0 0]);
line([0 0],[0 R/2],[0 0], 'Color',[0 .5 0]);
line([0 0],[0 0],[0 R/2], 'Color',[0 0 .5]);

% disegno del piatto superiore
line([P_1(1) P_2(1)],[P_1(2) P_2(2)],[P_1(3) P_2(3)]);
line([P_2(1) P_3(1)],[P_2(2) P_3(2)],[P_2(3) P_3(3)]);
line([P_1(1) P_3(1)],[P_1(2) P_3(2)],[P_1(3) P_3(3)]);

%disegno dei giunti rotoidali tra base e spalla
plot3(P1(1), P1(2), P1(3), 'or');
plot3(P2(1), P2(2), P2(3), 'or');
plot3(P3(1), P3(2), P3(3), 'or');

%disegno delle spalle   
v1 = [R; 0; 0] + l_A * [cos(q(1)); 0; -sin(q(1))];
v2 = [R; 0; 0] + l_A * [cos(q(2)); 0; -sin(q(2))];
v3 = [R; 0; 0] + l_A * [cos(q(3)); 0; -sin(q(3))];  
B1 = v1;
B2 = R_base(theta(2))*v2;
B3 = R_base(theta(3))*v3;
line([P1(1) B1(1)],[P1(2) B1(2)],[P1(3) B1(3)], 'Color',[.1 .8 .1]);
line([P2(1) B2(1)],[P2(2) B2(2)],[P2(3) B2(3)], 'Color',[.1 .8 .1]);
line([P3(1) B3(1)],[P3(2) B3(2)],[P3(3) B3(3)], 'Color',[.1 .8 .1]);

%disegno dei giunti sferici tra spalla e avambraccio     
plot3(B1(1), B1(2), B1(3), 'or');
plot3(B2(1), B2(2), B2(3), 'or');
plot3(B3(1), B3(2), B3(3), 'or');

%disegno avambraccio ee-> end effector     
line([ee(1) B1(1)],[ee(2) B1(2)],[ee(3) B1(3)], 'Color',[.1 .8 .1]);
line([ee(1) B2(1)],[ee(2) B2(2)],[ee(3) B2(3)], 'Color',[.1 .8 .1]);
line([ee(1) B3(1)],[ee(2) B3(2)],[ee(3) B3(3)], 'Color',[.1 .8 .1]);

% disegno end effector    
plot3(ee(1), ee(2), ee(3), 'dr');
end


    

