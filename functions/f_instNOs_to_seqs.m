function seqs = f_instNOs_to_seqs(whole_seqs, instNos, l, k, s)
% input the big list of sequences and a list of instance ids, and, also the
% other parameters, output the subset of the sequences, with the length l

n = size(whole_seqs, 1);
seqs=[];
for i=1:n
    a_full_seq = whole_seqs(i, :);
    a_sub_seq = f_instNO_to_seq(a_full_seq, instNos(i), l, k, s);
    seqs = [seqs; a_sub_seq];
end


end

