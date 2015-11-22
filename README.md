## Getting and Cleaning Data

### The Purpose of the The Assignment
The purpose of this project is to demonstrate our ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

###  The Data for the Project: 
Download the data necessary for this project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### Run the Script "run_analysis.R"
Make sure you have data.table and reshape2 packages installed. Run the script "run_analysis.R", which performs the following: 

1. Merges the training and the test sets to create one data set:
  1. Uploads training data 
  2. Uploads the testing data 
  3. Merges the training and testing data sets

2. Extracts only the measurements on the mean and standard deviation for each measurement: 
  1. Reads features, i.e. column names for X dataset, from the file features.txt
  2. Finds which columns correspond to mean and std measurments
  3. Extracts only the measurments on the mean and std

3. Uses descriptive activity names to name the activities in the data set:
  1. Reads activity labels from the file activity_labes.txt
  2. Adds a column of discriptive activity names using using activity IDs from the variable y_merged

4. Appropriately labels the data set with descriptive variable names: 
  1. Labels the columns of each variable
  2. Combines X, y and subject subsets into one dataset

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.:
  1. Creates a melted data set
  2. Creates tidy data set: apply mean to dataset using dcast() function

6. Saves tidy dataset into a file tidy_data.txt using write.table() function.


