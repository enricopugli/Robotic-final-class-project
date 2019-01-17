
rf = 1;
RSE = excitability(1:3,1:3,1:end)/rf;

d1 = [];
d2 = [];
d3 = [];
n_condizionamento = [];

S = size(RSE);

for i = 1:10000:S(3)
    [V, D] = eig(RSE(1:3,1:3, i));
    n_condizionamento = [n_condizionamento, cond(RSE(1:3,1:3, i))];
    d1 = [d1, D(1)];
    d2 = [d2, D(5)];
    d3 = [d3, D(9)];
end

figure
hold on
plot(d1(1:end), 'r');
plot(d2(1:end), 'g');
plot(d3(1:end), 'b');
grid on
hold off

figure
plot(n_condizionamento(1:end), 'r');
xlabel('time (seconds)')
title('Condition number')
grid on

saveas(gcf, '..\Img\AdaptiveInfinity\Condizionamento', 'epsc')
 
figure
plot(tout(1:end),Parameters(1:end,1), 'r',...
     tout(1:end),Parameters(1:end,4), 'b',...
     tout(1:end),Parameters(1:end,2), 'r',...
     tout(1:end),Parameters(1:end,3), 'r',...
     tout(1:end),Parameters(1:end,5), 'b',...
     tout(1:end),Parameters(1:end,6), 'b');
legend('Estimated','Real')
xlabel('time (seconds)')
title('Parameters. Real VS Estimated')
grid on

saveas(gcf, '..\Img\AdaptiveInfinity\Parameters', 'epsc')
 
% close all