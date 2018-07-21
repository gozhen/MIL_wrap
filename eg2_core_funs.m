%%
% need MATLAB version 8.6; Statistics and Machine Learning Toolbox 10.1
clear;clc;
%%
addpath('./functions/');

% -k <k-mer lengths. e.g.:[5], [4,5,6,7,8], [3,4,5]>
% Note that the original TeamD uses c=4:8, while a simple kmer counting
%  method use a single value
k       = [3,4,5];
% -L <instance length. e.g.: 250>
L       = 250;
% -s <instance shift range. e.g.: 50>
s       = 50;
% is01: use 0-1 table or using the counting table. TeamD uses 0-1 table as 
%  features, while the traditional method often uses counting table as
%  features. 
is01    = true;

%% number of folds of the cross validation.
k_folds = 5;


path_workSpce = './';
path_std = [path_workSpce, 'data/'];
fname_std = [path_std, '1_gata2.txt'];

%% read the sequence file into workspace.
[seqs,labels] = f_read_std_file(fname_std);
% map sequences into feature vectors
[X,y,y_bag]=f_genData_MilCount_regress(seqs,labels, L,s,k, is01);

% if c>6, then filter out most of bad kmer features:
if max(k)>=6
    X=f_TeamD_feature_filter(X,min(k),max(k),y);
end

fprintf('done generating data X and y\n\n');
% ------------------------------------------------------------------
%% evaluation
aucs = f_cv_regress_for_milc(X, y, y_bag, k_folds);
fprintf(' done predicting \n' );

fprintf(' AUC = %f \n', mean(aucs));



