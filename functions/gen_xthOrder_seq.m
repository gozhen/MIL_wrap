function [so] = gen_xthOrder_seq(s, x)
% generate a random sequence by the x-th order Markov chain model
% s: the input sequence
% so: the output sequence

order = x;
[~, ct] = f_xOrderProbability(s, order);

% convert the 64 by 1 counter table to 16 by 4
ct2 = reshape(ct,4, 4^order)';
% compute the probability table (16x1)
%pt = ct2 ./ repmat(sum(ct2,2), 1,4);
% in order to save computing time, we just make weight to ct rather than 
% using pt.
weight = ct2;

% handle the probability table that if some element is 0, make it 0.001
weight(weight==0) = 0.00001;
%weight,

len = length(s);
% generate the begining 2bp
%so = randseq(2);
rand_ix = randi(len-(order-1));
so = s(rand_ix:rand_ix+(order-1));

pattern = f_get_the_pattern(1);
for i=1:len-order
    ix = f_ix_of_kmer(so(end-(order-1):end));
    new_bp = pattern(randsample(4, 1, true, weight(ix, :)), :);
    so = [so, new_bp];
end


end
