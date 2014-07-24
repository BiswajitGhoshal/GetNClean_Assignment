## README.md  
Explains how the script works and the flow therein.  

### Important Note :-  
Needless to say that, if the user of run_analysis.R already has the downloaded zipped-data and/or if s/he wants to have only the final tidy dataset, s/he should comment out the file-downloading and file-writing instructions (for complete_set and meanstd_set datasets) on this script before running it.

### Creation of complete_set :-   
1. First the script downloads and unzips the file from the URL : "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip".  

2. Then it reads in the activity-labels and features.

3. Then it reads-in the the test-data and merges features (x-test), subject and label (y_test) with 'data.frame'.  It does the same with train-data and merges the test-data and train-data sets with 'rbind'.

4. The combined dataset is then sorted on activity-code (y_label) and Activity description is added as the last column.  This complete dataset is then saved in the parent directory where this script started execution.   

### Creation of meanstd_set

5. The columns with 'mean' or 'std' in their names are picked up from the complete dataset (alongwith the subject, activity-code, i.e. y_label, and descriptive activity-code) and is saved as meanstd_set.  
6. This dataset is then appropriately labelled with descriptive variable names and saved into the disk.  

### Creation of tidy_set  

7. For each activity and subject a subset of meanstd_set is selected, and means for each of the columns are calculated for the subset.  
8. A temporary dataset is created with the variable names, their mean-values, subject-id and activity-description and 'rbind'-ed to the main final tidy_set.  
9. Finally, the tidy_set is saved to the disk.  
