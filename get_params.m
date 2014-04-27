function p = get_params()
% returns the parameters used in 
% simple_match_dynamics_cont script

%Initialize container
p = containers.Map;

%Start by bounding state space - maximum number of connections
p('N')=100;
p('Ns')=0.8;   %relative seller to buyer ratio

%%cost parameter of buyer search and seller search
%simple quatratic
p('cb0')=1;  p('cb1')=2;
p('cs0')=1;  p('cs1')=2;
p('gam')=0.1;

%profit function parameters for buyer (g) and seller-buyer pair (f)
p('g')=0.95;
p('f')= 0.1;

%discounting rate and exogenous destruction rate
p('rho')=0.085;
p('delta')=0.2;

%match function parameters
p('alp')=0.7;

end
