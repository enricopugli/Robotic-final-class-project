close all
% clear q ee ee_r
% sim('PID_DELTA', 'StopTime', '6');

[theta, R, ~, ~, l_A, r_Gb, ~, l_B, ~, ~, ~] = Parameters_DELTA;

P1 = [R; 0; 0];
P2 = R_base(theta(2))*P1;
P3 = R_base(theta(3))*P1;

P_1 = 2*rotz(60)*P1;
P_2 = 2*rotz(60)*P2;
P_3 = 2*rotz(60)*P3;

axis_lim = .1;
axis_lim_ = -.5;
grid on 
axis([-.32 .32 -.32 .32 axis_lim_ axis_lim]);

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

video = VideoWriter('..\Video\VideoDelta\PidPointToPoint.mp4'); %create the video object
open(video); %open the file for writing

for t = 1:200:t_final
%     tic;
    grid on 
    axis([-.32 .32 -.32 .32 axis_lim_ axis_lim]);

    hold on
    
    plot3(ee(1:t,1), ee(1:t,2), ee(1:t,3), 'r'); 
    plot3(ee_r(1:t,1), ee_r(1:t,2), ee_r(1:t,3), 'b');
    
    line([0 R/2],[0 0],[0 0], 'Color',[.5 0 0]);
    line([0 0],[0 R/2],[0 0], 'Color',[0 .5 0]);
    line([0 0],[0 0],[0 R/2], 'Color',[0 0 .5]);
   
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
    v1 = [R; 0; 0] + l_A * [cos(q(t,1)); 0; -sin(q(t,1))];
    v2 = [R; 0; 0] + l_A * [cos(q(t,2)); 0; -sin(q(t,2))];
    v3 = [R; 0; 0] + l_A * [cos(q(t,3)); 0; -sin(q(t,3))];  
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
    
    % disegno end effector    
    plot3(ee(t,1), ee(t,2), ee(t,3), 'dr');
    % Disegno traiettoria di riferimento    
    plot3(ee_r(t,1), ee_r(t,2), ee_r(t,3), 'db');

    fig = getframe(gcf);
    writeVideo(video,fig);
%     pause(0.001);
    drawnow 
%     limitrate
    
    if t == 1
        pause(4)
    end
    
%     F(t) = getframe(gcf);
    
    cla;
    
end


close(video); %close the file
close all

