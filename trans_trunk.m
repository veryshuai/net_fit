function trans = trans_trunk(trans,dist)
% normalizes and truncates transitions

   %normalize
   trans = bsxfun(@rdivide, trans(2:end,:),sum(trans(2:end,:),2));

   %truncate transitions buyer
   bottom = sum(bsxfun(@times,dist(11:end),trans(11:end,:)));
   normalized_bottom = bottom / sum(bottom);
   pre_right_sum = [trans(1:10,:); normalized_bottom];
   trans = [pre_right_sum(:,1:11), sum(pre_right_sum(:,12:end),2)];

end
