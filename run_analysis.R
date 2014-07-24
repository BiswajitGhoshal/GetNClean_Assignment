## Get the input files and unzip them in the current directory
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(file_url, destfile = "getdata_projectfiles_UCI_HAR_Dataset.zip")
unzip("getdata_projectfiles_UCI_HAR_Dataset.zip")

# Go to the unzipped-directory and read in the labels and features
setwd("./UCI HAR Dataset")
aclab <- read.table("activity_labels.txt", sep=" ", col.names = c("Label", "Activity"))
features <- read.table("features.txt", sep=" ",col.names=c("SlNo","Feature"))

# Read-in the the test-data by merging subject, label (y_test), and features (x-test)
setwd("./test")
sub <- read.table("subject_test.txt", col.names = "Person_id")
lab <- read.table("y_test.txt", col.names = "y_label")
x_val <- read.table ("X_test.txt", col.names = features$Feature)
test_set <- data.frame(x_val, sub, lab)

# Read-in the the train-data by merging subject, label (y_train), and features (x-train)
setwd("../train")
sub_tr <- read.table("subject_train.txt", col.names = "Person_id")
lab_tr <- read.table("y_train.txt", col.names = "y_label")
x_val_tr <- read.table ("X_train.txt", col.names = features$Feature)
train_set <- data.frame(x_val_tr, sub_tr, lab_tr)

# Merge the two dataframes with rbind, sort it on the y_label, add a descriptive column, 
# Activity_name, with cbind and write the dataset in a file in the main directory
complete_set <- rbind(test_set, train_set)
complete_set <- complete_set[order(complete_set$y_label),]
library(sqldf)
Activity_name <- sqldf("select Activity from aclab, complete_set where Label == y_label")
complete_set <- cbind(complete_set, Activity_name)
write.table(complete_set, file="../../complete_set.txt")

## find the columns that give mean or standard deviation for each observation.
## add the Person_id (column 1), y_label and Activity name columns (563, and 564)
## and extract them into a dataset called meanstd_set.
m <- grep("mean", features$Feature)
s <- grep("std", features$Feature)
col2extract <- sort(c(m, s, 562, 563, 564))
meanstd_set <- complete_set[,col2extract]

## Appropriately label the dataset with proper column-names
colnames(meanstd_set) <- c("tBodyAccMeanX","tBodyAccMeanY","tBodyAccMeanZ","tBodyAccStdX","tBodyAccStdY","tBodyAccStdZ","tGravityAccMeanX","tGravityAccMeanY",
                           "tGravityAccMeanZ","tGravityAccStdX","tGravityAccStdY","tGravityAccStdZ","tBodyAccJerkMeanX","tBodyAccJerkMeanY",
                           "tBodyAccJerkMeanZ","tBodyAccJerkStdX","tBodyAccJerkStdY","tBodyAccJerkStdZ","tBodyGyroMeanX","tBodyGyroMeanY",
                           "tBodyGyroMeanZ","tBodyGyroStdX","tBodyGyroStdY","tBodyGyroStdZ","tBodyGyroJerkMeanX","tBodyGyroJerkMeanY",
                           "tBodyGyroJerkMeanZ","tBodyGyroJerkStdX","tBodyGyroJerkStdY","tBodyGyroJerkStdZ","tBodyAccMagMean","tBodyAccMagStd",
                           "tGravityAccMagMean","tGravityAccMagStd","tBodyAccJerkMagMean","tBodyAccJerkMagStd","tBodyGyroMagMean","tBodyGyroMagStd",
                           "tBodyGyroJerkMagMean","tBodyGyroJerkMagStd","fBodyAccMeanX","fBodyAccMeanY","fBodyAccMeanZ","fBodyAccStdX",
                           "fBodyAccStdY","fBodyAccStdZ","fBodyAccMeanFreqX","fBodyAccMeanFreqY","fBodyAccMeanFreqZ","fBodyAccJerkMeanX",
                           "fBodyAccJerkMeanY","fBodyAccJerkMeanZ","fBodyAccJerkStdX","fBodyAccJerkStdY","fBodyAccJerkStdZ","fBodyAccJerkMeanFreqX",
                           "fBodyAccJerkMeanFreqY","fBodyAccJerkMeanFreqZ","fBodyGyroMeanX","fBodyGyroMeanY","fBodyGyroMeanZ","fBodyGyroStdX",
                           "fBodyGyroStdY","fBodyGyroStdZ","fBodyGyroMeanFreqX","fBodyGyroMeanFreqY","fBodyGyroMeanFreqZ","fBodyAccMagMean",
                           "fBodyAccMagStd","fBodyAccMagMeanFreq","fBodyBodyAccJerkMagMean","fBodyBodyAccJerkMagStd","fBodyBodyAccJerkMagMeanFreq",
                           "fBodyBodyGyroMagMean","fBodyBodyGyroMagStd","fBodyBodyGyroMagMeanFreq","fBodyBodyGyroJerkMagMean","fBodyBodyGyroJerkMagStd",
                           "fBodyBodyGyroJerkMagMeanFreq","Person_id","y_label","Activity")

## Save the meanstd_set dataset into a file and get back to the directory from where the script had started.
write.table(meanstd_set, file="../../meanstd_set.txt")
setwd("../..")

## For each of the Subject and y_label combination (both of which are integer-data), get the subset of data, 
## find the column means, insert it into the final tall tidy dataset.
tidy_set <- NULL ## initialize the tidy_set 
library(reshape2) ## include the library that will be needed for 'melt' function
for (i in 1:length(unique(meanstd_set$Person_id))) {
    for (j in 1: length(unique(meanstd_set$y_label)))  {
        y <- NULL ## initialize temporary y-dataset
        x <- meanstd_set[meanstd_set$Person_id == i & meanstd_set$y_label == j, ]
        y <- melt(apply(x[,1:79], 2, mean))
        y <- data.frame(rownames(y), y[,1])
        l <- rep(i, nrow(y))
        a <- rep(aclab$Activity[j], nrow(y))
        y <- cbind(y, l, a)
        colnames(y) <- c("Variable", "Value", "Subject", "Activity")
        tidy_set <- rbind(tidy_set,y)
    }
}

write.table(tidy_set, file="tidy_set.txt")

