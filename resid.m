function err = resid(x)
% Returns the distance between data and model

%x = [1;2;1;2;0.1;0.95;0.1;0.2;0.7]
%read in new parameters
p = get_params(x);

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


