

%This is a simple code computing network dynamics of buyer-sellers in
%continuous time

clear;

%Start by bounding state space - maximum number of connections
N=100;
Ns=0.8;   %relative seller to buyer ratio

%%cost parameter of buyer search and seller search
%simple quatratic
cb0=1;  cb1=2;
cs0=1;  cs1=2;
gam=0;


%profit function parameters for buyer (g) and seller-buyer pair (f)
g=0.95;
f= 0.1;

%discounting rate and exogenous destruction rate
rho=0.085;
delta=0.2;

%match function parameters
alp=0.7;

%%%%%%%%%%%%%%%START TO ITERATE ON MATCHING RATE
%initial guess of equilibrium objects thetab, thetas
thetas_new=0.01; 
thetab_new=0.01;

thetas=0;  thetab=0;

while norm(thetas_new-thetas)>1e-4||norm(thetab_new-thetab)>1e-4
    
thetas=0.98*thetas+0.02*thetas_new;  thetab=0.98*thetab+0.02*thetab_new;

%solve buyers problem

%define buyer value function with 0,1,.....,N sellers

%initial guess
profb=[0:1:N]'.^g;
Vb_new=profb;
Vb=zeros(N+1,1);

v=zeros(N+1,1);

net=(1:1:N)'.^gam;
while norm(Vb-Vb_new)>1e-6
    Vb=Vb_new;
    
    %start with boundary condition
    
    %optimal search effort
    v(N+1)=0;     
    v(1:N)=(thetab*net.*(Vb(2:N+1)-Vb(1:N))/(cb0*cb1)).^(1/(cb1-1));
    
    Vb_new(N+1)=1/(rho+N*delta)*(profb(N)+N*delta*Vb(N));
    Vb_new(1)=1/(rho+v(1)*thetab)*(-cb0*v(1)^cb1/net(1)+v(1)*thetab*Vb(2));
    
    %the case of 1,2,...N-1 sellers
    Vb_new(2:N)=1./(rho+(1:1:N-1)'*delta+v(2:N)*thetab).*(profb(2:N)-cb0*(v(2:N)).^cb1./net(2:N)+delta*(1:1:N-1)'.*Vb(1:N-1)+thetab*v(2:N).*Vb(3:N+1));
      
end

Vcheck=1/(rho+delta)*(1:1:N+1)';
vcheck=0.5*thetab*(1/(rho+delta))*(1:1:N+1)';
% a=1/(rho+delta);  v=0.5*thetab*a*[(1:1:N)';0].^0.5;
%solve buyer stationary dist. (using balancing)
Mb=zeros(N+1,1);

Mb(1)=1;   %normalize later
Mb(2)=Mb(1)*v(1)*thetab/delta;
%Mass of buyers with 2, 3, ...,N-1 sellers
for i=3:1:N
    Mb(i)=1/((i-1)*delta)*(-v(i-2)*thetab*Mb(i-2)+v(i-1)*thetab*Mb(i-1)+(i-2)*delta*Mb(i-1));
    if Mb(i)<0  %if hit negative mass, exit
        Mb(i)=0;
        break
    end
end
Mb(N+1)=v(N)*thetab*Mb(N)/(N*delta);
Mb=Mb./sum(Mb);


%solve the value of seller-buyer pair
profs=[1:1:N]'.^f;
Vs_new=profs./rho;
Vs=zeros(N,1);
while norm(Vs-Vs_new)>1e-6
    Vs=Vs_new;
    
    %start with boundary condition
    Vs_new(1)=1/(rho+delta+v(2)*thetab)*(profs(1)+v(2)*thetab*Vs(2));
    Vs_new(N)=1/(rho+delta*N)*(profs(N)+(N-1)*delta*Vs(N-1));
    Vs_new(2:N-1)=1./(rho+(2:1:N-1)'*delta+v(3:N)*thetab).*(profs(2:N-1)+delta*(1:1:N-2)'.*Vs(1:N-2)+thetab*v(3:N).*Vs(3:N));
        
end 
 
EVs=sum(Vs.*Mb(1:N));
u=(EVs*thetas/(cs0*cs1)).^(1/(cs1-1));

% %now aggregate up to V/U
V=sum(v.*Mb);        %total buyer search (vacancy)
U=u*Ns;   %total seller search 

thetab_new=U/(U^alp+V^alp)^(1/alp);
thetas_new=V/(U^alp+V^alp)^(1/alp);

[norm(thetas_new-thetas) norm(thetab_new-thetab)]
end

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
