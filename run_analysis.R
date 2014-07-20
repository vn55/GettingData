
## GET data collected from the accelerometers from the Samsung Galaxy S smartphone.

fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "accel.zip")

library(data.table)

### READING FILES ####

features <- read.table(".//UCI HAR Dataset//features.txt", sep=" ",header=FALSE)

train <- read.table(".//UCI HAR Dataset//train//X_train.txt", sep="",header=FALSE)

test <- read.table(".//UCI HAR Dataset//test//X_test.txt", sep="",header=FALSE)

subjecttrain <- read.table(".//UCI HAR Dataset//train//subject_train.txt", sep="",header=FALSE)

subjecttest <- read.table(".//UCI HAR Dataset//test//subject_test.txt", sep="",header=FALSE)

labelstrain <- read.table(".//UCI HAR Dataset//train//y_train.txt", sep="",header=FALSE)

labelstest <- read.table(".//UCI HAR Dataset//test//y_test.txt", sep="",header=FALSE)

labels <- read.table(".//UCI HAR Dataset//activity_labels.txt", sep="",header=FALSE)
names(labels) <- c("ActivityCode","ActivityLabel")

### INCLUDE ACTIVITY NAMES IN THE TRAIN AND TEST DATASETS 

labelstrain <- merge(labelstrain,labels,by.x="V1",by.y="ActivityCode",all=TRUE)
labelstest <- merge(labelstest,labels,by.x="V1",by.y="ActivityCode",all=TRUE)


### MERGING TRAIN AND TEST ###

traincomplete <- cbind(subjecttrain,labelstrain,train)
testcomplete <- cbind(subjecttest,labelstest,test)

data <- rbind(traincomplete,testcomplete)

### CORRECTLY NAME THE VARIABLES ###

allLabels <-  c("Subject","ActivityCode","ActivityLabel",paste(features$V2))

names(data) <- allLabels 

### SELECT COLUMNS WITH MEAN AND SD ON NAME, 
### WHILE KEEPING SUBJECT AND ACTIVITY
### IN THE OUTPUT 

finaldata <- data[,grep("Subject|ActivityLabel|mean|std",names(data))]

### CREATING FILE TO SUBMIT###

library(plyr)

subm <- ddply(finaldata,.(Subject,ActivityLabel),numcolwise(mean))

write.table(subm,"submissionfile.txt")


