figure 
hold on
plot(xyref_circular(1:end,1), xyref_circular(1:end,2), 'r');
plot(xy_circular(1:end,1), xy_circular(1:end,2), 'b');
legend('reference','trajectory')
title('Feedback linearization circular trajectory')
grid on
saveas(gcf, '..\Img\BallAndBeamImg\circular_trajectory', 'epsc')

figure 
hold on
plot(xyref_infinity(1:end,1), xyref_infinity(1:end,2), 'r');
plot(xy_infinity(1:end,1), xy_infinity(1:end,2), 'b');
legend('reference','trajectory')
title('Feedback linearization infinity trajectory')
grid on
saveas(gcf, '..\Img\BallAndBeamImg\infinity_trajectory', 'epsc')


figure 
hold on
plot(tout, xyref_circular(1:end,1) - xy_circular(1:end,1),'r');
plot(tout, xyref_circular(1:end,2) - xy_circular(1:end,2), 'b');
legend('ex', 'ey');
title('Feedback linearization circular trajectory error')
grid on
saveas(gcf, '..\Img\BallAndBeamImg\circular_trajectory_error', 'epsc')

figure 
hold on
plot(tout, xyref_infinity(1:end,1) - xy_infinity(1:end,1), 'r');
plot(tout, xyref_infinity(1:end,2) - xy_infinity(1:end,2), 'b');
legend('ex', 'ey')
title('Feedback linearization infinity trajectory error')
grid on
saveas(gcf, '..\Img\BallAndBeamImg\infinity_trajectory_error', 'epsc')

% figure 
% hold on
% plot(xyref_PtoP(1:end,1), xyref_PtoP(1:end,2), 'r');
% plot(xy_PtoP(1:end,1), xy_PtoP(1:end,2), 'b');
% grid on