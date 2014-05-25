Smartphone-Run-Data
===================
### For the project of the coursera course "Getting and Cleaning Data"

### Origin of Raw Data
The raw data can be found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
This file contains data collected from the accelerometers from the Samsung Galaxy S smartphone tracking human activities.

### Project Goal
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### Procedure
* Download and unzip the data file
* Read in datasets (test data set and train data set), name the columns accordinngly
* Merge these two data set
* Extract only the measurements on the mean and standard deviation for each measurement
* Calculating average of each variable for each activity and each subject
* Standardize the column names
* Renaming the activity code to actual activity name
* Write the data table to text file 

### Comments
* Procedures are interwound to achieve the goals
* More detailed procedure can be found in CodeBook file
* R script can be found in run.analysis.R file
