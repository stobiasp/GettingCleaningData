
#getwd()

for (i in 1){

# Are files in  the working directory
listed.files<-dir()
required.files<-c("X_train.txt","features.txt","X_test.txt","subject_train.txt","y_test.txt","y_train.txt")

for (i in required.files){
input<-0
if(max(i == listed.files)==0) {input<-"a"}
tryCatch((1+input),error=function(e) stop(paste(i,": file not in working directory")))
print(paste(i,": File Located!"))
}


###################################################################
#1.Merges the training and the test sets to create one data set.
###################################################################


#import train data set 
train<-read.table("X_train.txt")
activityTrain<-read.table("y_train.txt")
subjectTrain<-read.table("subject_train.txt")

#Combine Files
train<-cbind(train,activityTrain)
train<-cbind(train,subjectTrain)


#import test data set and create a flag to identify data source
test<-read.table("X_test.txt")
activityTest<-read.table("y_test.txt")
subjectTest<-read.table("subject_test.txt")

#Combine Files
test<-cbind(test,activityTest)
test<-cbind(test,subjectTest)

# combine two dta sets into one
fulldata<-rbind(test,train)



###################################################################
#2 Extracts only the measurements on the mean and standard deviation for each measurement. 
#4 Make desciptive names 
###################################################################

# import feature name set to set column names and subset data
features<-read.table("features.txt")


#transpose features into a vector and rename columns of the combined data set
v.features<-as.vector(features[,2])
colnames(fulldata)<-v.features
colnames(fulldata)[562]<-c("Activity_ID")
colnames(fulldata)[563]<-c("Subject_Id")


#subset vector to only include fields that have mean or std in them
v_mean<-grep("mean()",v.features)
v_std<-grep("std()",v.features)

# subset the data to the mean and std variables only
part_data<-fulldata[,c(v_mean,v_std,562,563)]


###################################################################
#3. Make activity names descriptive
###################################################################


part_data$ActivityName<-NA


for(i in 1:nrow(part_data)){
if(part_data$Activity_ID[i]==1){part_data$ActivityName[i]<-"WALKING"}
if(part_data$Activity_ID[i]==2){part_data$ActivityName[i]<-"WALKING_UPSTAIRS"}
if(part_data$Activity_ID[i]==3){part_data$ActivityName[i]<-"WALKING_DOWNSTAIRS"}
if(part_data$Activity_ID[i]==4){part_data$ActivityName[i]<-"SITTING"}
if(part_data$Activity_ID[i]==5){part_data$ActivityName[i]<-"STANDING"}
if(part_data$Activity_ID[i]==6){part_data$ActivityName[i]<-"LAYING"}
}




###################################################################
#5. Create a tidy data set
###################################################################


### Average the metrics from each column and transpose to a row, 
##summerize at Subject ID/ Activity type

tidyData <- data.frame(Subject_ID=character(),
                 ActivityName=character(), 
                 VariableName=character(), 
                 AverageValue=numeric(), 
                 stringsAsFactors=FALSE) 

for (ii in unique(part_data$Subject_Id))
{
  temp1<-part_data[which(part_data$Subject_Id==ii),]
  for (j in unique(temp1$ActivityName)){
 temp2<- as.data.frame(cbind(j,ii,colMeans(temp1[,1:79])))
 temp2$VariableName<-rownames(temp2)
 
 tidyData<-rbind(tidyData,temp2)}}
 
 colnames(tidyData)<-c("Activity Name","Subject ID","Avg. Metric Value" ,"Metric Name")

write.table(tidyData,"tidyDatafinal.txt",sep='|',row.names=F)


### Remove any unused data sets
rm(list = 
     c("activityTest"
       ,"activityTrain"
       ,"features"
       #,"fulldata"
       ,"i" 
       ,"ii"  
       ,"input"
       ,"j"
       ,"listed.files"
       ,"part_data"
       ,"required.files"
       ,"subjectTest"   
       ,"subjectTrain"
       ,"temp1"  
       ,"temp2"
       #,"test" 
       #,"tidyData"
       #,"train"
       ,"v.features"
       ,"v_mean"
       ,"v_std"
     ))
}



