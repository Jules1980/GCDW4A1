# Code Book for Getting and Cleaning Data Assigment
Julia Hamilton

## DESCRIPTION 
This code book explains the data and variables in TidyDataOut.txt

## DETAILS OF THE STUDY
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

## INFORMATION ON Input Data
Input data UCI HAR Dataset was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## INFORMATION ON ATTRIBUTES
Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
Triaxial Angular velocity from the gyroscope.
A 561-feature vector with time and frequency domain variables.
Its activity label.
An identifier of the subject who carried out the experiment.

## GOALS OF THE run_analysis.R SCRIPT:
1. Merge the training and the test sets to create one data set. 
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set 
4. Appropriately label the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##  1. Merging Training and Test Sets
Text Files Imported from downloaded zip file:

'features.txt'
'activity_labels.txt'
'subject_train.txt'
'x_train.txt'
'y_train.txt'
'subject_test.txt'
'x_test.txt'
'y_test.txt'

## 2. Retaining Mean and Standard Deviaiton Variables
Using grepl a keep vector was created to mark columns containing mean or standard deviation fields as TRUE. This was apploed to the full data set to retain only TRUE fields.

## 3. Rename Activities with Descriptive Names
'activity_labels.txt' was merged with the mean and standard deviation data to add descriptive labels for the activities.
Values in 'activity' column were then replaced with the matching values from the 'activityLabel' which makes the data easier to read

## 4. Label Dataset with Appropriate Description Names
gsub function was used to clean up the names. Activity column removed as it was no longer required.

## 5. Create an Independent Tidy Dataset with Means for each Activity and Subject
New table contains average for each variable for each activity and subject and it outputted.
