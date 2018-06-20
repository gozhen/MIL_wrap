function ix = f_ix_of_kmer(kmer)
% f_ix_of_kmer : get the index of a kmer
%  kmer here is a string contains 'A', 'C', 'G' or 'T' and it must only
%  contains these 4 knids of chars.
%  ix is the index
len = length(kmer(1,:));
% compute the index value
ix = 1;
el=0;
for j=1:len
    % el = 0;
    if strcmpi(kmer(1,j), 'A')
        el = 0;
    elseif strcmpi(kmer(1,j), 'C')
        el = 1;
    elseif strcmpi(kmer(1,j), 'G')
        el = 2;
    elseif strcmpi(kmer(1,j), 'T')
        el = 3;
    end
    ix = ix + el*4^(len-j);           
end

end

