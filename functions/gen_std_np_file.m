function [] = gen_std_np_file(fname_fasta, x, fname_out)
% read a fasta file, output a training file of our standard 'np' format.
% fname_fasta: the input fasta file name
% x: xth-order Markov chine model. 
% fname_out: the output file name 
%
% n_nega: the number of nagetive seqs to generate, usually the number of 
%  negative sequences should be the same as the number of positive 
%  sequences. 
% len_aseq: the length of a sequence. Since we are using the equal-length
%  model, so the length of each negative sequence should be the same as
%  each positive sequence. First we tried 200. The positive sequence length
%  depends on the previous fasta files and bed files. 

% workfolw: 1. read the fasta file and convert the sequences to the new
% format of 'a sequence, p'
% 2. compute the Markov chine model and then generate the negative
% sequences on the go


% read fasta file 
[~, seqs] = fastaread(fname_fasta);
n_posi_seqs = length(seqs);
n_nega_seqs = n_posi_seqs;

f_out = fopen(fname_out, 'wt');
% generate the output file
% firstly write the positive seqs

textprogressbar('Loading positive sequences:             ');
ratio = round(n_posi_seqs / 100);
for i=1:n_posi_seqs
    fprintf(f_out, '%s p\n', seqs{i});
    %fprintf('posi %d\n',i);
    textprogressbar( floor(i/ratio));
end
textprogressbar(100);
textprogressbar('  Done');

%len_aseq = length(seqs{1}); % in this case, all seqs have the same length

textprogressbar('Generating negative sequences:          ');
ratio = round(n_nega_seqs / 100);
for i=1:n_nega_seqs
    % compute the probability table
    a_seq_posi = seqs{i}; % the corresponding positive seq
    a_seq_nega = gen_xthOrder_seq(a_seq_posi, x);
    fprintf(f_out, '%s n\n', a_seq_nega);
    %fprintf('nega %d\n',i);
    textprogressbar( floor(i/ratio));
    
end
textprogressbar(100);
textprogressbar('  Done');

fclose(f_out);


end

