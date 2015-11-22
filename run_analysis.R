## Getting and Cleaning Data Week 3 Assignment 
## Create one R script called run_analysis.R that does the following: 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library("data.table")
library("reshape2")

## 1. Merge the training and the test sets to create one data set.
#  1.a Upload training data 
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# 1.b Upload the testing data 
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# 1.c Merge the training and testing data sets
X_merged <- rbind(X_train, X_test)
y_merged <- rbind(y_train, y_test)
subject_merged <- rbind(subject_train, subject_test)

## 2. Extract only the measurements on the mean and standard deviation for each measurement. 
#  2.a Read features, i.e. column names for X dataset, from the file features.txt
features <- read.table("UCI HAR Dataset/features.txt")

#  2.b Find which columns correspond to mean and std measurments
mean_std_column <- grepl("mean|std", features[,2])

#  2.c Extract only the measurments on the mean and std
X_merged <- X_merged[,mean_std_column]

## 3. Use descriptive activity names to name the activities in the data set
#  3.a Read activity labels from the file activity_labes.txt
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

#  3.b Add a column of discriptive activity names using using activity IDs from the variable y_merged
y_merged[,2] <- activity_labels$V2[y_merged[,1]]

## 4. Appropriately label the data set with descriptive variable names. 
#  4.1 Label the columns of each variable
names(X_merged) = features[mean_std_column,2]
names(y_merged) = c("activity_ID", "activity_label")
names(subject_merged) = "subject_ID"

#  4.2 Combine X, y and subject subsets into one dataset
data <- cbind(subject_merged,y_merged,X_merged)

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#  5.1 Create a melted data set
id_labels   = c("subject_ID", "activity_ID", "activity_label")
data_labels = setdiff(colnames(data), id_labels)
melted_data <- melt(data, id = id_labels, measure.vars = data_labels)

#  5.2 Create tidy data set: apply mean to dataset using dcast() function
tidy_data <- dcast(melted_data, subject_ID+activity_ID ~ variable, mean)

## Save tidy dataset using write.table() function
write.table(tidy_data, file = "./tidy_data.txt",row.name=FALSE)
