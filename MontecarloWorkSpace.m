% Run montecarlo run over a cartesian 3D space to identify Delta Workspace
close all
clear all

pi = [-.4; -.4; -.6];
pf = [.8; .8; .6];

j = 1;

n_run = 100000;

tic
for i = 1:n_run
   
    p = pi + rand(3,1).*pf;
    
    q = InvKin_DELTA(p);
    
    if isreal(q)
        p_out(j,:) = p';
        j = j + 1;
    end
end   
toc

axis_lim = .6;

figure
plot3(p_out(:,1), p_out(:,2), p_out(:,3), '.', 'MarkerSize', 2);
axis([-axis_lim axis_lim -axis_lim axis_lim -axis_lim axis_lim]);

shrink = 0; % Fattore di contrazione dell'inviluppo s in [0,1] 

% Individua una superficie approssimata contenente i punti di p_out
[k,v] = boundary(p_out,shrink);
hold on
grid on

% Plotta la superficie dei triangoli in k
trisurf(k,p_out(:,1),p_out(:,2),p_out(:,3),'Facecolor','red','FaceAlpha',0.1) 

figure
plot3(p_out(:,1), p_out(:,2), p_out(:,3), '.', 'MarkerSize', 4);
axis([-axis_lim axis_lim -axis_lim axis_lim -axis_lim axis_lim]); 
grid on

% genera il poliedro di inviluppo della point cloud trovata
figure
S = alphaShape(p_out, .05); 
plot(S);

% Salvataggio dati:
filename = 'loadvar_DeltaWS';
save(filename, 'S', 'p_out', 'k');
