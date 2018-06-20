function [X_inst, y_inst, y_bag] = ...
    f_genData_MilCount_regress(...
    seqs,labels, k,s, cs, is01)
% revised from f_genData_regularMilCount_forRegression_long_coarse(),
% used for multi-core conting table
%
% The parent function was revised from the python function: 
%  f_genArff_regularMilCount_forRegression_long_coarse
% but this function won't generate an arff file, it will generate a MATLAB
% mat array instead.
% 
% Labels is a char array 

nBags = size(labels,1);
% length of sequence
l=length(seqs(1,:));

y_bag = f_get_class_labels(labels);

% Number of features
nc = 0;
for i=1:length(cs)
    nc=nc+4^cs(i);
end
% nc = sum(4.^cs);
%nc = 4^c;

% r (kmer_inst_ranges): the start points and end points of the instances.
r = f_get_instance_ranges(l,k,s);

% Number of instances per bag
nInsts = size(r, 1);
y_inst=repmat(y_bag, [1, nInsts])';
y_inst=y_inst(:);

if is01
%     if nBags*nInsts > 4^6 * ((500-10)/5+1)
%         X_inst = sparse(false(nBags*nInsts, nc));
%     else
        X_inst = false(nBags*nInsts, nc);
%     end
else
%     if nBags*nInsts > 4^6 * ((500-10)/5+1)
%         X_inst = sparse(zeros(nBags*nInsts, nc));
%     else
        X_inst = zeros(nBags*nInsts, nc);
%     end
end

% ------------------------------- par for ---------------------------------
%parfor i=1:nBags
parfor i=1:nBags
    
    % start to go over the bag
    aseq = seqs(i, :);
    
    % a small part of X
    if is01
        X_sm = false(nInsts, nc);
    else
        X_sm = zeros(nInsts, nc);
    end
    % in order to use the parfor, I need to put the r here.
    r = f_get_instance_ranges(l,k,s);
    for j=1:nInsts
        % akmer is an instance in a bag
        akmer = aseq(r(j, 1) : r(j, 2));
        % feature vector
        feV=f_kmerCountLine_multiK(akmer, cs);
        if is01
            feV = logical(feV);
        end
        %id = f_instFullId(i, j, nInsts);
        %X(id, :) = feV;
        X_sm(j, :) = feV;
    end
    % store X in a temporary cell array to utilize parfor
    X_tmp{i, 1} = X_sm;
    
    if rem(i, 1000) == 0 
        fprintf('%d \n', i);
    end
end

% after the parallel computing of X, I need to convert X back to an array.
for i=1:nBags
    indeces = f_bag_ix_to_inst_ixs(i, nInsts);
    X_inst(indeces(1):indeces(end), :) = X_tmp{i, 1};
end


end

