function [seqs,labels] = f_read_std_file(fname)
% 
f = fopen(fname, 'r');

line = fgetl(f);
tmp = strsplit_1(line);
seqs = tmp{1,1};
labels = tmp{1,2};

while ~feof(f)    
    line = fgetl(f);
    tmp = strsplit_1(line);
    seqs = [seqs; tmp{1,1}];
    labels = [labels; tmp{1,2}];
end

fclose(f);
end

