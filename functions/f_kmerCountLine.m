function counts = f_kmerCountLine(seq, k)
% count the kmer apperance within the sequence. 
n = size(seq, 2);
len_counts = 4^k;
m_kmer_in_seq = n-k+1;
counts = zeros(1, len_counts);
for i=1:m_kmer_in_seq
    a_kmer = seq(1, i:(i+k-1));
    ix = f_ix_of_kmer(a_kmer);
    counts(1, ix) = counts(1, ix) + 1;
end


end

