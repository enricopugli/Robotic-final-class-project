eig_excit = nan(1,length(excitability));

for i = 1:length(excitability)
    eig_excit(i) = eig(excitability(:,:,i));
end    

figure
plot(eig_excit(1), eig_excit(2), eig_excit(3));
grid on
