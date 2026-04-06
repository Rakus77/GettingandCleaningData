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
