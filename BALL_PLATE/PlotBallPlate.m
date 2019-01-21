figure 
hold on
plot(xyref_circle(1:end,1), xyref_circle(1:end,2), 'r');
plot(xy_circle(1:end,1), xy_circle(1:end,2), 'b');
legend('reference','trajectory')
title('Feedback linearization circular trajectory')
grid on
saveas(gcf, '..\Img\BallAndBeamImg\circular_trajectory', 'epsc')

figure 
hold on
plot(xyref_inf(1:end,1), xyref_inf(1:end,2), 'r');
plot(xy_inf(1:end,1), xy_inf(1:end,2), 'b');
legend('reference','trajectory')
title('Feedback linearization infinity trajectory')
grid on
saveas(gcf, '..\Img\BallAndBeamImg\infinity_trajectory', 'epsc')

% figure 
% hold on
% plot(xyref_PtoP(1:end,1), xyref_PtoP(1:end,2), 'r');
% plot(xy_PtoP(1:end,1), xy_PtoP(1:end,2), 'b');
% grid on