function [thetas, thetab, u, v, Ms, Mb] = theta_est(p)
% calls value function iterations, returns market equilibrium thetas

    %initial guesses, thetas
    thetas_new=0.01;
    thetab_new=0.01;
    thetas=0;
    thetab=0;
    
    k = 0
    while norm(thetas_new-thetas)>1e-4||norm(thetab_new-thetab)>1e-4

        %kill if too many iterations
        k += 1
        if k > 500
            display('WARNING: Loop in model solution algorithm');
            break;
        end
    
        %update thetas
        thetas=0.5*thetas+0.5*thetas_new;  
        thetab=0.5*thetab+0.5*thetab_new;
    
        %solve buyers problem
        [v, p] = buyers_problem(p, thetab);
        
        %solve buyer stationary dist.
        Mb = buyer_stat_dist(p, v, thetab);
        
        %sellers problem
        u = sellers_problem(p, thetas, thetab, v, Mb);
        
        %update thetas
        [thetab_new, thetas_new] = upd_theta(v, Mb, u, p);
        
        %print norms
        %[norm(thetas_new-thetas), norm(thetab_new-thetab)]

    end

    % solve seller stationary distribution
    Ms = seller_stat_dist(p,u,thetas);

end
