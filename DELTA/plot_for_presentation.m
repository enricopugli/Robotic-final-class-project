close all

final = 400; 

% Plot error on end-effector position
figure
plot(tout(1:final),error(1:final,1),...
     tout(1:final),error(1:final,2),...
     tout(1:final),error(1:final,3));
xlim([0 tout(final)]) 
xlabel('time (seconds)')
ylabel('meters')
legend('x', 'y', 'z', 'Location', 'se');
grid on

% Plot tau input
figure
plot(tout(1:final),tau_in(1:final,1),...
     tout(1:final),tau_in(1:final,2),...
     tout(1:final),tau_in(1:final,3));
xlim([0 tout(final)])
xlabel('time (seconds)')
ylabel('Nm')
legend('x', 'y', 'z', 'Location', 'se');
grid on