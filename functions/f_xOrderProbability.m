function [probTab, cTab] = f_xOrderProbability(seq, x)
% input a big sequence and x, get the probability table for the (x+1)mer
% (x-order Markov model)

k=x+1;
lenTab = 4^k;
% counter table
cTab = zeros(lenTab, 1);
%probTab = zeros(lenTab, 1);

for i=1:(length(seq)-x)
    tmpkmer = seq(i:i+x);
    ix = f_ix_of_kmer(tmpkmer);
    cTab(ix) = cTab(ix) + 1;
    
end
probTab = cTab./sum(cTab(:));

% then, the probTab can be parse to [seq] = f_genxOrderSeq(probTab, n) to
% generate the background seqs.
end

