function [ ] = f_plot_peaks_milTeamD_ChIPseq(y_predict, ct )
% 

if nargin < 2
    % if no cutoff is given, auto demtermine it. Choose top 10% as positive
    [new, ~] = sort(y_predict(:), 'descend');
    topN = numel(y_predict) * 0.1;
    ct = new(topN);
end

n_bags = size(y_predict, 1);
%n_inst_per_bag = size(y_predict, 2);

a = y_predict > ct;

hold on
  plot(sum(a(1:round(n_bags/2),:)));
  plot(sum(a(round(n_bags/2)+1:end,:)), 'k:')
hold off
    
ylabel('Positive counts');
xlabel('Inst. index');

h=legend('True positive counts', 'False positive counts');
h.EdgeColor = [0.8 0.8 0.8];

end


% Sample output:
% >>fa_in = '0_test_fa.txt';
% >>fa_out = '0_test_fa_TI.txt';
% >>fname_model = '0_test_fa.txt.mat';
% >>load(fname_model);
% >>c = 250;
% >>s = 50;
% >>k = 4:5;
% >>mat = f_top_fa_subSeqs_byModel(fa_in, fa_out, b, c, s, k );

% Generating feature vectors:             100%    [..........]  Done
% Predicting instance probabilities...                          Done
% Getting the top instances...                                  Done 
% Wrtting top instances to Fasta file...                        Done 



