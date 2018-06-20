function mat = f_top_fa_subSeqs_byModel(fa_in, fa_out, b, c, s, k, save_fe )
% This function is revised from f_top_fa_subSeqs() with an additional input
%  of a model, b. This function predicts the instance probabilities and
%  generates the top instances which can be used by MEME suite for motif
%  finding. Note that we cannot use TeamD with kmer length 4:7 here,
%  because of that we cannot use feature selection for kmer length longer
%  than 6, since in many situations, we cannot keep the traning and testing
%  data with the same selected features (such as when we want to scan many 
%  potential co-factor motifs on a ChIP-seq data). Here we use k=4:5, which
%  also has very high AUC as we tested, and it also boosts up speed. 
%
% Parameters:
%  fa_in:   the input fasta file name. 
%  fa_out:  the output fasta file name. The output fasta file contains the
%           top subsequence for each sequence in 'fa_in'.
%  b:       a motif model trained by the MIL-TeamD method with kmer length
%           4:5.
%  c:       the subsequence (instance) length. Default is 75
%  s:       the instance shift range in our MIL algorithm. Default is 10
%  save_fe: save the feature vector file flag. default is don't save. 
%   
%  mat:     the reshape of y_inst_predicted with dimension: nBags x nInsts.
%

if nargin < 7
    % don't save the big feature vector file by default. 
    save_fe = 0;
end
if nargin < 6
    k = 4:5;
end
if nargin < 5
    s = 10;
end
if nargin < 4
    c = 75;
end


%% Fasta file to std file
x = 2;  % use 2nd order Markov model
if exist([fa_in, '.std'], 'file') ~= 2
    gen_std_np_file(fa_in, x, [fa_in, '.std']);
end
%fprintf('Loading sequences and labels...');
[seqs,labels] = f_read_std_file([fa_in, '.std']);
%fprintf('                               Done\n');

%% Generate data, X, y, etc...
[X,y,y_bag] = f_genData_MilCount_regress_nonPar(seqs,labels, c,s, k, 1);
if save_fe == 1
    save([fa_in(1:end-4), '_Xy.mat'], 'X', 'y', 'y_bag');
end

%% Predicting the instance probabilities
fprintf('Predicting instance probabilities...');
y_inst_predicted = [X, ones(size(X,1), 1)] * b;
fprintf('                          Done\n');


%% Get the top subsequences (instances)
fprintf('Getting the top instances...');
% mat is the reshape of y_inst_predicted with dimension: nBags x nInsts.
[top_sub_seqs, mat] = f_get_top_subSequences(y_inst_predicted, seqs, c, s);
fprintf('                                  Done \n');


%% Write to fasta file
if ~isempty(fa_out)
    fprintf('Wrtting top instances to Fasta file...');
    posi_seqs = top_sub_seqs(1:size(top_sub_seqs,1)/2, :); % only positive seqs
    %f_write_seqs_fasta([fn_fa, '_topSubs.fa'], posi_seqs); 
    f_write_seqs_fasta(fa_out, posi_seqs); 
    fprintf('                        Done \n');
end


%%

end

