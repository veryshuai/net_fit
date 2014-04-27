function [trans_s, trans_b] = get_trans(p, theta_s, theta_b, u, v)
% takes policies and equilibrium thetas, and returns transition matrices

    % Create Q intensity matrices
    Q_b = get_intense(p, theta_b, v);
    Q_s = get_intense(p, theta_s, ones(size(v,1),1) * u);

    % Matrix exponential
    trans_b = expm(Q_b);
    trans_s = expm(Q_s);

end
