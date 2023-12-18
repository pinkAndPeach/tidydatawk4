---
title: "CodeBook"
author: "Matthew"
date: "14 dec 2023"
output: html_document
---

---
The Data
---

  'mergeddata.txt': This merges data the test and train datasets and icluding the subject number, activity and the variables containing the mean() and std() measurements

  'meandata.txt': This contains the mean for all mean() and std() variables for each subject and activity.

---
The transformation to make the data
---

The run_analysis.R script generates the following files using the dataset 
Human Activity Recognition Using Smartphones Dataset Version 1.0

The following files are read in from the Human Activity Recognition Using Smartphones Dataset Version 1.0

- "activity_labels.txt" as activity_labels
- "features.txt" as features
- "subject_train.txt" as subject_train
- "y_train.txt" as y_train
- "X_train.txt" as x_train
- "subject_test.txt" as subject_test
- "y_test.txt" as y_test
- "X_test.txt" as x_test

- activity_labels gets the variable names "activitynumber", "activityname"
    activity_labels will be used to transform the activities so they are understandable.
- features gets the variable names "featurenumber", "featurename"
    features will be used to set the variable names for x_train and x_test so they are understandable.

- subject_train gets the variable name "subject"
- y_train gets the variable name "activity"
- x_train get variable names from features
    names(x_train) <- features[,"featurename"]

- subject_test gets the variable name "subject"
- y_test gets the variable name "activity"
- x_test get variable names from features
    names(x_test) <- features[,"featurename"]

The activity values are transformed so they are readable by taking the labels from activity_labels
    y_test <- mutate(y_test, activity = activity_labels[activity,"activityname"])
	  y_train <- mutate(y_train, activity = activity_labels[activity,"activityname"])

The test data sets are merged into a single data frame
    testdata <- cbind(subject_test, y_test, x_test)
    
The train data sets are merged into a single data frame
    traindata <- cbind(subject_train, y_train, x_train)

testdata and traindata into a single data frame
    mergeddata <- rbind(testdata,traindata)
    
The subject, activity, mean() variable and std() variables are selected and then the column names are sorted so subject is first, activity is second and the folowing columns are sorted alphabetically.
    meanandstddata <- mergeddata %>% select(subject,activity,contains("mean()") | contains("std()")) %>% select(subject,activity,order(colnames(.)))
    
meanandstddata is the data set that will be saved as "mergeddata.txt"

The subject and activity columns are grouped in that order. the other columns are summarised resulting in a data set with the mean value for each variable for every subject and activity.
    meandataset <- group_by(meanandstddata, subject, activity) %>% summarise_all(mean) %>% as.data.frame

meandataset is the data set that will be saved as "meandata.txt"


---
The variables in the data sets
---

I based many of the variable names on the features.txt as my understanding of the data set isn't strong enough the be able to improve on them.

Subject - The number of the subject performing the activity
Activity - The name of the activity performed
fBodyAcc-mean()-X
fBodyAcc-mean()-Y
fBodyAcc-mean()-Z
fBodyAcc-std()-X
fBodyAcc-std()-Y
fBodyAcc-std()-Z
fBodyAccJerk-mean()-X
fBodyAccJerk-mean()-Y
fBodyAccJerk-mean()-Z
fBodyAccJerk-std()-X
fBodyAccJerk-std()-Y
fBodyAccJerk-std()-Z
fBodyAccMag-mean()
fBodyAccMag-std()
fBodyAccJerkMag-mean()
fBodyAccJerkMag-std()
fBodyGyroJerkMag-mean() 
fBodyGyroJerkMag-std()
fBodyGyroMag-mean()
fBodyGyroMag-std()
fBodyGyro-mean()-X
fBodyGyro-mean()-Y
fBodyGyro-mean()-Z
fBodyGyro-std()-X
fBodyGyro-std()-Y
fBodyGyro-std()-Z
tBodyAcc-mean()-X
tBodyAcc-mean()-Y
tBodyAcc-mean()-Z
tBodyAcc-std()-X
tBodyAcc-std()-Y
tBodyAcc-std()-Z
tBodyAccJerk-mean()-X
tBodyAccJerk-mean()-Y
tBodyAccJerk-mean()-Z
tBodyAccJerk-std()-X
tBodyAccJerk-std()-Y
tBodyAccJerk-std()-Z
tBodyAccJerkMag-mean()
tBodyAccJerkMag-std()
tBodyAccMag-mean()
tBodyAccMag-std()
tBodyGyro-mean()-X
tBodyGyro-mean()-Y
tBodyGyro-mean()-Z
tBodyGyro-std()-X
tBodyGyro-std()-Y
tBodyGyro-std()-Z
tBodyGyroJerk-mean()-X
tBodyGyroJerk-mean()-Y
tBodyGyroJerk-mean()-Z
tBodyGyroJerk-std()-X
tBodyGyroJerk-std()-Y
tBodyGyroJerk-std()-Z
tBodyGyroJerkMag-mean()
tBodyGyroJerkMag-std()
tBodyGyroMag-mean()
tBodyGyroMag-std()
tGravityAcc-mean()-X
tGravityAcc-mean()-Y
tGravityAcc-mean()-Z
tGravityAcc-std()-X
tGravityAcc-std()-Y
tGravityAcc-std()-Z
tGravityAccMag-mean()
tGravityAccMag-std()
	
