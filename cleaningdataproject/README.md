This is the README file for the script 'run_analysis.R'

The run_analysis.R script is meant to run inside an environment 
where the HCI HAR Dataset is located. It starts off by loading 
the training and test data sets into memory. It also reads in 
two 1-collumn datasets 'subject_train' and 'subject_test'. These two 
collumns match up with the training and test data sets to indicate
the subject who performed the record on each row. 

Like the subject datasets, there are two 1-collumn datasets called
'y_train' and 'y_test' that match up with the training and test
datasets to indicate what activity is being performed by the subject. 

The features.txt file is read into memory and used to give descriptive 
names to the variables in the test and training sets. Then the sets are 
merged with a call to rbind and stored in 'mergedData', which currently
has 561 variables. 

After the rbind takes place, calls to grep extract the collumn indicies 
at which mean and standard deviation measurements are located. These
indicies are then used to subset the merged dataset.

y_train and y_test are row binded in the same order as X_train and X_test.
The resulting 1-collumn is named 'activity'. subject_train and subject_test 
are row binded and the resulting 1-collumn is named 'subject'.

A series of calls to cbind, merge the subject, activity, means, and standard 
deviation dataframes and store the resulting dataset in 'mergedData', which
now has 81 variables. 

A for-loop replaces integer markers for activities with their actual names. 

A for-loop prepends "subj_act_avg" to the each of the 79 measurement variables 
in mergedData. 

A tidyData dataframe is initialized with 81 collumns. Nested for-loops with calls to 
split and colMeans browses the mergedData set and takes averages for each activity 
and for each subject. 