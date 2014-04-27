function [dist_s, dist_b, trans_s, trans_b] = solve_model(p)
% Solves endogenous version of model

% Get parameters 
p = get_params();

% Get thetas, policies, and stat. distributions
[thetas, thetab, u, v, Ms, Mb] = theta_est(p);

% Get buyer and seller distributions
[dist_s, dist_b] = get_dists(Ms, Mb);

% Get buyer and seller transitions
[trans_s, trans_b] = get_trans(p, thetas, thetab, u, v);
