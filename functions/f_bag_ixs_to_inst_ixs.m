function indeces = f_bag_ixs_to_inst_ixs( ixs, inst_per_bag )
% convert a list of bag indeces to a list of instances indeces

n=length(ixs);
indeces = f_bag_ix_to_inst_ixs(ixs(1), inst_per_bag);

for i=2:n
    indeces = [indeces, f_bag_ix_to_inst_ixs(ixs(i),inst_per_bag)];
end


end

