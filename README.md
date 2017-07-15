# Below are the different sub functions written in run_analysis.R to generate Tidy data set from given set of files


# Working Directory        -- D:\\Learning\\Coursera\\Data_Scientist\\Assignments\\Month3_Week4\\Project\\FUCI HAR Dataset
# downloadfile()           -- This function downloads & unzip the source files into my working directory
# mergeTrain_Test_DS()	   -- This function takes care of merging of Train & Test Data Sets 
# extract.mean.and.std()   -- This function extracts only the measurements on the mean and standard deviation for each measurement in the given data set. 
			      # It expects a data set as an input parameter
# name.activities()        -- This function names the activities in the data set of y_train or y_test
			      # Input parameter to this function is a data set either y_train or y_test 	
# bind.data()              -- This function binds different datasets X & Y & Subject into a single data set
			      # Input parameters to this function is 3 different data sets which wants to merge	
# create.tidy.dataset()    -- This function creates an independent tidy data set based on the input values given with the average of each variable for each activity and each subject
# clean.data()             -- This is the main function which will be executed and internally calls different sub functions mentioned above
			      #End of the execution this funtion generates a file called UCI_HAR_tidy.txt which contains tidy data set