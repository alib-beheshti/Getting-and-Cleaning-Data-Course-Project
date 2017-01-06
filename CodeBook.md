##Human Activity Recognition Using Smartphones Dataset
###Raw Dataset
The raw data is downloaded from "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones".
This raw data is obtained from the experiments that have been carried out with a group of 30 volunteers (subjects) within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) 
on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were obtained.
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record following information are provided:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

###Data Files
The dataset includes the following files:
*README.txt
*features_info.txt: Shows information about the variables used on the feature vector.
*features.txt: List of all features.
*activity_labels.txt: Links the class labels with their activity name.
*train/X_train.txt: Training set.
*train/y_train.txt': Training labels.
*test/X_test.txt: Test set.
*test/y_test.txt: Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

*train/subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
*train/Inertial Signals/total_acc_x_train.txt: The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
*train/Inertial Signals/body_acc_x_train.txt: The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
*train/Inertial Signals/body_gyro_x_train.txt: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

###Features and Variables

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals 
(prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth 
filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals 
(tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). 
Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag,
tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, 
fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

### Data Cleaning
The provided MyProject.R file generates a tidy dataset (tidy_data.csv). My_Project.R downloads and unzips the raw data:

library(data.table)
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile="dataset.zip")
unzip("./dataset.zip",overwrite=TRUE)


After that My_Project.R code performs following five steps on raw data to generate the tidy data:
1.Merges the training and the test sets to create one data set.

data_test<-read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
activity_test<-read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
data_test<-cbind(activity_test,data_test)
colnames(data_test)[1] <- "activity"
data_test<-cbind(subject_test,data_test)
colnames(data_test)[1] <- "subject"

data_train<-read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)
activity_train<-read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
data_train<-cbind(activity_train,data_train)
colnames(data_train)[1] <- "activity"
data_train<-cbind(subject_train,data_train)
colnames(data_train)[1] <- "subject"
data_total<-rbind(data_test,data_train)


2.Extracts only the measurements on the mean and standard deviation for each measurement.

Features<-read.table("./UCI HAR Dataset/features.txt",header=FALSE)
chosen_var<-grep("mean|std",Features$V2)
chosen_data<-data_total[,c(1,2,chosen_var+2)]

3.Uses descriptive activity names to name the activities in the data set

activity_names<-read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)
for(i in 1:length(activity_names$V1))
  {chosen_data$activity<-gsub(as.character(activity_names$V1[i]),activity_names$V2[i],chosen_data$activity)}
  
4.Appropriately labels the data set with descriptive variable names.

orig<-c("^t","^f","Acc","Gyro","std","Body","Gravity","Mag","Jerk","Freq")
subs<-c("Time Domain ","Frequency Domain ","Accelerometer ","Gyrometer ","Standard Deviation",
        "Body ","Gravity ","Magnitude ","Jerk ","Frequency")
colnames(chosen_data)[3:length(names(chosen_data))]<-as.character(Features$V2[chosen_var])
name<-names(chosen_data)
for(j in 1:length(orig))
{name<-gsub(orig[j],subs[j],name)}
colnames(chosen_data)<-name

5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

dt<-data.table(chosen_data)
dt2<-dt[,lapply(.SD,mean),by="subject,activity"]
write.table(dt2,file="tidy_dataset.csv",sep=",",row.names = FALSE)

The final tidy data is written in tidy_dataset.csv file.


