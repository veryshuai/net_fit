function [err, res, dat] = resid(x)
% Returns the distance between data and model

    try

        %read in new parameters
        p = get_params(x);
        
        %display([keys(p);values(p)]')

        %solve model
        res = solve_model(p);
        
        %truncate model results to match data
        res = trunk(res);
        
        %get data
        dat = get_data();
        
        %unpack and normalize
        [datvec, simvec] = unp_norm(dat,res);
        
        err = norm(simvec - datvec);
        
        % Check for imaginary numbers
        if isreal(simvec) == 0
            %display('WARNING: imaginary numbers encountered in resid.m')
            err = 1e12;
        end
        
    catch
    
        display('WARNING:there was an error in residual evaluation')
        err = 1e12; %large number 
    
    end %try/catch

    if err == inf
        err = 1e12;
    end

    % Print to file
    print_results(x, err);
    

end
    
