function [v, p] = buyers_problem(p, thetab)
% solves buyers problem, returns value function and policy 

    %initial guesses
    profb=[0:1:p('N')]'.^p('g'); 
    Vb_new=profb;
    Vb=zeros(p('N')+1,1); %value
    v=zeros(p('N')+1,1); %policy
    net=(1:1:p('N'))'.^p('gam');
    
    %constants
    bound_const = 1/(p('rho')+p('N')*p('delta'));
    den_const = p('rho')+(1:1:p('N')-1)'*p('delta');

    k = 0;
    while norm(Vb-Vb_new)>1e-6

        %kill if too many iterations
        k = k + 1;
        if break_fun(k, 'buyers_problem.m', 2e4) == 1
            break;
        end

        Vb= 0.7 * Vb_new + 0.3 * Vb;

        %optimal search effort and value at boundaray
        Vb_new(p('N')+1)=bound_const*(profb(p('N'))+p('N')*p('delta')*Vb(p('N')));

        %optimal search effort (max to avoid imaginary numbers)
        v(1:p('N'))=(thetab*net.*max(Vb(2:p('N')+1)-Vb(1:p('N')),0)/(p('cb0')*p('cb1'))).^(1/(p('cb1')-1));
        Vb_new(1)=1/(p('rho')+v(1)*thetab)*(-p('cb0')*v(1)^p('cb1')/net(1)+v(1)*thetab*Vb(2)); %value at zero is zero
        Vb_new(2:p('N'))=1./(den_const+v(2:p('N'))*thetab).*(profb(2:p('N'))-p('cb0')*(v(2:p('N'))).^p('cb1')./net(2:p('N'))+p('delta')*(1:1:p('N')-1)'.*Vb(1:p('N')-1)+thetab*v(2:p('N')).*Vb(3:p('N')+1));

    end
    
    %read profb into parameters
    p('profb') = profb;

end
