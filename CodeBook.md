# Code Book

This code book will describe the contents of the R script `run_analysis.R`, detail the variables created within and explain the processes executed within the R script in order to achieve the desired outcomes of the course project.  

### Downloading the Data and Reading it into R

Running `run_analysis.R` will download the zip file to a created folder within your working directory named `GandCD` and unzip the contents to a folder named `UCI HAR Dataset` in `GandCD`.  The individual data text files are then read into R and assigned to the following variables:

* `features` reads `features.txt` into a data frame with 561 rows and 2 columns.\
  This data frame contains the column names for the data in the `x_train` and `x_test` datasets.
* `activity_labels` reads `activity_labels.txt` into a data frame with 6 rows and 2 columns.\
  This table relates a numeric activity ID to a descriptive name of each activity.
* `subject_train` reads `subject_train.txt` into a data frame with 7352 rows and 1 column.\
  Contains the subject ID numbers for those in the train group.
* `subject_test` reads `subject_test.txt` into a data frame with 2947 rows and 1 column.\
  Contains the subject ID numbers for those in the test group.
* `y_train` reads `y_train.txt` into a data frame with 7352 rows and 1 column.\
  Contains the activity ID numbers for those in the train group.
* `y_test` reads `y_test.txt` into a data frame with 2947 rows and 1 column.\
  Contains the activity ID numbers for those in the test group.
* `x_train` reads `x_train.txt` into a data frame with 7352 rows and 561 columns.\
  Contains the measurements recorded for each feature for those subjects and activities in the train group.
* `x_test` reads `x_test.txt` into a data frame with 2947 rows and 561 column.\
  Contains the measurements recorded for each feature for those subjects and activities in the test group.


### 1. Merge the training and the test sets to create one data set.  
* `suball` combines the `subject_train` and the `subject_test` through `rbind()` producing a new data frame with 10299 rows and 1 column.
* `y_all` combines the `y_train` and the `y_test` through `rbind()` producing a new data frame with 10299 rows and 1 column.
* `x_all` combines the `x_train` and the `x_test` through `rbind()` producing a new data frame with 10299 rows and 561 columns.
* `merged_data` combines the three new data frames `suball`, `y_all` and `x_all` through `cbind()` producing a new data frame, containing all the data we need, with 10299 rows and 563 columns.
### 2. Extract only the measurements on the mean and standard deviation for each measurement. 
* `mu_and_sigma` is created when we subset `merged_data` by selecting the columns `subjectID`, `activityID` and any column containing `mean` or `std` as part of its measurement.  This new data frame has 10299 rows and 88 columns.
### 3. Use descriptive activity names to name the activities in the data set
* This is achieved by replacing the numeric values in the `activityID` column with the names of the activities that correspond to those activity ID numbers. (e.g., an activity ID of '1' corresponds to 'Walking' in the `activity_labels` dataset.)
### 4. Appropriately label the data set with descriptive variable names. 
The following changes are made on the data frame named `mu_and_sigma` created in the second step.
* All column names starting with `t` replace with `Time`.
* All column names starting with `f` replace with `Frequency`.
* All column names containing `Acc` replace with `Accelerometer`.
* All column names containing `Gyro` replace with `Gyroscope`.
* All column names containing `Mag` replace with `Magnitude`.
* All column names containing `BodyBody` replace with `Body`.
* All column names containing `-std()` replace with `STD`.
* All column names containing `mean()` replace with `Mean`.
* All column names containing `Freq()` replace with `Frequency`.
* All column names containing `mean` replace with `Mean`.
* All column names containing `angle` replace with `Angle`.
* All column names containing `gravity` replace with `Gravity`.
* All column names containing `tBody` replace with `TimeBody`.
* All column names containing `-` replace with `".."`.
* All column names containing `(` replace with `"."`.
* All column names containing `)` replace with `""`.
* All column names containing `,` replace with `"."`.
* Change column named `SubjectID` to `Subject..ID`.
* Change column named `ActivityID` to `Activity..Name`.


### 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
* The new tidy data set named `Tidy_means` is created using `group_by` on `mu_and_sigma` and grouping by `Subject..ID` and `Activity..Name` and then taking the means of each variable using `summarize_all(mean)`. `Tidy_means` contains 180 rows and 88 columns. 
* `Tidy_means` is then writen to a text file called `Tidy_Mean_Data.txt` a tab separated text document. 



