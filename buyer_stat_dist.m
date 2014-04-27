function Mb = buyer_stat_dist(p,v,thetab)
%returns stationary distribution of buyers, for given thetab

    %initialize
    Mb=zeros(p('N')+1,1);
    
    Mb(1)=1e12;   %normalize later
    Mb(2)=Mb(1)*v(1)*thetab/p('delta');
    %Mass of buyers with 2, 3, ...,N-1 sellers
    for i=3:1:p('N')
        Mb(i)=1/((i-1)*p('delta'))*(-v(i-2)*thetab*Mb(i-2)+v(i-1)*thetab*Mb(i-1)+(i-2)*p('delta')*Mb(i-1));
        if Mb(i)<0  %if hit negative mass, exit
            Mb(i)=0;
            %disp('WARNING: Error in buyer ergodic distribution estimation.   Encountered negative number')
            break
        end
    end
    Mb(p('N')+1)=v(p('N'))*thetab*Mb(p('N'))/(p('N')*p('delta'));
    Mb=Mb./sum(Mb); %normalize
