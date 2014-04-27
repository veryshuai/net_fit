function [thetas, thetab] = theta_est(p)
% calls value function iterations, returns market equilibrium thetas

%initial guesses, thetas
thetas_new=0.01;
thetab_new=0.01;
thetas=0;
thetab=0;

p = get_params();

while norm(thetas_new-thetas)>1e-4||norm(thetab_new-thetab)>1e-4

    %update thetas
    thetas=0.98*thetas+0.02*thetas_new;  
    thetab=0.98*thetab+0.02*thetab_new;

    %solve buyers problem
    [v, p] = buyers_problem(p, thetab);
    
    %solve buyer stationary dist.
    Mb = buyer_stat_dist(p, v, thetab);
    
    %sellers problem
    u = sellers_problem(p, thetas, thetab, v, Mb);
    
    %update thetas
    [thetab_new, thetas_new] = upd_theta(v, Mb, u, p);
    
    %print current theta
    [norm(thetas_new-thetas), norm(thetab_new-thetab)]
end
