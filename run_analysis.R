# loading required libraries 
library(tidyr)

#reading the file into R 

file_name<-"getdata_projectfiles_UCI HAR Dataset.zip"

# unzipping file
unzip(zipfile = file_name)

# 1.Merging the data sets
# Reading in the training data sets 

setwd("C:/Users/Lenovo/Documents/R_datasets_practise/Coursera/UCI HAR Dataset/train")

subject_train<-read.table("subject_train.txt")
x_train <- read.table("X_train.txt")
y_train<-read.table("y_train.txt")
# Reading in the test data sets 

setwd("C:/Users/Lenovo/Documents/R_datasets_practise/Coursera/UCI HAR Dataset/test")

subject_test<-read.table("subject_test.txt")
x_test <-read.table("X_test.txt")
y_test<-read.table("y_test.txt")

# reading feature and activity labels
setwd("C:/Users/Lenovo/Documents/R_datasets_practise/Coursera/UCI HAR Dataset")

activity_labels<-read.table("activity_labels.txt")
features<-read.table("features.txt")

colnames(activity_labels) <- c("activityID", "activityType")

#assigning variable names 

colnames(x_train) <- features[, 2]
colnames(y_train) <- "activityID"
colnames(subject_train) <- "subjectID"

colnames(x_test) <- features[, 2]
colnames(y_test) <- "activityID"
colnames(subject_test) <- "subjectID"
#merging all data sets into one combine data set 

completetrain<-cbind(y_train, subject_train,x_train)
completetest<-cbind(y_test, subject_test,x_test)

finalDT<- rbind(completetrain,completetest)

#  (2)Extracting only the measurements on the mean and std for each measurement
mean_and_std <- grepl("activityID|subjectID|mean\\(\\)|std\\(\\)", colnames(finalDT))
setforMeanandStd <- finalDT[, mean_and_std]

# (3)Use  descriptive activity names to name the activities in the data set

DTwithActivityNames <- merge(setforMeanandStd, activity_labels, by = "activityID", all.x = TRUE)

#(4) Label the data set with descriptive variable names

colnames(DTwithActivityNames) <- gsub("^t", "time", colnames(DTwithActivityNames))
colnames(DTwithActivityNames) <- gsub("^f", "frequency", colnames(DTwithActivityNames))
colnames(DTwithActivityNames) <- gsub("Acc", "Accelerometer", colnames(DTwithActivityNames))
colnames(DTwithActivityNames) <- gsub("Gyro", "Gyroscope", colnames(DTwithActivityNames))
colnames(DTwithActivityNames) <- gsub("Mag", "Magnitude", colnames(DTwithActivityNames))
colnames(DTwithActivityNames) <- gsub("BodyBody", "Body", colnames(DTwithActivityNames))


# creating a new tidy data set with the avg of each variable for each activity and subkect 

tidyset<- DTwithActivityNames %>%
  group_by(subjectID,activityID, activityType)%>%
  summarise_all(mean)

write.table(tidyset, "tidyset.txt", row.names = FALSE)

##
