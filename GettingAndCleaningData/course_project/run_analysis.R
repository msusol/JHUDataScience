## The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to 
## prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions 
## related to the project. You will be required to submit: 
##   1) a tidy data set as described below, 
##   2) a link to a Github repository with your script for performing the analysis, and 
##   3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
## You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

## One of the most exciting areas in all of data science right now is wearable computing 
## Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.
## - see for example this article:  
##  http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/
 
## The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
## A full description is available at the site where the data was obtained: 
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six 
## activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on 
## the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at 
## a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly 
## partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

## The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding
## windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion 
## components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed 
## to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of 
## features was obtained by calculating variables from the time and frequency domain. 

## Here are the data for the project: 
##  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## You should create one R script called run_analysis.R that does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

dataFile = "uciHarDataset.rda"
dataDir = "UCI HAR Dataset/"
if ( !file.exists(dataFile) ) {
  ## Download the ZIP package, extract, if needed.
  if (!file.exists(dataDir)) {
    fileURL <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip"
    download.file(fileURL, "data.zip", method = "curl", quiet = TRUE, mode = "wb")
    unzip("data.zip")
    file.remove("data.zip")
  }

  setwd(dataDir)
  labels = read.table("activity_labels.txt", sep = "")
  activityLabels = as.character(labels$V2)
  features = read.table("features.txt", sep = "")
  attributeNames = features$V2
  
  ## train
  data.train.X <- read.table("train/X_train.txt", sep = " ")
  names(data.train.X) = attributeNames
  data.train.Y = read.table("train/y_train.txt", sep = "")
  names(data.train.Y) = "Activity"
  data.train.Y$Activity = as.factor(data.train.Y$Activity)
  levels(data.train.Y$Activity) = activityLabels
  subjects.train = read.table("train/subject_train.txt", sep = "")
  names(subjects.train) = "Subject"
  subjects.train$Subject = as.factor(subjects.train$Subject)
  data.train = cbind(data.train.X, subjects.train, data.train.Y)
  
  ## test
  data.test.X <- read.table("test/X_test.txt", sep = "")
  names(data.test.X) = attributeNames
  data.test.Y = read.table("test/y_test.txt", sep = "")
  names(data.test.Y) = "Activity"
  data.test.Y$Activity = as.factor(data.test.Y$Activity)
  levels(data.test.Y$Activity) = activityLabels
  subjects.test = read.table("test/subject_test.txt", sep = "")
  names(subjects.test) = "Subject"
  subjects.test$Subject = as.factor(subjects.test$Subject)
  data.test = cbind(data.test.X, subjects.test, data.test.Y)
  
  ## merge training & test data
  data.train$Partition = "Train"
  data.test$Partition = "Test"
  data = rbind(data.train, data.test)
  data$Partition = as.factor(data$Partition)
  
  setwd("../")
  save(data, data.train, data.test, file=dataFile)
  rm(data.train.X, data.train.Y, data.test.X, data.test.Y, subjects.train, subjects.test, labels, features, activityLabels, attributeNames)
} else {
  load(dataFile)
  rm(data.train)
  rm(data.test)
}

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## note: a "measurement" is taken to be a feature with both a mean() & std() value in data

library(dplyr)
library(tidyr)
## reduces 564 columns down to 480 columns, by removing duplicated columns
data <- data[,!duplicated(names(data))]

## use the gather (or melt) function to format the dataframe to a LONG format
data.long <- data %>%
  select(subject, Activity, contains("mean()"), contains("std()")) %>%
  gather(feature, value, -subject, -Activity) %>%
  group_by(subject, Activity, feature) %>%
  summarize(avg = mean(value))

## use the dcast function to format the dataframe to a WIDE format
library(reshape2)
data.wide <- dcast(data.long, subject + Activity ~ feature, value.var="avg")

## let us tidy up the column names
## "tBodyAcc.mean.X" <- gsub("\\({1}\\){1}\\.{1}", ".", "tBodyAcc-mean()-X")
## "fBodyAccMag.std" <- gsub("\\.{2}", "", "fBodyAccMag.std..")
names(data.wide) <- make.names(gsub("\\({1}\\){1}\\-{1}", ".", names(data.wide)))
names(data.wide) <- gsub("\\.{2}", "", names(data.wide))

## SUBMIT: Please upload the tidy data set created in step 5 of the instructions. 
## Please upload your data set as a txt file created with write.table() using row.name=FALSE
write.table(data.wide, file = "tidyData.txt", row.names = F)

data.loaded <- read.table("tidyData.txt", header = T)
View(data.loaded)
## APPENDIX : some helpful output

## > class(data)
## [1] "data.frame"
## > dim(data)  (with duplicate columns)
## [1] 10299   564
## > dim(data)
## [1] 10299   480

## > class(data.long)
## [1] "grouped_df" "tbl_df"     "tbl"        "data.frame"
## > dim(data.long)
## [1] 11880     4

## > class(data.wide)
## [1] "data.frame"
## > dim(data.wide)
## [1] 180  68

## LONG format

## > head(data.long)
## Source: local data frame [6 x 4]
## Groups: Subject, Activity
## 
## Subject Activity              feature        avg
## 1       1  WALKING    tBodyAcc-mean()-X  0.27733076
## 2       1  WALKING    tBodyAcc-mean()-Y -0.01738382
## 3       1  WALKING    tBodyAcc-mean()-Z -0.11114810
## 4       1  WALKING tGravityAcc-mean()-X  0.93522320
## 5       1  WALKING tGravityAcc-mean()-Y -0.28216502
## 6       1  WALKING tGravityAcc-mean()-Z -0.06810286
##
## > tail(data.long)
## Source: local data frame [6 x 4]
## Groups: Subject, Activity
## 
## Subject Activity                    feature       avg
## 1      24   LAYING          fBodyGyro-std()-Y -0.9577929
## 2      24   LAYING          fBodyGyro-std()-Z -0.9836027
## 3      24   LAYING          fBodyAccMag-std() -0.9710630
## 4      24   LAYING  fBodyBodyAccJerkMag-std() -0.9832851
## 5      24   LAYING     fBodyBodyGyroMag-std() -0.9613691
## 6      24   LAYING fBodyBodyGyroJerkMag-std() -0.9800970

## WIDE format (tidy column names)

## > head(data.wide[1:6])
## Subject           Activity tBodyAcc.mean.X tBodyAcc.mean.Y tBodyAcc.mean.Z tGravityAcc.mean.X
## 1       1            WALKING       0.2773308    -0.017383819      -0.1111481          0.9352232
## 2       1   WALKING_UPSTAIRS       0.2554617    -0.023953149      -0.0973020          0.8933511
## 3       1 WALKING_DOWNSTAIRS       0.2891883    -0.009918505      -0.1075662          0.9318744
## 4       1            SITTING       0.2612376    -0.001308288      -0.1045442          0.8315099
## 5       1           STANDING       0.2789176    -0.016137590      -0.1106018          0.9429520
## 6       1             LAYING       0.2215982    -0.040513953      -0.1132036         -0.2488818

## > head(data.wide[65:68])
## fBodyAccMag.std fBodyBodyAccJerkMag.std fBodyBodyGyroMag.std fBodyBodyGyroJerkMag.std
## 1      -0.3980326              -0.1034924           -0.3210180               -0.3816019
## 2      -0.4162601              -0.5330599           -0.1829855               -0.6939305
## 3      -0.1865303              -0.1040523           -0.3983504               -0.3919199
## 4      -0.9284448              -0.9816062           -0.9321984               -0.9870496
## 5      -0.9823138              -0.9925360           -0.9784661               -0.9946711
## 6      -0.7983009              -0.9218040           -0.8243194               -0.9326607
