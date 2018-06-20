function [c_new, best_kmers] = ...
    f_TeamD_feature_filter_3( ctab, minK, maxK, labels)
% 8_6_2016: trim much more than before
% ctab is the counting table for all the 6000 sequences, including 3000
%  positives and 3000 negatives.
% label is an array contains 3000 1 and 3000 0
% topN: number of positive bags. (top N sequences we selected in the 
%  narrowPeak files)


% max_kmer_length = 5;
% min_kmer_length = 3;
num_kmers = sum(4.^(minK:maxK));
kmer_intensity = zeros(1, num_kmers);

% regularized_kmer_count = [2000 1000 500];
%                          6   7   8   9
regularized_kmer_count = [800 300 200 200]; % I will also trim 6mers
%                            5   6   7   8   9
%regularized_kmer_count_2 = [500 500 300 200 200]; % also trim 5mers this time 


for k = 1:num_kmers
    % zhen: they use median! not mean
    % zhen: refs.SignalMean's size is 6000 by 1. the values are 3.32
    %  and -3.32 for all posi and nega seqs respectively
    % 150803, zhen: since in this framework, it is not for predicting the
    %  intensity, rather it modeling the labels, I use nanmean rather than
    %  nanmedian. (since all the intensity contains only 2 values: 1 and 0) 
    
    % kmer_intensity(k) = nanmedian(labels(ctab(:, k) > 0, tf));
    kmer_intensity(k) = nanmean(labels(ctab(:, k) > 0, 1));
    % zhen: the above commond is simple: for each kmer, find the seqs
    %  which contain this kmer; then compute the median of the signal
end
valid = ~isnan(kmer_intensity);


best_kmers = 1:sum(4.^(minK:min(maxK, 5)));
for i=6:9
    if maxK >=i
        if (i-1)>=minK
            mersX = sum(4.^(minK:(i-1) ) );
            mersX = mersX + 1:(mersX+4^i);
            mersX = mersX(valid(mersX));
        else
            mersX = 1:4^i;
            %regularized_kmer_count = [1000 1000 500 500];
            % just for the case that cs = 6 or 7.
            %regularized_kmer_count = [3000 3000 500 500];  
            regularized_kmer_count = [4^6 4^7 500 500]; 
        end
        [~, order] = sort(kmer_intensity(mersX), 'descend');
        mersX = mersX(order);
        best_kmers = [best_kmers mersX(1:regularized_kmer_count(i-5))];
    end
end

%{
if maxK >= 6
    mers_6 = sum(4.^(minK:5));
    mers_6 = mers_6+1:mers_6+4^6;
    mers_6 = mers_6(valid(mers_6));
    [~, order] = sort(kmer_intensity(mers_6), 'descend');
    mers_6 = mers_6(order);
    best_kmers = [best_kmers mers_6(1:regularized_kmer_count(1))];
end

if maxK >= 7
    mers_7 = sum(4.^(minK:6));
    mers_7 = mers_7+1:mers_7+4^7;
    mers_7 = mers_7(valid(mers_7));
    [~, order] = sort(kmer_intensity(mers_7), 'descend');
    mers_7 = mers_7(order);
    best_kmers = [best_kmers mers_7(1:regularized_kmer_count(2))];
end
	
if maxK >= 8
    mers_8 = sum(4.^(minK:7)); % 21760
    mers_8 = mers_8+1:mers_8+4^8;
    mers_8 = mers_8(valid(mers_8));
    [~, order] = sort(kmer_intensity(mers_8), 'descend');
    mers_8 = mers_8(order);
    best_kmers = [best_kmers mers_8(1:regularized_kmer_count(3))];
end
	
if maxK >= 9
    mers_9 = sum(4.^(minK:8));
    mers_9 = mers_9+1:mers_9+4^9;
    mers_9 = mers_9(valid(mers_9));
    [~, order] = sort(kmer_intensity(mers_9), 'descend');
    mers_9 = mers_9(order);
    best_kmers = [best_kmers mers_9(1:regularized_kmer_count(4))];
end
%}

%best_kmers = unique([best_kmers size(A, 2)]);
% zhen: now the last element becomes 87296 
% I think it just adds a constant value to the end. The last column of
%  A is all 1. 

%valid_probes = ~isnan(refs.SignalMean(:, tf));
% zhen: size: 6000x1. it indicates the validness of the sequences. I
%  don't need it here. 

%c_new = double(full(ctab(:, best_kmers)));

c_new = ctab(:, best_kmers);


end

