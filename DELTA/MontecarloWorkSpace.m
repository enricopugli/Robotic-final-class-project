% Run montecarlo run over a cartesian 3D space to identify Delta Workspace
close all
clear p_out

p_i = [-.4; -.4; -.6];
p_f = [.8; .8; .6];

j = 1;

n_run = 100000;

tic
for i = 1:n_run
   
    p = p_i + rand(3,1).*p_f;
    
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

% Individua una superficie approssimata triangolarizzata contenente i punti
% di p_out come vertici dei triangoli di superficie approssimata.

[k,v] = boundary(p_out,shrink);
hold on
grid on

% Plotta la superficie dei triangoli contenuti in k
trisurf(k,p_out(:,1),p_out(:,2),p_out(:,3),'Facecolor','red','FaceAlpha',0.1) 

figure
plot3(p_out(:,1), p_out(:,2), p_out(:,3), '.', 'MarkerSize', 4);
axis([-axis_lim axis_lim -axis_lim axis_lim -axis_lim axis_lim]); 
grid on

% genera il poliedro di inviluppo della point cloud trovata
figure
alphaRadius  = .2;
S = alphaShape(p_out, alphaRadius);
xlabel('x');
xlabel('y');
xlabel('z');
plot(S);

% Salvataggio dati:
alpha_shape_WS = S;
point_cloud_WS = p_out;
convex_region_WS = k;
filename = 'loadvar_DeltaWS';
save(filename, 'alpha_shape_WS', 'point_cloud_WS', 'convex_region_WS');
