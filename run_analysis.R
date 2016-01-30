##################
#
# Getting and Claning Data - Project 2
#
##################
library(plyr)

setwd("~/R Files/GetCleanData/GettingCleaningDataCourseProject")

# read the required files
labels_df <- read.table("./UCI HAR Dataset/features.txt")
test_df <- read.table("./UCI HAR Dataset/test/X_test.txt")
activity_num_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
train_df <- read.table("./UCI HAR Dataset/train/X_train.txt")
activity_num_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
activity_df <- read.table("./UCI HAR Dataset/activity_labels.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# add subject ids to each dataframe
full_train <- cbind(train_df, subject_train)
full_test <- cbind(test_df, subject_test)

# merge the datasets
total_df <- rbind(full_train, full_test)

# rename the columns to proper variable names
labels <- as.character(labels_df$V2)
for(c in 0:length(total_df)) {
  names(total_df)[c] <- labels[c]
}
# add 'Subject' column name
names(total_df)[562] <- "Subject"
# rename to English
names(total_df) <- gsub('Acc',"Acceleration",names(total_df))
names(total_df) <- gsub('GyroJerk',"AngularAcceleration",names(total_df))
names(total_df) <- gsub('Gyro',"AngularSpeed",names(total_df))
names(total_df) <- gsub('Mag',"Magnitude",names(total_df))
names(total_df) <- gsub('^t',"Time-",names(total_df))
names(total_df) <- gsub('^f',"Frequency-",names(total_df))

# resolve the activity numbers to values
vals <- activity_df$V2 # activity labels as a factor
activities <- character() # empty vector

# loop data frame and create vector of activity labels that correspond to numbers
for(ct in 0:nrow(total_df)) {
  val <- levels(vals)[activity_num_test$V1[ct]]
  activities <- c(activities, val)
}

# append the activity values to data set
total_df$Activity <- activities

# grab all of the mean and std columns
final_df <- total_df[, grep("*-mean()*|*-std()*|Activity|Subject", colnames(total_df))]

# create seperate dataframe that contains averages
sensor_avg = ddply(final_df, c("Subject","Activity"), numcolwise(mean))
write.table(sensor_avg, file = "tidy.txt")