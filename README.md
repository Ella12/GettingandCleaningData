Getting and Cleaning Data: Course Project
=========================================

Introduction
------------
This repository contains final  Coursera course "Getting and Cleaning data" project, part of the Data Science specialization.


The files in repository:

 - [run_analysis.R](run_analysis.R)
 
 - [CodeBook.md](CodeBook.md)
 
 - [REAME.md](REAME.md)
 
 - [data_set2.txt](data_set2.txt)
 
 
##run_analysis.R 
###Desription:
This script takes the raw data  as described in the Raw Data section below and performes the following:

1) Merges the training and the test sets to create one data set.

2) Extracts only the measurements on the mean and standard deviation for each measurement.

3) Uses descriptive activity names to name the activities in the data set

4) Appropriately labels the data set with descriptive variable names.

The output of this steps is a tidy dataset called data_set1.txt

5) Creates independent  second tidy data set  called data_set2.txt from previous data_set1.txt with the average of each variable for each activity and each subject. This file can be found in this repository.

Note: The scripts takes the [original dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
downloads it and then unzips it. As a result data.zip file and /UCI HAR Dataset/ are created in the working directory.


###Usage
 > source(run_analysis.R)

Raw data 
------------------
The full data set can be found in 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Also refer to CodeBook.md in this repository for more information about variables


The features (561 of them) are unlabeled and can be found in the x_test.txt. 
The activity labels are in the y_test.txt file.
The test subjects are in the subject_test.txt file.

The same holds for the training set.



About the Code Book
-------------------
The CodeBook.md file explains the transformations performed and the resulting data and variables.

