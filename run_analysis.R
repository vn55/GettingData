
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

# -- to keep the original order, save order in a new auxiliary variable

labelstrain$id  <- 1:nrow(labelstrain)
labelstest$id  <- 1:nrow(labelstest)

labelstrain <- merge(labelstrain,labels,by.x="V1",by.y="ActivityCode",all=TRUE)
labelstest <- merge(labelstest,labels,by.x="V1",by.y="ActivityCode",all=TRUE)

# -- ordering as original

labelstrain <- labelstrain[order(labelstrain$id), ]
labelstest <- labelstest[order(labelstest$id), ]

# -- delete auxiliary variable as no longer needed
labelstrain$id = NULL
labelstest$id = NULL

### MERGING TRAIN AND TEST ###

traincomplete <- cbind(subjecttrain,labelstrain,train)
testcomplete <- cbind(subjecttest,labelstest,test)

data <- rbind(traincomplete,testcomplete)

### CORRECTLY NAME THE VARIABLES (are previously labeled V1, V2, V3, etc) ###

allLabels <-  c("Subject","ActivityCode","ActivityLabel",paste(features$V2))

names(data) <- allLabels 

### SELECT COLUMNS WITH MEAN AND SD ANYWHERE ON NAME, 
### WHILE KEEPING SUBJECT AND ACTIVITY
### IN THE OUTPUT 

finaldata <- data[,grep("Subject|ActivityLabel|mean|std",names(data))]

### CREATING FILE TO SUBMIT###

library(plyr)

#- creating descriptive variable names -#
varnames <- c("Subject","ActivityLabel",
"meanTimeOfBodyAccelerationSignalfromAccelerometerIntheXdirection",
"meanTimeOfBodyAccelerationSignalfromAccelerometerIntheYdirection",
"meanTimeOfBodyAccelerationSignalfromAccelerometerIntheZdirection",
"stdTimeOfBodyAccelerationSignalfromAccelerometerIntheXdirection",
"stdTimeOfBodyAccelerationSignalfromAccelerometerIntheYdirection",
"stdTimeOfBodyAccelerationSignalfromAccelerometerIntheZdirection",
"meanTimeOfGravityAccelerationSignalfromAccelerometerIntheXdirection",
"meanTimeOfGravityAccelerationSignalfromAccelerometerIntheYdirection",
"meanTimeOfGravityAccelerationSignalfromAccelerometerIntheZdirection",
"stdTimeOfGravityAccelerationSignalfromAccelerometerIntheXdirection",
"stdTimeOfGravityAccelerationSignalfromAccelerometerIntheYdirection",
"stdTimeOfGravityAccelerationSignalfromAccelerometerIntheZdirection",
"meanTimeOfBodyJerkAccelerationSignalfromAccelerometerIntheXdirection",
"meanTimeOfBodyJerkAccelerationSignalfromAccelerometerIntheYdirection",
"meanTimeOfBodyJerkAccelerationSignalfromAccelerometerIntheZdirection",
"stdTimeOfBodyJerkAccelerationSignalfromAccelerometerIntheXdirection",
"stdTimeOfBodyJerkAccelerationSignalfromAccelerometerIntheYdirection",
"stdTimeOfBodyJerkAccelerationSignalfromAccelerometerIntheZdirection",
"meanTimeOfBodyAccelerationSignalfromGyroscopeIntheXdirection",
"meanTimeOfBodyAccelerationSignalfromGyroscopeIntheYdirection",
"meanTimeOfBodyAccelerationSignalfromGyroscopeIntheZdirection",
"stdTimeOfBodyAccelerationSignalfromGyroscopeIntheXdirection",
"stdTimeOfBodyAccelerationSignalfromGyroscopeIntheYdirection",
"stdTimeOfBodyAccelerationSignalfromGyroscopeIntheZdirection",
"meanTimeOfBodyJerkAccelerationSignalfromGyroscopeIntheXdirection",
"meanTimeOfBodyJerkAccelerationSignalfromGyroscopeIntheYdirection",
"meanTimeOfBodyJerkAccelerationSignalfromGyroscopeIntheZdirection",
"stdTimeOfBodyJerkAccelerationSignalfromGyroscopeIntheXdirection",
"stdTimeOfBodyJerkAccelerationSignalfromGyroscopeIntheYdirection",
"stdTimeOfBodyJerkAccelerationSignalfromGyroscopeIntheZdirection",
"meanTimeOfBodyMagnitudeAccelerationSignalfromAccelerometer",
"stdTimeOfBodyMagnitudeAccelerationSignalfromAccelerometer",
"meanTimeOfGravityMagnitudeAccelerationSignalfromAccelerometer",
"stdTimeOfGravityMagnitudeAccelerationSignalfromAccelerometer",
"meanTimeOfBodyJerkMagnitudeAccelerationSignalfromAccelerometer",
"stdTimeOfBodyJerkMagnitudeAccelerationSignalfromAccelerometer",
"meanTimeOfBodyMagnitudeAccelerationSignalfromGyroscope",
"stdTimeOfBodyMagnitudeAccelerationSignalfromGyroscope",
"meanTimeOfBodyJerkMagnitudeAccelerationSignalfromGyroscope",
"stdTimeOfBodyJerkMagnitudeAccelerationSignalfromGyroscope",
"meanFrequencyOfBodyAccelerationSignalfromAccelerometerIntheXdirection",
"meanFrequencyOfBodyAccelerationSignalfromAccelerometerIntheYdirection",
"meanFrequencyOfBodyAccelerationSignalfromAccelerometerIntheZdirection",
"stdFrequencyOfBodyAccelerationSignalfromAccelerometerIntheXdirection",
"stdFrequencyOfBodyAccelerationSignalfromAccelerometerIntheYdirection",
"stdFrequencyOfBodyAccelerationSignalfromAccelerometerIntheZdirection",
"weightedAverageOfFrequencyComponentsOfBodyAccelerationSignalfromAccelerometerIntheXdirection",
"weightedAverageOfFrequencyComponentsOfBodyAccelerationSignalfromAccelerometerIntheYdirection",
"weightedAverageOfFrequencyComponentsOfBodyAccelerationSignalfromAccelerometerIntheZdirection",
"meanFrequencyOfBodyJerkAccelerationSignalfromAccelerometerIntheXdirection",
"meanFrequencyOfBodyJerkAccelerationSignalfromAccelerometerIntheYdirection",
"meanFrequencyOfBodyJerkAccelerationSignalfromAccelerometerIntheZdirection",
"stdFrequencyOfBodyJerkAccelerationSignalfromAccelerometerIntheXdirection",
"stdFrequencyOfBodyJerkAccelerationSignalfromAccelerometerIntheYdirection",
"stdFrequencyOfBodyJerkAccelerationSignalfromAccelerometerIntheZdirection",
"weightedAverageOfFrequencyComponentsOfBodyJerkAccelerationSignalfromAccelerometerIntheXdirection",
"weightedAverageOfFrequencyComponentsOfBodyJerkAccelerationSignalfromAccelerometerIntheYdirection",
"weightedAverageOfFrequencyComponentsOfBodyJerkAccelerationSignalfromAccelerometerIntheZdirection",
"meanFrequencyOfBodyAccelerationSignalfromGyroscopeIntheXdirection",
"meanFrequencyOfBodyAccelerationSignalfromGyroscopeIntheYdirection",
"meanFrequencyOfBodyAccelerationSignalfromGyroscopeIntheZdirection",
"stdFrequencyOfBodyAccelerationSignalfromGyroscopeIntheXdirection",
"stdFrequencyOfBodyAccelerationSignalfromGyroscopeIntheYdirection",
"stdFrequencyOfBodyAccelerationSignalfromGyroscopeIntheZdirection",
"weightedAverageOfFrequencyComponentsOfBodyAccelerationSignalfromGyroscopeIntheXdirection",
"weightedAverageOfFrequencyComponentsOfBodyAccelerationSignalfromGyroscopeIntheYdirection",
"weightedAverageOfFrequencyComponentsOfBodyAccelerationSignalfromGyroscopeIntheZdirection",
"meanFrequencyOfBodyMagnitudeAccelerationSignalfromAccelerometer",
"stdFrequencyOfBodyMagnitudeAccelerationSignalfromAccelerometer",
"weightedAverageOfFrequencyComponentsOfBodyMagnitudeAccelerationSignalfromAccelerometer",
"meanFrequencyOfBodyJerkMagnitudeAccelerationSignalfromAccelerometer",
"stdFrequencyOfBodyJerkMagnitudeAccelerationSignalfromAccelerometer",
"weightedAverageOfFrequencyComponentsOfBodyJerkMagnitudeAccelerationSignalfromAccelerometer",
"meanFrequencyOfBodyMagnitudeAccelerationSignalfromGyroscope",
"stdFrequencyOfBodyMagnitudeAccelerationSignalfromGyroscope",
"weightedAverageOfFrequencyComponentsOfBodyMagnitudeAccelerationSignalfromGyroscope",
"meanFrequencyOfBodyJerkMagnitudeAccelerationSignalfromGyroscope",
"stdFrequencyOfBodyJerkMagnitudeAccelerationSignalfromGyroscope",
"weightedAverageOfFrequencyComponentsOfBodyJerkMagnitudeAccelerationSignalfromGyroscope")

names(finaldata) <- varnames

### CREATING a second, independent tidy data set with the average of each variable 
### for each activity and each subject. 

subm <- ddply(finaldata,.(Subject,ActivityLabel),numcolwise(mean))

### SAVING SUBMISSION FILE

write.table(subm,"submissionfile.txt")


