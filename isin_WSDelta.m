function bool = isin_WSDelta(ee)
% evaluate if a point is inside the workspace of the Delta robot
    
    n = size(ee,1);
    
    if n == 3
        ee = ee';
    end 
       
    load('loadvar_DeltaWS.mat', 'alpha_shape_WS');
    
    bool = inShape(alpha_shape_WS, ee);

end