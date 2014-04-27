function dist_s, dist_b = get_dists(Ms, Mb)
% returns the normalized distributions of clients for sellers and buyers

    Mbs=Mb(2:end)./sum(Mb(2:end));
    Mss=Ms(2:end)./sum(Ms(2:end));
    
    %summarize buyer/seller dist.
    dist_b=[Mbs(1:20); sum(Mbs(21:end))];
    dist_s=[Mss(1:20); sum(Mss(21:end))];
end
