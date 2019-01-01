eig_excit = nan(3,length(excitability));

for i = 1:length(excitability)
    eig_excit(:,i) = eig(excitability(:,:,i));
end    

figure
plot(eig_excit(1:3,:));
grid on
