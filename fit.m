% This script calls the fit function for network project

% Get initial condition

x = [124.42238023059763918354; 35.01503827349180397732; 14.33831413666636933613; 70.29432805141259166248; 0.12883567475845017491; 0.90569436520929558210; 0.93772220670380734830; 1.91650701816526014554; 0.36642008716307922223];

% Upper bound
top = ones(size(x,1),1) * inf;
top(1:4) = 200; %put upper limit on cost parameters
top(5) = 0.2; %net param
top(6) = 1; %Profit functions, ensure decreasing returns
top(7) = 1; %Profit functions, ensure decreasing returns
top(8) = 3; %match destruction
top(9) = 10; %alpha not too large

% FMINCON
%options = optimset('Algorithm','interior-point','Display','iter','TolX',1e-20);
%res = fmincon(@(x) resid(x),x,[],[],[],[],zeros(size(x,1),1),top,[],options)

%SIM ANNEAL
options = saoptimset('Display','iter','DisplayInterval',1);
[x,fval,exitflag,output] = simulannealbnd(@(x) resid(x),x,zeros(size(x,1),1),top,options);

display(x)

[fval, res, dat] = resid(x);

savename=sprintf('results/fit_%s.mat',datestr(now));
save(savename);
