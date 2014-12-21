Getting and Cleaning Data Course Project - CodeBook
===================================================
This file describes the variables, the data, and any transformations or work performed to clean up the data.

The raw dataset ZIP file for the project:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

The raw data consists of training & test data, with files for subjects, features, and activity labels.

Slide 1: The Best Way to Show the Raw Data file structure.
![plot of Slide2](Slide2.png)

# run_analysis.R

Activity labels read from "activity_labels.txt"
Features read from "features.txt"

Training Data:
 -values read from "train/X_train.txt"
 -activities read from "train/y_train.txt"
 -subjects read from "train/subject_train.txt"
 -data frame created by cbind(values, subjects, activities)

Test Data:
 -values read from "test/X_test.txt"
 -activities read from "test/y_test.txt"
 -subjects read from "test/subject_test.txt"
 -data frame created by cbind(values, subjects, activities)

Combined Data:
 -maintain the partitioning by training and test data, for later analysis/graphing purposes.
 -bind the two data frames into one single data fram by rbind(data.train, data.test)
 -save the data frame to "uciHarDataset.rda" for faster import on opening project
 -dim(data) = 10299 obs x 564 variables
 
Measurements:
 -the interpretation of the directions resulted in selecting only those values with both a mean() and a std() value present in the data. it is assumed this to be a "measurement" whether directly measured as a signal, or derived as such.
 -any duplicate columns of data were removed. dim(data) = 10299 obs x 480 variables
 -selecting only the measurements desired, select()/gather()/group_by()/summarize(mean(value)) was used to derive a LONG data format taking the mean (AVERAGE) of the mean()- and std()- values.
 -dcast() was used to then create a WIDE data.frame resulting in 180 obs x 68 variables.
 -the column names were "cleaned" up to be tidy compliant. the distinction of "mean" or "std" was maintained for clarity with the original data file features.
 
Tidy Data Output:
 -the tidy dataset was exported to .txt file as directed via write.table with row.names = F.
 
Column Names:
 
```{r, echo=FALSE}
data.loaded <- read.table("tidyData.txt", header = T)
names(data.loaded)
```
