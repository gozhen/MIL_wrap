function countTable = f_kmerCountLines_multiK(seqs, ks)
% given a list of sequences and the kmer length(s), 
%   map them into feature vectors.

% seqs shoud be a char matrix, no cell
countTable = zeros(size(seqs, 1), sum(4.^ks));
for i=1:size(seqs, 1)
    counts = f_kmerCountLine_multiK(seqs(i, :), ks);
    countTable(i, :) = counts;
    fprintf('  seq %d\n', i);
end

end


