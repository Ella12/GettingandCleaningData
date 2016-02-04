library(stringr)
library(plyr)

###Helper functions

#read amd merge by colunms train , test sets
open_file <- function(fname) {
  
  if(!file.exists(fname)) {
    stop(paste("The file",fname, "does not exists"))
   } else {
     dataf <- read.table(fname, quote="\"", comment.char="", stringsAsFactors = F)
   }
    dataf
}

merge_x_y_subject <- function(dir="test") {
  
   #Constract file names 
   end=".txt"
   dir<- str_trim(dir)
   xfilename = sprintf("%s/%s%s%s",dir,'X_',dir,end)
   yfilename = sprintf("%s/%s%s%s",dir,"y_",dir,end)
   subjectfilename = sprintf("%s/%s%s%s",dir,"subject_",dir,end)
   sprintf("x=%s y=%s sub=%s", xfilename,yfilename,subjectfilename)  
   
     
   x.data.frame <- open_file(xfilename)
   y.data.frame <- open_file(yfilename)
   subject.data.frame <- open_file(subjectfilename)
   combined <- data.frame(subject.data.frame,y.data.frame,x.data.frame)
   combined
   
}

merge_test_train <- function(train.df, test.df) {
  
  combined <-rbind(train.df,test.df)
  combined
  
}

 ###### Script functions

first_data_set <- function() {
  
  ## 1) Merges the training and the test sets to create one data set.
  
  test.df <- merge_x_y_subject("test")
  train.df<- merge_x_y_subject("train")
  train.test.df <- merge_test_train(train.df ,test.df)
  #clean memory
  rm(list=c("train.df", "test.df"))
  ####################################################
  
  ## 2)Extracts only the measurements on the mean and standard deviation for each measurement.
 
  names<-open_file('features.txt')
  #make dataframe with subjects, activity and mean & std foreach variable
  colnames(train.test.df) <-c("subject","activity",names$V2)
  newnames <- grep("mean\\(|std", names$V2,value = T)
  train.test.df <- subset(train.test.df,select = c("subject","activity",as.character(newnames)))
  ####################################################
  
  
  ## 3)Uses descriptive activity names to name the activities in the data set
  
  
  ##give activity appropriate names
  lookup <- read.table('activity_labels.txt',header = F,nrows = 6,stringsAsFactors = F)
  lookup <- as.vector(lookup$V2)
  train.test.df <- mutate(train.test.df, activity=lookup[activity])
  
  ## 4) Appropriately labels the data set with descriptive variable names. 
 
  # replace the \\(\\)  with "" and - with .
  colnames(train.test.df) <- sub("\\(\\)","",colnames(train.test.df))
  colnames(train.test.df) <-gsub("-",".", colnames(train.test.df))
  
  pat = "^[t](.*)"
  colnames(train.test.df)<-gsub(pat,"time\\.\\1", colnames(train.test.df))
  
  pat = "^[f](.*)"
  colnames(train.test.df)<-gsub(pat,"frequency\\.\\1\\2\\2", colnames(train.test.df))
  
  
  ##write to file
  write.table(train.test.df, file="../data_set1.txt")
  print("Data set was created: data_set1.txt")
}


second_data_set <- function() {
  
  d1 <-  open_file("../data_set1.txt")
  
  d1$activity <- factor(d1$activity)
  d1$subject <- factor(d1$subject)
  
  d <-ddply(d1,.(subject,activity), numcolwise(mean))
  
  write.table(d, file="../data_set2.txt")
  print("Data set was created: data_set2.txt")
  
}


#########
# Script
#########

setwd('F:\\MA_Statistics\\Coursera\\Getting_Cleaning_Data\\Quizes\\week4\\getdata-projectfiles-UCI HAR Dataset\\GettingandCleaningData')
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "data.zip")
unzip("data.zip")
setwd('UCI HAR Dataset/')

first_data_set()
second_data_set()

