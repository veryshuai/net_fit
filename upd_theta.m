function [thetab_new, thetas_new] = upd_theta(v,Mb,u,p)
%aggregates search hazards into thetas

    %now aggregate up to V/U
    V=sum(v.*Mb);        %total buyer search (vacancy)
    U=u*p('Ns');   %total seller search 
    
    thetab_new=U/(U^p('alp')+V^p('alp'))^(1/p('alp'));
    thetas_new=V/(U^p('alp')+V^p('alp'))^(1/p('alp'));
