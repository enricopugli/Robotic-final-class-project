close all
clear eig_excit;
% eig_excit = nan(3,length(excitability));

j = 1;
for i = 1:100:length(excitability)
    eig_excit(:,j) = eig(excitability(:,:,i));
    rank_excit(:,j) = rank(excitability(:,:,i));
    j = j +1;
end    

figure
plot(1:length(eig_excit(1,:)),eig_excit(1,:),...
     1:length(eig_excit(1,:)),eig_excit(2,:),...
     1:length(eig_excit(1,:)),eig_excit(3,:));
grid on

figure
plot(1:length(rank_excit), rank_excit);
grid on