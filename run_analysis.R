#Julia Hamilton
#Getting and Cleaning Data Week 4 Assignment


library(dplyr)


#set working directory to read in training data
setwd("~/Coursera/Getting and Cleaning Data/Week 4/Assignment/UCI HAR Dataset")

#read in all the data and name the columns ready for working
features <- read.table('./features.txt',header=FALSE)

activityLabels <- read.table('./activity_labels.txt',header=FALSE)
    colnames(activityLabels) <- c("activity","activitylabel")

  #training data folder
  subjectTrain <- read.table('./train/subject_train.txt',header=FALSE) 
     colnames(subjectTrain) <- "subject"
  xTrain <- read.table('./train/x_train.txt',header=FALSE) 
     colnames(xTrain) <- features[,2]
  yTrain <- read.table('./train/y_train.txt',header=FALSE)
     colnames(yTrain) <- "activity"

  #test data folder
  subjectTest <- read.table('./test/subject_test.txt',header=FALSE) 
      colnames(subjectTest) <- "subject"
  xTest <- read.table('./test/x_test.txt',header=FALSE) 
      colnames(xTest) <- features[,2]
  yTest <- read.table('./test/y_test.txt',header=FALSE)
      colnames(yTest) <- "activity"

# Part 1: Merging Training and Test Sets
Train <- cbind(xTrain, yTrain, subjectTrain)
Test <- cbind(xTest, yTest, subjectTest)

AllData = rbind(Train,Test)


# Part 2: Retaining Mean and Standard Deviaiton Variables
columns <- colnames(AllData)

keep_vector <- ( grepl("activ..",columns) | grepl("sub..",columns) 
              | grepl("-mean..",columns) & !grepl("-meanFreq..",columns) & 
                              !grepl("mean..-",columns) | 
                grepl("-std..",columns) & !grepl("-std()..-",columns) )

AllData <- AllData[keep_vector==TRUE]

# Part 3: Rename Activities with descriptive names

AllData <- merge(AllData,activityLabels,by="activity",all.x=TRUE)

AllData$activity <- activityLabels[,2][match(AllData$activity, activityLabels[,1])]

columns <- colnames(AllData)

# Part 4: Label Data set with appropriate description names

# Tidy column names
for (i in 1:length(columns)) 
{
  columns[i] <- gsub("\\()","",columns[i])
  columns[i] <- gsub("-std$","StdDev",columns[i])
  columns[i] <- gsub("-mean","Mean",columns[i])
  columns[i] <- gsub("^(t)","time",columns[i])
  columns[i] <- gsub("^(f)","freq",columns[i])
  columns[i] <- gsub("([Gg]ravity)","Gravity",columns[i])
  columns[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",columns[i])
  columns[i] <- gsub("[Gg]yro","Gyro",columns[i])
  columns[i] <- gsub("AccMag","AccMagnitude",columns[i])
  columns[i] <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",columns[i])
  columns[i] <- gsub("JerkMag","JerkMagnitude",columns[i])
  columns[i] <- gsub("GyroMag","GyroMagnitude",columns[i])
}

# Update AllData with new descriptive column names
colnames(AllData) <- columns

# Remove activitylabel
AllData <- AllData[,names(AllData) != 'activitylabel']

# Part 5: Create an independent tidy data set with means for each activity and subject

# Average each activity
tidyData <- aggregate(AllData[,names(AllData) != c('activity', 'subject')], by=list 
                      (subject = AllData$subject, activity = AllData$activity), mean)

# Export
write.table(tidyData, './TidyDataOut.txt',row.names=FALSE,sep='\t')





