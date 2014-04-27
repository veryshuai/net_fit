clear;

%This is the mechanical matching model 

N=50;   %maximum number of types
delta=0.5;
a=0.8;

%allow for type specific matching efficiency
etab=-0.6; etas=0;
sigmab=[(1:1:N+1)'.^etab];
sigmas=[(1:1:N+1)'.^etas];

%use the same matching technology   m(U,V)=UV/(U^a+V^a)^(1/a)

%Initial guess of dist. of mass of sellers

Ms_old=ones(N+1,1)/(N+1);
Ms_new=[1; zeros(N,1)];
Mb=zeros(N+1,1);

iter=1;
while norm(Ms_new-Ms_old)>1e-12
    iter=iter+1;
    Ms=Ms_new;
    Ms_old=Ms_new;
%compute Mb recursively
Mb(1)=1;
Mb(2)=(1/delta)*Mb(1)*sigmab(1)*sum(sigmas.*Ms./((Ms.^a+Mb(1).^a).^(1/a)));
for s=3:1:N+1
    Mb(s)=(delta*(s-2)*Mb(s-1)+Mb(s-1)*sigmab(s-1)*sum(sigmas.*Ms./(Ms.^a+Mb(s-1).^a).^(1/a))-Mb(s-2)*sigmab(s-2)*sum(sigmas.*Ms./(Ms.^a+Mb(s-2).^a).^(1/a)))/((s-1)*delta);
    if Mb(s)<0  %if hit negative mass, exit
        Mb(s)=0;
        break
    end
end
%rescale
Mb=Mb./sum(Mb);

%compute Ms recursively
Ms(1)=1;
Ms(2)=(1/delta)*Ms(1)*sigmas(1)*sum(sigmab.*Mb./((Mb.^a+Ms(1).^a).^(1/a)));
for s=3:1:N+1
    Ms(s)=(delta*(s-2)*Ms(s-1)+Ms(s-1)*sigmas(s-1)*sum(sigmab.*Mb./(Mb.^a+Ms(s-1).^a).^(1/a))-Ms(s-2)*sigmas(s-2)*sum(sigmab.*Mb./(Mb.^a+Ms(s-2).^a).^(1/a)))/((s-1)*delta);
    if Ms(s)<0  %if hit negative mass, exit
        Ms(s)=0;
        break
    end
end
%rescale
Ms_new=Ms./sum(Ms);

end

Ms=Ms_new;

%Power law regression
%rescale Mb for >0
Mbs=Mb(2:end)./sum(Mb(2:end));
%rescale Ms for >0
Mss=Ms(2:end)./sum(Ms(2:end));

%summarize buyer/seller dist.
Distb=[Mbs(1:20); sum(Mbs(21:end))];
Dists=[Mss(1:20); sum(Mss(21:end))];
    
y=log(1-cumsum(Mbs(1:end-1)));  x=[ones(N-1,1) log((1:1:N-1)')];
disp('power law coefficient')
[(x'*x)\(x'*y)]
% plot(x,y)

Qs=zeros(N+1,N+1);
%intensity matrix for a seller with i-1 buyers
Qs(1,2)=sigmas(1)*sum(sigmab.*Mb./((Mb.^a+Ms(1).^a).^(1/a)));
Qs(1,1)=-Qs(1,2);
for i=2:1: N
    Qs(i,i+1)=sigmas(i)*sum(sigmab.*Mb./((Mb.^a+Ms(i).^a).^(1/a)));
    Qs(i,i-1)= delta*(i-1);       
    Qs(i,i)=-(Qs(i,i+1)+Qs(i,i-1));
end
Qs(N+1,N)=delta*N;
Qs(N+1,N+1)=-Qs(N+1,N);

Qb=zeros(N+1,N+1);
%intensity matrix for a buyers with i-1 buyers
Qb(1,2)=sigmab(1)*sum(sigmas.*Ms./((Ms.^a+Mb(1).^a).^(1/a)));
Qb(1,1)=-Qb(1,2);
for i=2:1: N
    Qb(i,i+1)=sigmab(i)*sum(sigmas.*Ms./((Ms.^a+Mb(i).^a).^(1/a)));
    Qb(i,i-1)= delta*(i-1);       
    Qb(i,i)=-(Qb(i,i+1)+Qb(i,i-1));
end
Qb(N+1,N)=delta*N;
Qb(N+1,N+1)=-Qb(N+1,N);

Ts=expm(2*Qs);
Tsc=sum(Ts(1:11,12:end),2);  Tsr=sum(Ts(12:end,:),1); Tsr=[Tsr(1:11) sum(Tsr(12:end))]; 
%rescale Tsr
Tsr=Tsr./sum(Tsr);

Ts_data=[[Ts(1:11,1:11) Tsc]; Tsr];

Tb=expm(2*Qb);
Tbc=sum(Tb(1:11,12:end),2);  Tbr=sum(Tb(12:end,:),1); Tbr=[Tbr(1:11) sum(Tbr(12:end))]; 
%rescale Tbr
Tbr=Tbr./sum(Tbr);

Tb_data=[[Tb(1:11,1:11) Tbc]; Tbr];




