##Download the data and unzip it.
dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url, "CleaningDataProgAssignment.zip")
unzip("CleaningDataProgAssignment.zip", exdir = "CleaningDataProgAssignment")