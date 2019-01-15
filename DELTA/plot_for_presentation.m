close all

final = 2000; 

% Plot error on end-effector position
figure
plot(tout(1:final),error(1:final,1),...
     tout(1:final),error(1:final,2),...
     tout(1:final),error(1:final,3));
xlim([0 tout(final)]) 
xlabel('time (seconds)')
ylabel('meters')
legend('ex', 'ey', 'ez', 'Location', 'se')
title('End effector position error')
grid on

saveas(gcf, 'C:\Users\Dan\Desktop\DeltaRobot\rep_delta\TavoleControlloRobot\Img\BackStepping\Eerror', 'eps')

% Plot tau input
figure
plot(tout(1:final),tau_in(1:final,1),...
     tout(1:final),tau_in(1:final,2),...
     tout(1:final),tau_in(1:final,3));
xlim([0 tout(final)])
xlabel('time (seconds)')
ylabel('Nm')
legend('tau1', 'tau2', 'tau3', 'Location', 'se')
title('Torque')
grid on

saveas(gcf, 'C:\Users\Dan\Desktop\DeltaRobot\rep_delta\TavoleControlloRobot\Img\BackStepping\tau', 'eps')

% Plot tau input
figure
plot(tout(1:final), Power(1:final,1))
xlim([0 tout(final)])
xlabel('time (seconds)')
ylabel('Watt')
title('Instant power')
grid on

saveas(gcf, 'C:\Users\Dan\Desktop\DeltaRobot\rep_delta\TavoleControlloRobot\Img\BackStepping\Power', 'eps')

% Plot end effector reference and position
figure 
subplot(3,1,1)
plot(tout(1:final), ee(1:final,1),'r', tout(1:final), ee_r(1:final,1),'b')
legend('ee_x', 'ee_r_x')
subplot(3,1,2)
plot(tout(1:final), ee(1:final,2),'r', tout(1:final), ee_r(1:final,2),'b')
legend('ee_y', 'ee_r_y')
subplot(3,1,3)
plot(tout(1:final), ee(1:final,3),'r', tout(1:final), ee_r(1:final,3),'b')
legend('ee_z', 'ee_r_z')

saveas(gcf, 'C:\Users\Dan\Desktop\DeltaRobot\rep_delta\TavoleControlloRobot\Img\BackStepping\confronto', 'eps')

