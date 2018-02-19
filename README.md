# SamsungAccelerometerData
This repo contains the required files for the final project in the Getting and Cleaning Data Coursera course.

INFORMATION ON THE SUMMARY DATA CHOICES MADE
You can use the file DownloadData.R to download the required zipped files to your computer and to unzip them. Once you have the data on your computer, you will need the following 7 files in your working directory:
features.txt
subject_test.txt
subject_train.txt
X_test.txt
X_train.txt
y_test.txt
y_train.txt

The run_analysis.R script takes the above 7 data sets and merges them so that each row is labelled with the subject and activity. In addition, the columns are given variable names, which have been made all lower case and have had “_” and “()” removed. This makes the column names fit into a tidy data set as these were the parameters given in the course for variable names in tidy data sets (all lower case, no _, no spaces). The variable names are understandable to anyone familiar with the study. 
 
The original data set is subset to only contain data on mean and standard deviation as described in the assignment. In this case, any variable name that contained “mean” or “std” anywhere in the given variable name was included, since the assignment directions did not specify further. In this case, if some of these variables are not needed, it would be easy to remove them.

The script also takes the refined data set and creates a second, independent tidy data set with the average of each variable for each activity and each subject. In this case, the newly created data set is a long data set where there is only one column, which is a mean, and each row represents a subject, activity, and one of the variables, as marked.

The final data set for parts 1-4 of the assignment will be written to a file called DescData.txt. The final data set for part 5 of the assignment (the second, independent tidy data set with the average of each variable for each activity and each subject) will be written to a file called tidy.txt.
