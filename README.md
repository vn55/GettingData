GettingData
===========

This repo contains information and code to complete the project for the Getting Data course by Jeff Leeks.

The project consists of acquiring data from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

This publicly available site contains data from the accelerometers from the Samsung Galaxy S smartphone.

Data consists of 10299 observations and 561 variables. The data is split between a training dataset with 7352 observations 
and a test dataset with 2947 observations. These variables represent several measurements taken for an individual
while doing an activity, for example walking or sitting. Further files contain information on a person ID to which each observation 
corresponds, and also an activity code.

The task is to create one R script called run_analysis.R that:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

For detailed code, please see the run_analysis.R file.

