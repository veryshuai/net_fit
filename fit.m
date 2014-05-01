% This script calls the fit function for network project

% Get initial condition

x = [247.65501417047360632750; 4.44103417406156530944; 39.47242091047631618039; 255.17987099707119114100; 1.98616906861196862444; 0.98862614286222449955; 0.70174009708094731153; 0.10402902637788701001; 10.83887700258380348828];

% Upper bound
top = ones(size(x,1),1) * inf;
top(1:4) = 300; %put upper limit on cost parameters
top(5) = 5; %net param
top(6) = 1; %Profit functions, ensure decreasing returns
top(7) = 1; %Profit functions, ensure decreasing returns
top(8) = 3; %match destruction
top(9) = 20; %alpha not too large

% FMINCON
% options = optimset('Algorithm','interior-point','Display','iter','TolX',1e-20);
% res = fmincon(@(x) resid(x),x,[],[],[],[],zeros(size(x,1),1),top,[],options)

%SIM ANNEAL
options = saoptimset('Display','iter','DisplayInterval',1,'ReannealInterval',100,');
[x,fval,exitflag,output] = simulannealbnd(@(x) resid(x),x,zeros(size(x,1),1),top,options);

display(x)

[fval, res, dat] = resid(x);

savename=sprintf('results/fit_%s.mat',datestr(now));
save(savename);
