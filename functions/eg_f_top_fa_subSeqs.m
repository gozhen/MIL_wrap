%% Example of using f_top_fa_subSeqs() 
% Predict instance scores and generate top instances from fasta file. The
%  generated fasta file can be used by MEME motif finding suite.
%
% This function receives a fasta file of ChIP-seq peaks (e.g.: top 3000
%  peaks with highest signal values and each with 500 bp), and outputs the
%  top subsequences for each sequence by our multi-instance learning (MIL) 
%  based method. Also outputs the predicted instance probabilities with
%  size nBags x nInsts.
clear;clc;

% fasta input file
%fa_in = '1_gata2.txt';
fa_in = '0_test_fa.txt';
%fa_out = '1_gata2_TI.txt';
fa_out = '0_test_fa.txt';

% c = 75;
% s = 10;

c = 250;
s = 100;

%k = 4:7;
k = 4:5;
mat = f_top_fa_subSeqs(fa_in, fa_out, c, s, k );


%% Example of using f_gen_model_fromFasta_mil() to genereate a model
% Only generate a MIL model

%fa_in = '1_gata2.txt';
% fa_in = '0_test_fa.txt';
fa_in = '0_test_fa.txt';

%fname_model = '1_gata2_model.mat';
% fname_model = '0_test_fa_model.mat';
fname_model = '0_test_fa_model.mat';

% c = 75;
% s = 10;
c = 250;
s = 50;
k = 4:5;
% Note: here we recommend to not use kmer length longer than 5. In order 
%  to keep all the feature consistant, we cannot use TeamD feature 
%  selection;but if we keep all the features for kmer length longer than 6, 
%  the AUC will be very low. We recommend to use k=4:5, which gives the 
%  best result. 
f_gen_model_fromFasta_mil(fa_in, fname_model, c, s, k );



%% Example of using f_top_fa_subSeqs_byModel() 
% Predict instance scores and generate top instances using a already-built 
%  model for sequences in a testing fasta file. 

clear;clc;
% fa_in = '1_gata2.txt';
% fa_out = '1_gata2_TI.txt';
% fname_model = '1_gata2_model.mat';

% fa_in = '0_test_fa.txt';
% fa_out = '0_test_fa_TI.txt';
% fname_model = '0_test_fa.txt.mat';

fa_in = '0_test_fa.txt';
fa_out = '0_test_fa_TI.txt';
fname_model = '0_test_fa.txt.mat';

% load model; the variable of the model is 'b'.
load(fname_model);
% c = 75;
% s = 10;
c = 250;
s = 50;
k = 4:5;

% b is the model
mat = f_top_fa_subSeqs_byModel(fa_in, fa_out, b, c, s, k );
% mat is the predicted instances scores with size n_bags * n_insts_per_bag

%% Example of drawing counts of predicted positive instances 
cutoff = 0.8 ;
f_plot_peaks_milTeamD_ChIPseq(mat,  cutoff );

% or let the cutoff to be automatically determined:
% f_plot_peaks_milTeamD_ChIPseq(mat);

%%


%%


%%


