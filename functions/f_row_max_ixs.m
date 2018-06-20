function [ixs, v_ix] = f_row_max_ixs(y)
% return the max ix for each row
% y is the 3000*nInsts array of predicted y scores.
% v_ix is the vector index

%y(y<0.8) = 0;

v_ix = false(size(y));
ixs = zeros(size(y,1), 1);
for i=1:size(y,1)
    r = y(i, :);
    %[~, ix] = sort(r, 'descend');
    ix = find(r == max(r)); 
    % using sorting or find() to find the max has almost no differences.    
    
    top = ix(randi(length(ix)));
    
    ixs(i) = top;    
    v_ix(i, top) = true;
    
end


end

