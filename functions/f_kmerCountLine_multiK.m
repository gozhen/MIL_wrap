function counts = f_kmerCountLine_multiK(seq, ks)
% is01: choose from 0-1 table or counting table. 

counts=[];
for i=1:length(ks)
    c = f_kmerCountLine(seq, ks(i));
    counts = [counts, c];
end


end

