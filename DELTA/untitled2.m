eig_excit = nan(3,length(excitability));

for i = 1:length(excitability)
    eig_excit(:,i) = eig(excitability(:,:,i));
end    

figure
plot(eig_excit(1:3,:));
plot(eig_excit(1:3,1:end));
grid on


figure
plot(eig_excit(1:3,1:end));
grid on