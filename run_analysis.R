
##1. Merges the training and the test sets to create one data set.

sub_train <- read.table("subject_train.txt")
y_train <- read.table("y_train.txt")
x_train <-read.table("X_train.txt")
train<- cbind(sub_train, x_train, y_train)

sub_test <- read.table("subject_test.txt")
y_test <- read.table("y_test.txt")
x_test <-read.table("X_test.txt")
test <- cbind(sub_test, x_test, y_test)

merge_data <- rbind(train, test)

##2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("features.txt")
feature_vector <- as.character(features[,2])
colnames(merge_data) <- c("subject",feature_vector,"activity")
extract_features <- grep("(mean|std)\\(\\)", names(merge_data),value = T)
extract_data <- merge_data[,c("subject",extract_features,"activity")]

##3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("activity_labels.txt")
extract_data[,"activity"] <- activity_labels[extract_data[,"activity"],2]

##4. Appropriately labels the data set with descriptive variable names. 
names(extract_data)<-gsub("^t", "time", names(extract_data)) #prefix 't' is replaced by time
names(extract_data)<-gsub("^f", "frequency", names(extract_data)) #prefix 'f' is replaced by frequency
names(extract_data)<-gsub("Acc", "Accelerometer", names(extract_data)) #'Acc' is replaced by 'Accelerometer'
names(extract_data)<-gsub("Gyro", "Gyroscope", names(extract_data)) #'Gyro' is replaced by 'Gyroscope
names(extract_data)<-gsub("Mag", "Magnitude", names(extract_data)) #'Mag' is replaced by 'Magnitude'
names(extract_data)<-gsub("BodyBody", "Body", names(extract_data)) #BodyBody is replaced by 'Body'

##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
require(reshape2)
extract_data$subject <- as.factor(extract_data$subject)
tidy_data <- melt(extract_data, id = c("subject", "activity"))
tidy_data <- dcast(tidy_data, subject + activity ~ variable, mean)
write.table(tidy_data, "tidydata.txt", row.names = FALSE)
