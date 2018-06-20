function [top_sub_seqs, mat] = f_get_top_subSequences(y_inst_predicted, whole_seqs, c, s, nPosi)
% Read the predicted y, for each bag, find the top instance, and output the
%  best subseqeunces 

if nargin < 5
    nPosi = 3000;
end

n_bags = size(whole_seqs, 1);
n_inst_per_bag = size(y_inst_predicted,1)./n_bags;

% mat is the reshape of y_inst_predicted with dimension: nBags x nInsts.
mat = reshape(y_inst_predicted, n_inst_per_bag, n_bags)';
%   Find the best instance IDs
instNOs = f_y_to_best_insts(mat);
%   Using the instance IDs to find the best sequences (6000 * 75)
l = length(whole_seqs(1,:)); % default l is 500.
top_sub_seqs = f_instNOs_to_seqs(whole_seqs, instNOs, l, c, s);




end

