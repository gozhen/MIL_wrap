%% Example of using f_top_fa_subSeqs() 
% Predict instance scores and generate top instances from fasta file. The
%  generated fasta file can be used by MEME motif finding suite.
% 
% This function receives a fasta file of ChIP-seq peaks (e.g.: top 3000
%  peaks with highest signal values and each with 500 bp), and outputs the
%  top subsequences for each sequence by our multi-instance learning (MIL) 
%  based method. Also outputs the predicted instance probabilities with
%  size nBags x nInsts.
clear; clc;

addpath('./functions/');
%%

% fasta input file
fa_in = './data/peak_from_encode_in_fa/1_gata2.txt';
fa_out = './1_gata2_TI.txt';

% c = 75;
% s = 10;

c = 250;
s = 100;

%k = 4:7;
k = 4:5;
mat = f_top_fa_subSeqs(fa_in, fa_out, c, s, k );


%% Example of using f_gen_model_fromFasta_mil() to genereate a model
% Only generate a MIL model

fa_in = './data/peak_from_encode_in_fa/1_gata2.txt';
fname_model = './1_gata2_model.mat';


c = 250;
s = 50;
k = 4:5;
% Note: here we recommend to use kmer length NO-longer than 5. In order 
%  to keep all the feature consistant, we cannot use TeamD feature 
%  selection;but if we keep all the features for kmer length longer than 6, 
%  the AUC will be very low. We recommend to use k=4:5, which gives the 
%  best result. 
f_gen_model_fromFasta_mil(fa_in, fname_model, c, s, k );

%% Example of using f_gen_model_from_std_file() to generate a model from a std file
% on ChIP-Seq data
clear;clc;

% std input file
fn_std_in = './data/std/ChIP-Seq/1_gata2.txt';
fname_model = './1_gata2_model.mat';


c = 250;
s = 100;

%k = 4:7;
k = 4:5;
f_gen_model_from_std_file(fn_std_in, fname_model, c, s, k );

%%
% example on PBM data
clear;clc;

% std input file
fn_std_in = './data/std/pbm/TF_6_Gata4_data_1.txt';
fname_model = './TF_6_Gata4_model.mat';

c = 35;
s = 35;

k = 4:5;
f_gen_model_from_std_file(fn_std_in, fname_model, c, s, k );


%% Example of using f_top_fa_subSeqs_byModel() 
% Predict instance scores and generate top instances using a already-built 
%  model for sequences in a testing fasta file. 

clear;clc;
fa_in = './data/peak_from_encode_in_fa/1_gata2.txt';
fa_out = './1_gata2_TI.txt';
fname_model = './1_gata2_model.mat';


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


