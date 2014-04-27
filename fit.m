% This script calls the fit function for network project

% Get initial condition
x = [1;2;1;2;0.1;0.95;0.1;0.2;0.7];

% Solver options
options = optimset('Algorithm','interior-point','Display','iter');

% Call solver
res = fmincon(@(x) resid(x), x, [],[],[],[],zeros(size(x,1),1),[],[],options)

display(res)

save('results.mat')
