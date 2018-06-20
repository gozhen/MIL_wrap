function f_write_seqs_fasta(fname, seqs)
% seqs: sequences are in char array format.
f = fopen(fname, 'w');
for i=1:size(seqs, 1)
    fprintf(f, '> seq_%d\n', i);
    fprintf(f, '%s\n', seqs(i, :));
end

fclose(f);
end

