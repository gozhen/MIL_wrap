function aucs = f_cv_regress_for_milc(X_inst, y_inst, y_bag, k_fold)
% using Stratified k-fold
%  call by f_predict_and_get_auc_milC()

inst_per_bag=length(y_inst)./length(y_bag);
% auc results will be put in a list.
aucs = zeros(k_fold,1);

[train, test] = f_StratifiedKFold(length(y_bag), k_fold);

% ------------------------------- par for ---------------------------------
%parfor i=1:k_fold
parfor i=1:k_fold
    
    train_ix_inst=f_bag_ixs_to_inst_ixs(train{i,1}, inst_per_bag)';
    test_ix_inst=f_bag_ixs_to_inst_ixs(test{i,1}, inst_per_bag)';

    X_inst_train=X_inst(train_ix_inst, :);
    X_inst_test=X_inst(test_ix_inst, :);
    y_inst_train=y_inst(train_ix_inst, :);
    y_bag_test = y_bag(test{i,1}, :);
    
    fprintf('Fold %d spliting the training and testing data.\n', i);
    y_inst_predicted = f_multi_lin_regress_predict(X_inst_train, ...
        y_inst_train, X_inst_test);
    fprintf(' computing bag labels.\n');
    y_bag_predicted =f_predict_y_bag(y_inst_predicted, ...
        inst_per_bag);
    fprintf('done fold %d.\n', i);
    
%     inst_per_bag
%     size(y_inst_predicted)
%     size(y_bag_predicted)
%     size(y_bag_test)
    auc = f_SampleError(y_bag_predicted, y_bag_test, 'AUC');
    aucs(i,1) = auc;
    
    
end

end

