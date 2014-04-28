% This script calls the fit function for network project

% Get initial condition
x = [2.7784; 8.8761; 1.4058; 67.6611; 0.1807; 0.0316; 0.9733; 1.9612; 4.7510];

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

% SIM ANNEAL
options = saoptimset('Display','iter','DisplayInterval',1);
[x,fval,exitflag,output] = simulannealbnd(@(x) resid(x),x,zeros(size(x,1),1),top,options);

display(x)

[fval, res, dat] = resid(x);

savename=sprintf('results/fit_%s.mat',datestr(now));
save(savename);
