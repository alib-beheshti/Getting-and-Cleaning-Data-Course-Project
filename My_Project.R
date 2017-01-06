library(data.table)
## download the zip file and unzip it
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile="dataset.zip")
unzip("./dataset.zip",overwrite=TRUE)
# step 1:merging Test and Train data
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

#step 2:Extract only mean and std measurements
Features<-read.table("./UCI HAR Dataset/features.txt",header=FALSE)
chosen_var<-grep("mean|std",Features$V2)
chosen_data<-data_total[,c(1,2,chosen_var+2)]

#step 3:Use descriptive activity name
activity_names<-read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)
for(i in 1:length(activity_names$V1))
  {chosen_data$activity<-gsub(as.character(activity_names$V1[i]),activity_names$V2[i],chosen_data$activity)}

#step 4:Add descriptive variable name
orig<-c("^t","^f","Acc","Gyro","std","Body","Gravity","Mag","Jerk","Freq")
subs<-c("Time Domain ","Frequency Domain ","Accelerometer ","Gyrometer ","Standard Deviation",
        "Body ","Gravity ","Magnitude ","Jerk ","Frequency")
colnames(chosen_data)[3:length(names(chosen_data))]<-as.character(Features$V2[chosen_var])
name<-names(chosen_data)
for(j in 1:length(orig))
{name<-gsub(orig[j],subs[j],name)}
colnames(chosen_data)<-name

#step 5
dt<-data.table(chosen_data)
dt2<-dt[,lapply(.SD,mean),by="subject,activity"]
write.table(dt2,file="tidy_dataset.csv",sep=",",row.names = FALSE)