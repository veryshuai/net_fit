function res = solve_model(p)
% Solves endogenous version of model

% Create result holder
res = containers.Map;

% Get thetas, policies, and stat. distributions
[thetas, thetab, u, v, Ms, Mb] = theta_est(p);

% Get buyer and seller distributions
[res('dist_s'), res('dist_b')] = get_dists(Ms, Mb);

% Get buyer and seller transitions
[res('trans_s'), res('trans_b')] = get_trans(p, thetas, thetab, u, v);
