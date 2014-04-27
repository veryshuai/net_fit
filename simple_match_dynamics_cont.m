%This is a simple script computing network dynamics of buyer-sellers in
%continuous time

clear;

% Get parameters 
p = get_params();

% Get thetas
[thetas, thetab] = theta_est(p);

%iterate to get seller size dist.
Ms=zeros(N+1,1);

Ms(1)=1;   %normalize later
Ms(2)=Ms(1)*u*thetas/delta;
%Mass of sellers with 2, 3, ...,N-1 buyers
for i=3:1:N
    Ms(i)=1/((i-1)*delta)*(-u*thetas*Ms(i-2)+u*thetas*Ms(i-1)+(i-2)*delta*Ms(i-1));
    if Ms(i)<0  %if hit negative mass, exit
        Ms(i)=0;
        break
    end
end
Ms(N+1)=u*thetas*Ms(N)/(N*delta);
Ms=Ms./sum(Ms);


Mbs=Mb(2:end)./sum(Mb(2:end));
Mss=Ms(2:end)./sum(Ms(2:end));
%summarize buyer/seller dist.
Distb=[Mbs(1:20); sum(Mbs(21:end))];
Dists=[Mss(1:20); sum(Mss(21:end))];

% y=log(1-cumsum(Mbs(1:end-1)));  x=[ones(N-1,1) log((1:1:N-1)')];
% disp('power law coefficient')
% [(x'*x)\(x'*y)]
