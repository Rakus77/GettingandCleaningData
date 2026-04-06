#install.packages("plyr")
#library(plyr)
install.packages("dplyr")
library(dplyr)

if(!file.exists("./GandCD")){dir.create("./GandCD")}

#  Download and unzip files needed.
furl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- file.path(getwd(), "./GandCD/Dataset.zip")
download.file(furl,f)
unzip(zipfile = "./GandCD/Dataset.zip", exdir = "./GandCD")

#  Read files into tables in R and rename columns.
features <- read.table("./GandCD/UCI HAR Dataset/features.txt")
activity_labels <- read.table("./GandCD/UCI HAR Dataset/activity_labels.txt")


colnames(features) <- c("measurementID", "measurement")
colnames(activity_labels) <- c("activityID", "activity")


x_train <- read.table("./GandCD/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./GandCD/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./GandCD/UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./GandCD/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./GandCD/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./GandCD/UCI HAR Dataset/test/subject_test.txt")


colnames(subject_train) <- "subjectID"
colnames(subject_test) <- "subjectID"
colnames(x_train) <- features$measurement
colnames(x_test) <- features$measurement
colnames(y_train) <- "activityID"
colnames(y_test) <- "activityID"


#1. Merges training and test data sets by subject, activity and measurements.
#   Then merges the subject, activity and measurement data sets into one data set.
xall <- rbind(x_test, x_train)
yall <- rbind(y_test, y_train)
suball <- rbind(subject_test, subject_train)
merged_data <- cbind(suball, yall, xall)

#2. Selecting from the data only measurements of means and standard deviations.

mu_and_sigma <- merged_data %>% select(subjectID, activityID, contains("mean"),contains("std"))

#3. Gives descriptive activity names that replace the numeric activity IDs.

mu_and_sigma$activityID <- activity_labels$activity[match(mu_and_sigma$activityID, activity_labels$activityID)] 

#4. Gives descriptive names to variables in data set

colnames(mu_and_sigma) <- gsub("^t","Time", colnames(mu_and_sigma))
colnames(mu_and_sigma) <- gsub("^f","Frequency", colnames(mu_and_sigma))
colnames(mu_and_sigma) <- gsub("Acc","Accelerometer", colnames(mu_and_sigma))
colnames(mu_and_sigma) <- gsub("Gyro","Gyroscope", colnames(mu_and_sigma))
colnames(mu_and_sigma) <- gsub("Mag","Magnitude", colnames(mu_and_sigma))
colnames(mu_and_sigma) <- gsub("BodyBody","Body", colnames(mu_and_sigma))
colnames(mu_and_sigma) <- gsub("-std()","STD", colnames(mu_and_sigma), ignore.case = TRUE, fixed = TRUE)
colnames(mu_and_sigma) <- gsub("-mean()","Mean", colnames(mu_and_sigma), ignore.case = TRUE, fixed = TRUE)
colnames(mu_and_sigma) <- gsub("Freq()","Frequency", colnames(mu_and_sigma), ignore.case = TRUE, fixed = TRUE)
colnames(mu_and_sigma) <- gsub("mean","Mean", colnames(mu_and_sigma))
colnames(mu_and_sigma) <- gsub("angle","Angle", colnames(mu_and_sigma))
colnames(mu_and_sigma) <- gsub("gravity","Gravity", colnames(mu_and_sigma))
colnames(mu_and_sigma) <- gsub("tBody","TimeBody", colnames(mu_and_sigma))
colnames(mu_and_sigma) <- gsub("-","..", colnames(mu_and_sigma))
colnames(mu_and_sigma)[2] <- "Activity..Name"
colnames(mu_and_sigma)[1] <- "Subject..ID"
colnames(mu_and_sigma) <- gsub("[(]",".", colnames(mu_and_sigma))
colnames(mu_and_sigma) <- gsub("[)]","", colnames(mu_and_sigma))
colnames(mu_and_sigma) <- gsub(",",".", colnames(mu_and_sigma))

#5. From Step 4. Creates second, independent tidy data set with the average of each variable
#   for each activity and each subject.  Writes data set to text file for submission.

Tidy_means <- mu_and_sigma %>%
        group_by(Subject..ID,Activity..Name) %>%
        summarize_all(mean)
write.table(Tidy_means, "Tidy_Mean_Data.txt", sep = "\t" ,row.names = FALSE)












