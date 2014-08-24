The Project is composed of several data files.

features.txt is a list of all of the measurements that were taken.

feautures_info.txt explains the different features and what they refer to.

The activity_labels.txt describe the 6 different activities that were measure among the 30 subjects.

The folder "test" and "train" contains the test data and has several files:

- subject_test.txt: constains all the subject activities related to each data sets
- X_test.txt: constains all the measurements
- y_test: has all indexes for the different activities of the data set.

Variables in the script:
X_test / X_train: reads the measurements for 
X_test_subset/ X_train_subset: the subset of the whole set of variables with only the means and std dev subset
TestTrain: the compilation of the 2 test and train datasets
result: the resulting data table with the aggregations of means
