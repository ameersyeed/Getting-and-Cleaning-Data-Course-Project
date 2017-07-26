# Introduction

The script run_analysis.R performs the 5 steps described in the course project's definition.

- All the data is merged using the cbind() and rbind() function to create one data set.

- Only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from features.txt.

- Using descriptive activity names to name the activities in the data set.

- On the whole dataset, those columns with vague column names are corrected.

- New dataset is generated with all the average measures for each subject and activity type.

# Variables

-> x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.

-> x_data, y_data and subject_data merge the previous datasets to further analysis.

-> features contains the correct names for the x_data dataset, which are applied to the column names stored in mean_and_std_features, a numeric vector used to extract the desired data.

-> A similar approach is taken with activity names through the activities variable.
all_data merges x_data, y_data and subject_data in a big dataset.

-> Finally, averages_data contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is used to apply colMeans() and ease the development.
