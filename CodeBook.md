## Code book :  

Describes the variables, the data, and any transformations or work that have been performed to clean up the data ##  

### Important Note :-  
If the user of run_analysis.R already has the downloaded zipped-data and/or if s/he wants to have only the final tidy dataset, s/he should comment out the file-downloading and file-writing instructions (for complete_set and meanstd_set datasets) on this script before running it.

The output of this analysis work are 3 datasets as described below:-

* ### complete_set :- 
1. Contains all the training and test data for x-values, y-values, activity code and activity description (564 variables).  The first row gives the variable-names.  
2. The first 561-variables bear the same names as given in the input-file, 'features.txt'.  The last 3-variables are named : 'Person_id', 'y_label' and 'Activity'.  

* ### meanstd_set :- 
1. Contains all the variables that measure mean or standard deviations in the x-values dataset.  There are total such 79 variables.  
2. Only those variables have been picked-up that have names containing the string 'mean' or 'std'.  
3. The dots (.) have been removed and more readability have been introduced in the variable-names.  
4. The variables in this dataset are : "tBodyAccMeanX","tBodyAccMeanY","tBodyAccMeanZ","tBodyAccStdX","tBodyAccStdY","tBodyAccStdZ","tGravityAccMeanX","tGravityAccMeanY",  
"tGravityAccMeanZ","tGravityAccStdX","tGravityAccStdY","tGravityAccStdZ","tBodyAccJerkMeanX","tBodyAccJerkMeanY","tBodyAccJerkMeanZ",  
"tBodyAccJerkStdX","tBodyAccJerkStdY","tBodyAccJerkStdZ","tBodyGyroMeanX","tBodyGyroMeanY","tBodyGyroMeanZ","tBodyGyroStdX",  
"tBodyGyroStdY","tBodyGyroStdZ","tBodyGyroJerkMeanX","tBodyGyroJerkMeanY","tBodyGyroJerkMeanZ","tBodyGyroJerkStdX","tBodyGyroJerkStdY",  
"tBodyGyroJerkStdZ","tBodyAccMagMean","tBodyAccMagStd","tGravityAccMagMean","tGravityAccMagStd","tBodyAccJerkMagMean",  
"tBodyAccJerkMagStd","tBodyGyroMagMean","tBodyGyroMagStd","tBodyGyroJerkMagMean","tBodyGyroJerkMagStd","fBodyAccMeanX",  
"fBodyAccMeanY","fBodyAccMeanZ","fBodyAccStdX","fBodyAccStdY","fBodyAccStdZ","fBodyAccMeanFreqX","fBodyAccMeanFreqY",  
"fBodyAccMeanFreqZ","fBodyAccJerkMeanX","fBodyAccJerkMeanY","fBodyAccJerkMeanZ","fBodyAccJerkStdX","fBodyAccJerkStdY",  
"fBodyAccJerkStdZ","fBodyAccJerkMeanFreqX","fBodyAccJerkMeanFreqY","fBodyAccJerkMeanFreqZ","fBodyGyroMeanX","fBodyGyroMeanY",  
"fBodyGyroMeanZ","fBodyGyroStdX","fBodyGyroStdY","fBodyGyroStdZ","fBodyGyroMeanFreqX","fBodyGyroMeanFreqY","fBodyGyroMeanFreqZ",  
"fBodyAccMagMean","fBodyAccMagStd","fBodyAccMagMeanFreq","fBodyBodyAccJerkMagMean","fBodyBodyAccJerkMagStd",  
"fBodyBodyAccJerkMagMeanFreq","fBodyBodyGyroMagMean","fBodyBodyGyroMagStd","fBodyBodyGyroMagMeanFreq","fBodyBodyGyroJerkMagMean",  
"fBodyBodyGyroJerkMagStd","fBodyBodyGyroJerkMagMeanFreq","Person_id","y_label","Activity".  

* ### tidy_set :- 
1. An independent tidy data set with the average of each variable (in the 'meanstd_set' created above) for each activity and each subject.  
2. contains 4 variables : "Variable", "Value", "Subject" and "Activity".  


