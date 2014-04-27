function p = get_params(x)
% returns the parameters used in 
% simple_match_dynamics_cont script

%Initialize container
p = containers.Map;

%Start by bounding state space - maximum number of connections
p('N')=100;
p('Ns')=0.8;   %relative seller to buyer ratio

%%cost parameter of buyer search and seller search
%simple quatratic
p('cb0')=x(1);  p('cb1')=x(2);
p('cs0')=x(3);  p('cs1')=x(4);
p('gam')=x(5);

%profit function parameters for buyer (g) and seller-buyer pair (f)
p('g')=x(6);
p('f')=x(7);

%discounting rate and exogenous destruction rate
p('rho')=0.085;
p('delta')=x(8);

%match function parameters
p('alp')=x(9);

end
