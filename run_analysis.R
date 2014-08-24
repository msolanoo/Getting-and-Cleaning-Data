# The script  run_analysis.R is written to read several data tables and merge them
# There are 5 specific requirement that need to be executed to accomplish the desire outcome to obtain a newly tidy data set

# First, set the working directory
setwd("C:\\Users\\msolanoo\\Documents\\Coursera\\Data Science\\Getting and Cleaning Data\\Course Project\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset")



#######################################################################################
# Requirement 1. Merges the training and the test sets to create one data set.
# Requirement 4. Appropriately labels the data set with descriptive variable names. 

features <- read.table("features.txt") #Load list of features
activity_labels <- read.table("activity_labels.txt") # List activity labels

indexes_means_stds <- grep("mean|std",features$V2) # Obtain the indexes of measurements with means and standard deviations

X_train <- read.table("train/x_train.txt") # Read X_train data
names(X_train) <- features$V2 # Set labels for X_train data
subject_train <- read.table("train/subject_train.txt") # Read subject_train
names(subject_train)<-"subjects" # Set labels for subject_train
y_train <- read.table("train/y_train.txt") # Read y_train data
names(y_train)<-names(y_train)<-"labels" # Set labels for y_train


X_test <- read.table("test/x_test.txt") # Read X_test data
names(X_test) <- features$V2 # Set labels for X_test data
subject_test <- read.table("test/subject_test.txt") # Read subject_test
names(subject_test)<-"subjects" # Set labels for subject_test
y_test <- read.table("test/y_test.txt") # Read y_test data
names(y_test) <- "labels" # Set labels for y_test
#######################################################################################

#######################################################################################
# Requirement 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
X_test_subset <- cbind(subject_test,y_test,subset(X_test,select=indexes_means_stds)) # Create subset of mean/std dev data measurements for X_test
X_train_subset <- cbind(subject_train,y_train,subset(X_train,select=indexes_means_stds)) # Create subset of mean/std dev data measurements for X_train

TestTrain <- rbind(X_test_subset, X_train_subset) # Merge both test and train datasets
#TestTrain$Activity <- activity_labels[result$Activity,]
#######################################################################################

#######################################################################################
# Requirement 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
result <- aggregate(TestTrain[,3:ncol(TestTrain)],list(Subject=TestTrain$subjects,Activity=TestTrain$labels), mean) # Calculate mean for each measurement
result <- result[order(result$Subject),] # Order results by Subject
#######################################################################################

#######################################################################################
# Requirement 3. Uses descriptive activity names to name the activities in the data set
result$Activity <-activity_labels[result$Activity,] # Set friendly names for activities
#######################################################################################

# Write the final result
write.table(result, file="result.txt", sep="\t", row.names=FALSE)
