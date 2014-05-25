## Load required library
library(reshape2)

## Download and unzip file
fileUrl <- "https://d396qusza40orc.cloudfront.net/
            getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./HAR.zip")
unzip("HAR.zip")

## Read Features 
Features <- read.table("./UCI HAR Dataset/features.txt")
Features <- Features[, 2]

## Read in datasets and set column names
DataTrain <- read.table("./UCI HAR Dataset/train/X_train.txt", 
                        col.names=Features)
LabelTrain <- read.table("./UCI HAR Dataset/train/y_train.txt",
                        col.names="activity")
SubjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt",
                        col.names="subject")
DataTest <- read.table("./UCI HAR Dataset/test/X_test.txt",
                        col.names=Features)
LabelTest <- read.table("./UCI HAR Dataset/test/y_test.txt",
                        col.names="activity")
SubjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt",
                        col.names="subject")

## Merge Train dataset and test dataset
DataTrain2 <- cbind(SubjectTrain, LabelTrain, DataTrain) 
DataTest2 <- cbind(SubjectTest, LabelTest, DataTest)
mergedData <- merge(DataTest2, DataTrain2, all=TRUE)

## Subset data files to include only columns for means and stds 
ms <- grep("mean|std", colnames(mergedData))
f <- grep("meanFreq", colnames(mergedData))
g <- setdiff(ms, f)
SubData <- mergedData[, c(1,2,g)]

## Reshape the data frame and calculate the average of mean and std
MeltData <- melt(SubData, id=c(1,2), all=TRUE)
CastData <- dcast(MeltData, subject+activity ~ variable,
                  fun.aggregate = mean)

## Change the column names following the standard format
colnames(CastData) <- gsub("\\.\\.\\.", ".", colnames(CastData))
colnames(CastData) <- gsub("\\.\\.", "", colnames(CastData))
colnames(CastData) <- tolower(colnames(CastData))
colnames(CastData)[3:68] <- paste("average.of.", colnames(CastData)[3:68],sep="")

## Name the activities in the data set with descriptive word 
CastData$activity[CastData$activity == "1"] <- "walking"
CastData$activity[CastData$activity == "2"] <- "walking.upstairs"
CastData$activity[CastData$activity == "3"] <- "walking.downstairs"
CastData$activity[CastData$activity == "4"] <- "sitting"
CastData$activity[CastData$activity == "5"] <- "standing"
CastData$activity[CastData$activity == "6"] <- "laying"

## Write the tidy data frame to file
write.table(CastData, file="Smartphone_run analysis.txt")
