function [train, test] = f_StratifiedKFold(n, k_fold)
% form the sets for cross-validation.
% n: length of the data

train = {};
test={};

indeces = 1:n;
for i=1:k_fold
    tf = rem(indeces-1, k_fold)==(i-1);
    test{i, 1} = find(tf);
    train{i, 1} = find(~tf);

end

if k_fold == 1
    train = test;
end

end

