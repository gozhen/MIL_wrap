function [y_predicted,b] = f_multi_lin_regress_predict(X_train, y, X_test)
% This function works more like a WEKA linear regression function.
%  X_traTin is the training data, y is the training labels.
%  X_test is for prediction

b = regress(y, [X_train, ones(size(y))]);
y_predicted = [X_test, ones(size(X_test,1), 1)] * b;

end

