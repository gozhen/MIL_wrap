Description of core functions:


f_genData_MilCount_regress.m
  function maps sequences into feature vectors

f_TeamD_feature_filter.m
  function filters out kmer features for TeamD when kmer length larger than 6. 

f_cv_regress_for_milc.m
  Evaluation on data with the MIL-wrap algorithm using Stratified k-fold cross-calidation.

f_predict_y_bag.m
  wrap MIL method of predicting bag label using the predicted instance labels.

f_bag_ix_to_inst_ixs.m
  convert a bag index to a list of indeces of the instances

f_bag_ixs_to_inst_ixs.m
  convert a list of bag indeces to a list of instances indeces

f_get_class_labels.m
  convert the class labels from 'p' and 'n' to real value labels.

f_get_instance_ranges.m
  Compute the instance ranges of the instances.

f_ix_of_kmer.m
  get the index of the input kmer

f_kmerCountLine.m
  count the kmer apperance within the sequence. 

f_kmerCountLines_multiK.m
  given a list of sequences and the kmer length(s), map them into feature vectors.

f_multi_lin_regress_predict.m
  build a linear regression model on training data, then use the model to predict testing data.

f_read_std_file.m
  read the training sequences file by the given file name.

f_SampleError.m
  used to calculating AUC

f_StratifiedKFold.m
  divides instances for stratified k-fold cross calidation.

strsplit_1.m
  split a string into several sections by a delimiter.

