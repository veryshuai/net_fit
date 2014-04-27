function [dist_s, dist_b] = get_dists(Ms, Mb)
% returns the normalized distributions of clients for sellers and buyers

    dist_b=Mb(2:end)./sum(Mb(2:end));
    dist_s=Ms(2:end)./sum(Ms(2:end));
    
end
