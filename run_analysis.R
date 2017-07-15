# This function downloads & unzip the data into the below folder 
# D:\Learning\Coursera\Data_Scientist\Assignments\Month3_Week4\Project

downloadfile = function() {
    if (!file.exists("D:\\Learning\\Coursera\\Data_Scientist\\Assignments\\Month3_Week4\\Project\\FUCI HAR Dataset")) {
        # download the data
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        zipfile="FUCI_HAR_data.zip"
        message("Downloading data")
        download.file(fileURL, destfile=zipfile)
        unzip(zipfile, exdir="D:\\Learning\\Coursera\\Data_Scientist\\Assignments\\Month3_Week4\\Project\\FUCI HAR Dataset")
	}
    else {	
	message("File Already exists, No Need to download")
	}
   
}

# This function merges train & test data sets
mergeTrain_Test_DS <- function (){

    # Read data
    message("reading X_train.txt")
    training.x <- read.table("UCI HAR Dataset\\train\\X_train.txt")
    message("reading y_train.txt")
    training.y <- read.table("UCI HAR Dataset\\train\\y_train.txt")
    message("reading subject_train.txt")
    training.subject <- read.table("UCI HAR Dataset\\train\\subject_train.txt")
    message("reading X_test.txt")
    test.x <- read.table("UCI HAR Dataset\\test\\X_test.txt")
    message("reading y_test.txt")
    test.y <- read.table("UCI HAR Dataset\\test\\y_test.txt")
    message("reading subject_test.txt")
    test.subject <- read.table("UCI HAR Dataset\\test\\subject_test.txt")
    # Merge
    merged.x <- rbind(training.x, test.x)
    merged.y <- rbind(training.y, test.y)
    merged.subject <- rbind(training.subject, test.subject)
    # merge train and test datasets and return
    list(x=merged.x, y=merged.y, subject=merged.subject)
}

extract.mean.and.std = function(df) {
    # Given the dataset (x values), extract only the measurements on the mean
    # and standard deviation for each measurement.

    # Read the feature list file
    features <- read.table("UCI HAR Dataset//features.txt")
    # Find the mean and std columns
    mean.col <- sapply(features[,2], function(x) grepl("mean()", x, fixed=T))
    std.col <- sapply(features[,2], function(x) grepl("std()", x, fixed=T))
    ## Below data set needs to be passed as parameter to this function	
    ## df <- read.table("UCI HAR Dataset\\train\\X_train.txt")
    # Extract them from the data
    edf <- df[, (mean.col | std.col)]
    colnames(edf) <- features[(mean.col | std.col), 2]
    edf
}

# This function names the activities in the data set of y_train OR y-test
# Input parameter to this function is a data set either y_train or y_test
name.activities = function(df) {
    # Use descriptive activity names to name the activities in the dataset
    colnames(df) <- "activity"
    df$activity[df$activity == 1] = "WALKING"
    df$activity[df$activity == 2] = "WALKING_UPSTAIRS"
    df$activity[df$activity == 3] = "WALKING_DOWNSTAIRS"
    df$activity[df$activity == 4] = "SITTING"
    df$activity[df$activity == 5] = "STANDING"
    df$activity[df$activity == 6] = "LAYING"
    df
}


# This function binds the data sets X_test & Y_test & Subject or 
# X_train & Y_train & Subject
# and these 3 data sets needs to be passed as input parameters to this function.

bind.data <- function(x, y, subjects) {
    # Combine mean-std values (x), activities (y) and subjects into one data
    # frame.
    cbind(x, y, subjects)
}



create.tidy.dataset = function(df) {
    # Given X values, y values and subjects, create an independent tidy dataset
    # with the average of each variable for each activity and each subject.
    tidy <- ddply(df, .(subject, activity), function(x) colMeans(x[,1:60]))
    tidy
}



# This is the main function which takes care of cleaning of data and generates Tidy Data

clean.data = function() {

# This command sets the working directory to the privious working directory to the current folder
setwd("D:\\Learning\\Coursera\\Data_Scientist\\Assignments\\Month3_Week4\\Project\\FUCI HAR Dataset")

    # Download data
    message("Going to Call downloadfile")
    downloadfile()
    # merge training and test datasets. merge.datasets function returns a list
    # of three dataframes: X, y, and subject
    message("Going to Call mergeTrain_Test_DS")
    merged <- mergeTrain_Test_DS()
    # Extract only the measurements of the mean and standard deviation for each
    # measurement
    message("Going to Call extract.mean.and.std")
    cx <- extract.mean.and.std(merged$x)
    # Name activities
    message("Going to Call name.activities")
    cy <- name.activities(merged$y)
    # Use descriptive column name for subjects
    message("Going to set colnames for subject")
    colnames(merged$subject) <- c("subject")
    # Combine data frames into one
    message("Going to Call bind.data")
    combined <- bind.data(cx, cy, merged$subject)
    # Create tidy dataset
    message("Going to create.tidy.dataset")
    tidy <- create.tidy.dataset(combined)
    # Write tidy dataset as csv
   # write.csv(tidy, "UCI_HAR_tidy.csv", row.names=FALSE)
    write.table(tidy, "UCI_HAR_tidy.txt", sep = " ", row.names=FALSE)
   # This command resets the working directory to the privious working directory
   setwd("D:\\Learning\\Coursera\\Data_Scientist\\Assignments")
   tidy
}