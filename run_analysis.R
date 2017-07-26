
# Downloading and unzipping dataset
setwd("C:\\Users\\ameer.mursyidin\\Desktop\\Coursera\\R Training\\Chapter 3\\Week 4\\Assignment")

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

unzip(zipfile="./data/Dataset.zip",exdir="./data")


# Read in the data from files
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

features <- read.table("./data/UCI HAR Dataset/features.txt")

activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

# Assign column names to the data imported above
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

# Merging all data in one set
merge_train <- cbind(y_train, subject_train, x_train)
merge_test <- cbind(y_test, subject_test, x_test)
merge_all <- rbind(merge_train, merge_test)


# Create a vector for the column names from the finalData
# Which will be used to select the desired mean() & stddev() columns
colNames <- colnames(merge_all)

mean_stddev <-    (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames))

# Making nessesary subset from merge_all
setForMeanAndStdDev <- merge_all[ , mean_stddev == TRUE]

# Merging the tidyData with activityType to include descriptive acitvity names
setActivityNames <- merge(setForMeanAndStdDev, activityLabels,
                              by='activityId',
                              all.x=TRUE)

# Making second tidy data set
secTidySet <- aggregate(. ~subjectId + activityId, setActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

# Export the tidyData set 
write.table(secTidySet, "./secTidydata.txt", row.name=FALSE)






