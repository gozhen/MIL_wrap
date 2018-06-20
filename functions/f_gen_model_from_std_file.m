function f_gen_model_from_std_file(fn_std, fname_model, c, s, k, save_fe )
% Generate a MIL model

if nargin < 6
    % don't save the big feature vector file by default. 
    save_fe = 0;
end
if nargin < 5
    % we recommend to not use kmer length longer than 5. In order to keep
    %  all the feature consistant, we cannot use TeamD feature selection;
    %  but if we keep all the features for kmer length longer than 6, the
    %  AUC will be very low. We recommend to use k=4:5, which gives the 
    %  best result. 
    k = 4:5; 
end
if nargin < 4
    s = 10;
end
if nargin < 3
    c = 75;
end


%% Fasta file to std file
x = 2;  % use 2nd order Markov model
% if exist([fa_in, '.std'], 'file') ~= 2
%     gen_std_np_file(fa_in, x, [fa_in, '.std']);
% end
%fprintf('Loading sequences and labels...');
[seqs,labels] = f_read_std_file(fn_std);
%fprintf('                               Done\n');

%% Generate data: X, y
% use boolean feature rather than kmer counts. 
is01 = 1;
[X,y,y_bag] = f_genData_MilCount_regress_nonPar(seqs,labels, c, s, k, is01);
if save_fe == 1
    save([fn_std(1:end-4), '_Xy.mat'], 'X', 'y', 'y_bag');
end

%% Generate model 
fprintf('Generating model...');
X=double(X);    
[~, b] = f_cv_regress_for_milc_1_fold(X, y, y_bag);    
save(fname_model, 'b');
fprintf('                                           Done \n');
    
   

%%

end

% Sample output:

% >>fa_in = '0_test_fa.txt';
% >>fname_model = '0_test_fa.txt.mat';
% >>c = 250;
% >>s = 100;
% >>k = 4:5;
% >>f_gen_model_fromFasta_mil(fa_in, fname_model, c, s, k );

% Generating feature vectors:             100%    [..........]  Done
% Generating model...                                           Done 






















