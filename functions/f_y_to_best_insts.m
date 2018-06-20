function instNOs = f_y_to_best_insts(y)
% input the 6000 x 86 predicted instance scores, output the best instance
% id for each bag.  

% n: number of bags
n = size(y, 1);
% half positive, half negative
pdata = y(1:round((n/2)), :);
% only get the top instance for the positive sequence set, 
%  pick top for the negative is meaningless. 
ixs = f_row_max_ixs(pdata);
% I will just make the negative ixs the same as the positive.
instNOs = [ixs; ixs];

end

