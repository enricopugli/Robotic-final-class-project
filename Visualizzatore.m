[theta, R, ~, ~, l_A, r_Gb, ~, l_B, ~, ~, ~] = Parameters_DELTA;

P1 = [R; 0; 0];
P2 = R_base(theta(2))*P1;
P3 = R_base(theta(3))*P1;

P_1 = 2*rotz(60)*P1;
P_2 = 2*rotz(60)*P2;
P_3 = 2*rotz(60)*P3;


grid on 
axis([-5*R 5*R -5*R 5*R -5*R R]);

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


t_final = size(q);
time = 0;
% disegno delle braccia
% disegno delle spalle
for t = 1:t_final
%     tic;
    grid on 
    axis([-3*R 3*R -3*R 3*R -5*R R]);

    hold on
    
    plot3(ee(1:t,1), ee(1:t,2), ee(1:t,3), 'r'); 
    
    line([0 1],[0 0],[0 0], 'Color',[.5 0 0]);
    line([0 0],[0 1],[0 0], 'Color',[0 .5 0]);
    line([0 0],[0 0],[0 1], 'Color',[0 0 .5]);
   
    % disegno del piatto superiore
%     line([P1(1) P2(1)],[P1(2) P2(2)],[P1(3) P2(3)]);
%     line([P2(1) P3(1)],[P2(2) P3(2)],[P2(3) P3(3)]);
%     line([P1(1) P3(1)],[P1(2) P3(2)],[P1(3) P3(3)]);
    line([P_1(1) P_2(1)],[P_1(2) P_2(2)],[P_1(3) P_2(3)]);
    line([P_2(1) P_3(1)],[P_2(2) P_3(2)],[P_2(3) P_3(3)]);
    line([P_1(1) P_3(1)],[P_1(2) P_3(2)],[P_1(3) P_3(3)]);

    %disegno dei giunti rotoidali tra base e spalla
    %IMPORTANTE al momento giunti rotoidali e sferici sono rappresentati 
    %allo stesso modo. Questo va corretto     
    plot3(P1(1), P1(2), P1(3), 'or');
    plot3(P2(1), P2(2), P2(3), 'or');
    plot3(P3(1), P3(2), P3(3), 'or');

    %disegno delle spalle   
    v1 = l_A * [cos(q(t,1)); 0; -sin(q(t,1))];
    v2 = l_A * [cos(q(t,2)); 0; -sin(q(t,2))];
    v3 = l_A * [cos(q(t,3)); 0; -sin(q(t,3))];  
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
    line([ee(t,1) B1(1)],[ee(t,2) B1(2)],[ee(t,3) B1(3)], 'Color',[.1 .8 .1]);
    line([ee(t,1) B2(1)],[ee(t,2) B2(2)],[ee(t,3) B2(3)], 'Color',[.1 .8 .1]);
    line([ee(t,1) B3(1)],[ee(t,2) B3(2)],[ee(t,3) B3(3)], 'Color',[.1 .8 .1]);
    
    %disegno end effector    
    plot3(ee(t,1), ee(t,2), ee(t,3), 'dr');
    
%     toc;
%     pause(0.15 - toc);
%     cla
    pause(0.1);
    cla;
%     dt = toc;
%     time = time + dt;
end


close all

% time

% cla;
