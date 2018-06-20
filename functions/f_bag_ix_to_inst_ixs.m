function indeces = f_bag_ix_to_inst_ixs( ix, inst_per_bag )
% convert a bag index to a list of indeces of the instances
start_p = int32((ix-1) .* inst_per_bag + 1);
indeces = start_p:(start_p+inst_per_bag-1);

end

