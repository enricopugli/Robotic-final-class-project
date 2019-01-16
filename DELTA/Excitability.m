
rf = 1;
RSE = excitability(1:3,1:3,1:end)/rf;

d1 = [];
d2 = [];
d3 = [];

S = size(RSE);

for i = 1:S(3)
    [V, D] = eig(RSE(1:3,1:3, i));
    d1 = [d1, D(1)];
    d2 = [d2, D(5)];
    d3 = [d3, D(9)];
end

figure
hold on
plot(d1(1:end), 'r');
plot(d2(1:end), 'g');
plot(d3(1:end), 'b');

% close all