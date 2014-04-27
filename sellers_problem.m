function u = sellers_problem(p, thetas, thetab, v, Mb)
% solves seller's problem, returns value function and policy 

    profs=[1:1:p('N')]'.^p('f');
    Vs_new=profs./p('rho');
    Vs=zeros(p('N'),1);
    while norm(Vs-Vs_new)>1e-6
        Vs=Vs_new;
        
        %start with boundary condition
        Vs_new(1)=1/(p('rho')+p('delta')+v(2)*thetab)*(profs(1)+v(2)*thetab*Vs(2));
        Vs_new(p('N'))=1/(p('rho')+p('delta')*p('N'))*(profs(p('N'))+(p('N')-1)*p('delta')*Vs(p('N')-1));
        Vs_new(2:p('N')-1)=1./(p('rho')+(2:1:p('N')-1)'*p('delta')+v(3:p('N'))*thetab).*(profs(2:p('N')-1)+p('delta')*(1:1:p('N')-2)'.*Vs(1:p('N')-2)+thetab*v(3:p('N')).*Vs(3:p('N')));
    end 
     
    EVs=sum(Vs.*Mb(1:p('N')));
    u=(EVs*thetas/(p('cs0')*p('cs1'))).^(1/(p('cs1')-1));
end
