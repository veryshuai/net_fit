% This script calls the fit function for network project

% Get initial condition
x = [3.2796; 7.1871; 1.2714; 8.4193; 0.1280; 0.7933; 0.2871; 0.8439; 3.1670];

% Upper bound
top = ones(size(x,1),1) * inf;
top(1:4) = 10; %put upper limit on cost parameters
top(5) = 0.3; %net param
top(6) = 1; %Profit functions, ensure decreasing returns
top(7) = 1; %Profit functions, ensure decreasing returns
top(8) = 1; %match destruction
top(9) = 5; %alpha not too large

% FMINCON
%options = optimset('Algorithm','interior-point','Display','iter','TolX',1e-20);
%res = fmincon(@(x) resid(x),x,[],[],[],[],zeros(size(x,1),1),top,[],options)

% SIM ANNEAL
options = saoptimset('Display','iter','DisplayInterval',1);
[res,fval,exitflag,output] = simulannealbnd(@(x) resid(x),x,zeros(size(x,1),1),top,options);

display(res)

savename=sprintf('results/fit_%s.mat',datestr(now));
save(savename);
