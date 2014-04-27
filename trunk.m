function res = trunk(res)
%truncates results to match data

 %read out of collection (annoying that I have to do this, MATLAB doesn't like indexing into collection elements)
    dist_s = res('dist_s');
    dist_b = res('dist_b');
    trans_s = res('trans_s');
    trans_b = res('trans_b');

    %truncate transitions
    trans_s = trans_trunk(trans_b,dist_b);
    trans_b = trans_trunk(trans_b,dist_b);
    
    %truncate distributions
    dist_s = [dist_s(1:20); sum(dist_s(21:end))];
    dist_b = [dist_b(1:20); sum(dist_b(21:end))];
       
    %read into collection 
    res('dist_s') =  dist_s;
    res('dist_b') =  dist_b;
    res('trans_s') =  trans_s;
    res('trans_b') =  trans_b;

end
