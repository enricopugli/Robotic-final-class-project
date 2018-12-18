q1 = 1;
q2 = 2;
q3 = 3;

% Serve cast a double?
% Come scegliere la soluzione?
ee1 = [subs(Sdir.x_ee(1)); subs(Sdir.y_ee(1)); subs(Sdir.z_ee(1))];
ee2 = [subs(Sdir.x_ee(2)); subs(Sdir.y_ee(2)); subs(Sdir.z_ee(2))];

if ee1(3) < ee2(3)
    ee = ee1;
else
    ee = ee2;
end