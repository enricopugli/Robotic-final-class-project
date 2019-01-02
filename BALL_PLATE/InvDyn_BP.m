function ddq = InvDyn_BP(tau, q, dq)

if size(dq,2) == 3
    dq = dq';
end

tau1 = [0; 0; tau(1); tau(2)];

% B, C, G matrices
[B, C, G] = BCG_BP(q, dq);

% Inverse dynamic
ddq = B\(tau1 - C*dq - G); 

end