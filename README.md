# GettingCleaningDataCourseProject

Before running the `run_analysis.R` script, please:

1. Download the dataset from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The script does the following:

Sets the source directory for the files and reads the following files into tables
- features.txt
- X_test.txt
- Y_test.txt
- X_train.txt
- y_train.txt
- activity_labels.txt
- subject_test.txt
- subject_train.txt

Adds subject ids and merges the train and test data sets

Renames coumns using the "activity_labels" file.  Substitutes full English words for short forms (I.e. Acceleration for Acc)

Renames activity from id to proper English name.

Subsetts data frame to just mean and standard deviation columns

Creates a seperate data frame of averages

Writes the result to `tidy.txt`.