function Lh = directional_der(w,h,x,n)
% DIRECTIONAL DERIVATIVE  (Nth order iterated Directional Derivative of f and g)
%
% 
% Input:
% w = symbolic vector field of length l1 (first operand)
% h = symbolic vector field of length l1 (second operand)
% x = symbolic vector of variables
% n = order of the Directional Derivative
%
% Output:
% ad_fng =  [ dh    Lfdh    LfLfdh .  .... ]
%        n=   0      1         2
             


Lh = sym(zeros(n+1,length(w)));
Lh(1,:) = h;

if n>0
    for t = 2:n+1
        Lh(t,:) = (jacobian(Lh(t-1,:) ,x).'*w).' + Lh(t-1,:)*jacobian(w,x);
    end
end


Lh = expand(Lh);
end