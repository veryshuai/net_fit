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
        
        %unpack data containers
        bps = dat('bps');
        spb = dat('spb');
        bt = dat('bt');
        st = dat('st');
        datvec = [bps(:); spb(:); bt(:); st(:)];
        
        %unpack sim containers
        dist_s = res('dist_s');
        dist_b = res('dist_b');
        trans_s = res('trans_s');
        trans_b = res('trans_b');
        simvec = [dist_s(:); dist_b(:); trans_b(:); trans_s(:)];
        
        err = norm(simvec - datvec);
    
    catch
    
        display('WARNING:there was an error in residual evaluation')
        err = 1e12 %large number 
    
    end %try/catch

    % Check for imaginary numbers
    if isreal(simvec) == 0
        %display('WARNING: imaginary numbers encountered in resid.m')
        err = 1e12;
    end

    % Print to file
    print_results(x, err);

end
    
