%%% ------------------------------------------------------------------- %%%
%%% ---------- Symbolic Regressor Computation ------------------------- %%%
%%% ------------------------------------------------------------------- %%%

syms pi_1 pi_2 pi_3 pi_4 pi_5 pi_6 

pi_1  = m_b;
pi_2  = m_c;
pi_3  = mfb_rm;
pi_4  = m_n;
pi_5  = m_p;
pi_6  = F;


pi_vec = [pi_1 pi_2 pi_3 pi_4 pi_5 pi_6].';
% length(q_vec)

% Regressor columns computation      
Y = sym('Y', [3,length(pi_vec)]);

for i = 1:3
    
    %---------------------------------------------------------------------   
    % take every term with coefficients formed by m1, r1 (see t1)
    [c1,t1] = coeffs(Dyn(i), m_b);
    C1 = arrayfun(@char,t1,'Un',0);
    % take only term with coefficients formed by m1, r1 and characters
    % * ('\w*\*\w*'), thus selecting only terms with m1*r1^2
    % (see regexp(C1,'\w*\*\w*','match'))
    C1 = c1(~cellfun('isempty',regexp(C1,'\w*m_b\w*','match')));
    
    if isempty(C1)
        C1 = 0;
    end

%     Y(i,1) = C1;
   

    Y(i,1) = c1(1);
    

    %---------------------------------------------------------------------
    [c2,t2] = coeffs(Dyn(i), m_c);
    C2 = arrayfun(@char,t2,'Un',0);
    C2 = c2(~cellfun('isempty',regexp(C2,'\w*m_c\w*','match')));

    if isempty(C2)
        C2 = 0;
    end
    Y(i,2) = c2(1);

    %---------------------------------------------------------------------
    [c3,t3] = coeffs(Dyn(i), mfb_rm);
    C3 = arrayfun(@char,t3,'Un',0);
    C3 = c3(~cellfun('isempty',regexp(C3,'\w*mfb_rm\w*','match')));
    
    if isempty(C3)
        C3 = 0;
    end
    Y(i,3) = c3(1);

    %---------------------------------------------------------------------
    [c4,t4] = coeffs(Dyn(i), m_n);
    C4 = arrayfun(@char,t4,'Un',0);
    C4 = c4(~cellfun('isempty',regexp(C4,'\w*m_n\w*','match')));

    if isempty(C4)
        C4 = 0;
    end
    Y(i,4) = c4(1);

    %---------------------------------------------------------------------
    [c5,t5] = coeffs(Dyn(i), m_p);
    C5 = arrayfun(@char,t5,'Un',0);
    C5 = c5(~cellfun('isempty',regexp(C5,'\w*\^\w*m_p\w*','match')));

    if isempty(C5)
        C5 = 0;
    end
    Y(i,5) = c5(1);

    %---------------------------------------------------------------------
    [c6,t6] = coeffs(Dyn(i), F);
    C6 = arrayfun(@char,t6,'Un',0);
    C6 = c6(~cellfun('isempty',regexp(C6,'\w*F\w*','match')));

    if isempty(C6)
        C6 = 0;
    end
    Y(i,6) = c6(1);

end

fprintf('\nStarted creating Regressor function\n');
tic
matlabFunction(Y,'File','Regressor_function','Vars',[q, dq, ddq, ee]);
toc
fprintf('\nEnded Regressor function creation\n');

clear C1 C2 C3 C4 C5 C6 
clear c1 c2 c3 c4 c5 c6 
clear t1 t2 t3 t4 t5 t6 
