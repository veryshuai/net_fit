%This is a script computing network dynamics of buyer-sellers in
%continuous time

clear;

% Get parameters 
p = get_params();

% Get thetas, policies, and stat. distributions
[thetas, thetab, v, u, Ms, Mb] = theta_est(p);

% Get buyer and seller distributions
[dist_s, dist_b] = get_dists(Ms, Mb)

% Get buyer and seller transitions
[trans_s, trans_b] = get_trans(thetas, thetab, v, u)

