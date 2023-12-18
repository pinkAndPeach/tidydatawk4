##Week 4 - Getting and cleaning data

##To Do - clean out the BodyBody duplication in the feature names	

##import dplyr library
library(dplyr)

##Read in data
	
	##Activity labels
	activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

	##Features which details the variables
	features <- read.table("UCI HAR Dataset/features.txt")

	##Train Data
	subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
	y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
	x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
	
	##Test Data
	subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
	y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
	x_test <- read.table("UCI HAR Dataset/test/X_test.txt")

##Renaming the variables

	##rename activity_labels variables
	names(activity_labels) <- c("activitynumber", "activityname")

	##rename features variables
	names(features) <- c("featurenumber", "featurename")

	##rename subject_train data variables
	names(subject_train) <- "subject"

	##rename y_train data variables
	names(y_train) <- "activity"
	
	##rename x_train data variables. 
	##get variable label from features
	names(x_train) <- features[,"featurename"] ##Get variable label from features

	##rename subject_test data variables
	names(subject_test) <- "subject"

	##rename y_test data variables
	names(y_test) <- "activity"

	##rename x_test data variables. 
	##get variable label from features
	names(x_test) <- features[,"featurename"] ##Get variable label from features


##Mutate activity values to be readable in y_train and y_test

	y_test <- mutate(y_test, activity = activity_labels[activity,"activityname"])
	y_train <- mutate(y_train, activity = activity_labels[activity,"activityname"])

##Joining the datasets
	
	##cbind the test data sets
	testdata <- cbind(subject_test, y_test, x_test)
	##cbind the train data sets
	traindata <- cbind(subject_train, y_train, x_train)
	##rbind testdata and traindata into a single data frame
	mergeddata <- rbind(testdata,traindata)

## selecting the variables with the needed data subject, activity, mean(), std(). Sort the variables starting with subject and activity with all other variables being alphabetical

	 meanandstddata <- mergeddata %>% select(subject,activity,contains("mean()") | contains("std()")) %>% select(subject,activity,order(colnames(.)))

## making the mean data set
	
	## Group the data subject and activity
	## Summarise all the columns returning the means for the groups
	## Convert the tibble to a data frame 
	meandataset <- group_by(meanandstddata, subject, activity) %>% summarise_all(mean) %>% as.data.frame

## Save the data sets
	
	##saving the merged test and training data sets. Only includes subject, activity, mean & std variables
	write.table(meanandstddata,file = "mergeddata.txt")
	##saving the dataset of means per subject and activity.
	write.table(meandataset,file = "meandata.txt")

	