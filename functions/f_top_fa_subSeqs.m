function mat = f_top_fa_subSeqs(fa_in, fa_out, c, s, k, save_fe, save_m )
%
% This function receives a fasta file of ChIP-seq peaks (e.g.: top 3000
%  peaks with highest signal values and each with 500 bp), and outputs the
%  top subsequences for each sequence by our multi-instance learning (MIL) 
%  based method. Also outputs the predicted instance probabilities with
%  size nBags x nInsts.
%
% Workflow:
%  1. Generating nagative sequences by 2nd order Markov model on the input 
%     positive sequences.
%  2. Calculating the feature vectors for the positive and negative 
%     sequences in MIL format. 
%  3. Apply TeamD's feature selection.
%  4. Predicting the probability to be positive for each instance.
%  5. Output the top subsequence (the instance with top predicted 
%     probability within a bag) for each positive sequence in fasta format.
%
% Parameters:
%  fa_in:   the input fasta file name. 
%  fa_out:  the output fasta file name. The output fasta file contains the
%           top subsequence for each sequence in 'fa_in'.
%  c:       the subsequence (instance) length. Default is 75
%  s:       the instance shift range in our MIL algorithm. Default is 10
%  save_fe: save the feature vector file flag. Default is don't save. 
%  save_m:  indicate whether to save the model. Default is don't save.
%   
%  mat:     the reshape of y_inst_predicted with dimension: nBags x nInsts.
%
% Note: 
% we obtained the fasta input file by converting from the original
%  narrowPeak file from ENCODE:
%  http://ftp.ebi.ac.uk/pub/databases/ensembl/encode/integration_data_jan20
%  11/byDataType/peaks/jan2011/peakSeq/optimal/
%
% To cenvert the narrowPeak file to bed file, one can use our function:
%  f_narrowPeak_to_bed(np_in, bed_out, top_n, len)
%
% To convert the bed file to a fasta file, one can use the UCSC genome 
%  browser - table browser by input the bed file, or, use our function 
%  f_bed_to_fasta_hg19(fn_bed, fn_fasta, genome_index_file). However, a
%  genome index file is needed. 

if nargin < 7
    save_m = 0;
end
if nargin < 6
    % don't save the big feature vector file by default. 
    save_fe = 0;
end
if nargin < 5
    % If want to boost speed, one can try change the max(k) from 7 to 5,  
    %  which will dramativally boost up speed without missing important 
    %  motifs. 
    k = 4:7;
    %k = 4:6;
    %k = 4:5; 
end
if nargin < 4
    s = 10;
end
if nargin < 3
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

%% TeamD feature selection
fprintf('TeamD feature selection...');
% X = f_TeamD_feature_filter_3(X, min(k), max(k), y, size(y_bag,1)/2 );
X = f_TeamD_feature_filter_3(X, min(k), max(k), y );
fprintf('                                    Done\n');


%% Predicting the instance probabilities
fprintf('Predicting instance probabilities...');
[y_inst_predicted, b] = f_cv_regress_for_milc_1_fold(X, y, y_bag);
fprintf('                          Done\n');
if save_m == 1
    save([fa_in(1:end-4), '_model.mat'], 'b');
end

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


% Sample output:

% >>fa_in = '0_test_fa.txt';
% >>fa_out = '0_test_fa.txt';
% >>c = 250;
% >>s = 100; 
% >>k = 4:5;
% >>mat = f_top_fa_subSeqs(fa_in, fa_out, c, s, k );

% Loading positive sequences:             100%    [..........]  Done
% Generating negative sequences:          100%    [..........]  Done
% Generating feature vectors:             100%    [..........]  Done
% TeamD feature selection...                                    Done
% Predicting instance probabilities...                          Done
% Getting the top instances...                                  Done 
% Wrtting top instances to Fasta file...                        Done 



