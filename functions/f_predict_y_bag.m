function y_bag_predicted = f_predict_y_bag(y_inst_predicted, ...
    n_insts_per_bag, m)
% 
if nargin<3
    m=1;
end

n_insts = size(y_inst_predicted,1);
n_bags = n_insts./n_insts_per_bag;

y_inst_predicted = reshape(y_inst_predicted, [n_insts_per_bag, n_bags]);
% compute the 35mer score
a = y_inst_predicted .^ m;

% y_bag_predicted is the 1-d array of predicted 35mer scores
y_bag_predicted = mean(a, 1)';

end

