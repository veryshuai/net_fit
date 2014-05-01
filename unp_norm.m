function [datvec, simvec] = unp_norm(dat,res)
% unpacks and normalizes data to enter into residual calculation

    %unpack data containers
    bps = log(dat('bps'));
    spb = log(dat('spb'));
    bt = dat('bt');
    st = dat('st');
    
    %unpack sim containers
    dist_s = log(res('dist_s'));
    dist_b = log(res('dist_b'));
    trans_s = res('trans_s');
    trans_b = res('trans_b');

    %normalize data
    bps = bps / size(bps(:),1);
    spb = spb / size(spb(:),1);
    bt = bt / size(bt(:),1);
    st = st / size(st(:),1);

    %normalize sim
    dist_s = dist_s / size(dist_s(:),1);
    dist_b = dist_b / size(dist_b(:),1);
    trans_s = trans_s / size(trans_s(:),1);
    trans_b = trans_b / size(trans_b(:),1);

    datvec = [bps(:); spb(:); bt(:); st(:)];
    simvec = [dist_s(:); dist_b(:); trans_b(:); trans_s(:)];
end
