function Ms = seller_stat_dist(p,u,thetas)
%returns stationary distribution of sellers, for given thetab

    Ms=zeros(p('N')+1,1);
    
    Ms(1)=1e12;   %normalize later
    Ms(2)=Ms(1)*u*thetas/p('delta');
    %Mass of sellers with 2, 3, ...,N-1 buyers
    for i=3:1:p('N')
        Ms(i)=1/((i-1)*p('delta'))*(-u*thetas*Ms(i-2)+u*thetas*Ms(i-1)+(i-2)*p('delta')*Ms(i-1));
        if Ms(i)<0  %if hit negative mass, exit
            Ms(i)=0;
            break
        end
    end
    Ms(p('N')+1)=u*thetas*Ms(p('N'))/(p('N')*p('delta'));
    Ms=Ms./sum(Ms);
end
