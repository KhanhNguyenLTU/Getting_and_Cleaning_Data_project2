
#Describes the variables, the data, and transformations or work that I performed to clean up the data
This repo describes the transformations I make to clean the orignal data to produce a tidy data (namely tidydata.txt) as well as descriptions of the tidy data and its varibles.

#Cleaning data
I did five tranformations to clean up the orignal data, as folows:

##1. Merges the training and the test sets to create one data set.
```{r, eval=FALSE}
sub_train <- read.table(subject_train.txt)
y_train <- read.table(y_train.txt)
x_train <-read.table(X_train.txt)
train<- cbind(sub_train, x_train, y_train)
sub_test <- read.table(subject_test.txt)
y_test <- read.table(y_test.txt)
x_test <-read.table(X_test.txt)
test <- cbind(sub_test, x_test, y_test)
merge_data <- rbind(train, test)
```
##2. Extracts only the measurements on the mean and standard deviation for each measurement. 
```{r, eval=FALSE}
features <- read.table(features.txt)
feature_vector <- as.character(features[,2])
colnames(merge_data) <- c(subject,feature_vector,activity)
extract_features <- grep((mean|std)\\(\\), names(merge_data),value = T)
extract_data <- merge_data[,c(subject,extract_features,activity)]
```
##3. Uses descriptive activity names to name the activities in the data set
```{r, eval=FALSE}
activity_labels <- read.table(activity_labels.txt)
extract_data[,activity] <- activity_labels[extract_data[,activity],2]
```
##4. Appropriately labels the data set with descriptive variable names. 
```{r, eval=FALSE}
names(extract_data)<-gsub(^t, time, names(extract_data)) #prefix 't' is replaced by time
names(extract_data)<-gsub(^f, frequency, names(extract_data)) #prefix 'f' is replaced by frequency
names(extract_data)<-gsub(Acc, Accelerometer, names(extract_data)) #'Acc' is replaced by 'Accelerometer'
names(extract_data)<-gsub(Gyro, Gyroscope, names(extract_data)) #'Gyro' is replaced by 'Gyroscope
names(extract_data)<-gsub(Mag, Magnitude, names(extract_data)) #'Mag' is replaced by 'Magnitude'
names(extract_data)<-gsub(BodyBody, Body, names(extract_data)) #BodyBody is replaced by 'Body'
```
##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
```{r, eval=FALSE}
require(reshape2)
extract_data$subject <- as.factor(extract_data$subject)
tidy_data <- melt(extract_data, id = c(subject, activity))
tidy_data <- dcast(tidy_data, subject + activity ~ variable, mean)
write.table(tidy_data, tidydata.txt, row.names = FALSE)
```
#The tidy data and its variables

The tidy data (tidydata.txt) contains 180 objects with 68 variables:
##Identifers

* subject
* activity
The 'subject' is the id of the subject. The 'activity' is the activity of the subject which has one of five values:
* WALKING: the subject was walking
* WALKING_UPSTAIRS: the subject was walking up a staircase
* WALKING_DOWNSTAIRS: subject was walking down a staircase
* SITTING: the subject was sitting
* STANDING: the subject was standing
* LAYING: the subject was laying down


##Measurements
The tidy data consists of 66 measurements, which their values are the average of each variable for each activity and each subject in the original data sets.

* timeBodyAccelerometer-mean()-X
* timeBodyAccelerometer-mean()-Y
* timeBodyAccelerometer-mean()-Z
* timeBodyAccelerometer-std()-X
* timeBodyAccelerometer-std()-Y
* timeBodyAccelerometer-std()-Z
* timeGravityAccelerometer-mean()-X
* timeGravityAccelerometer-mean()-Y
* timeGravityAccelerometer-mean()-Z
* timeGravityAccelerometer-std()-X
* timeGravityAccelerometer-std()-Y
* timeGravityAccelerometer-std()-Z
* timeBodyAccelerometerJerk-mean()-X
* timeBodyAccelerometerJerk-mean()-Y
* timeBodyAccelerometerJerk-mean()-Z
* timeBodyAccelerometerJerk-std()-X
* timeBodyAccelerometerJerk-std()-Y
* timeBodyAccelerometerJerk-std()-Z
* timeBodyGyroscope-mean()-X
* timeBodyGyroscope-mean()-Y
* timeBodyGyroscope-mean()-Z
* timeBodyGyroscope-std()-X
* timeBodyGyroscope-std()-Y
* timeBodyGyroscope-std()-Z
* timeBodyGyroscopeJerk-mean()-X
* timeBodyGyroscopeJerk-mean()-Y
* timeBodyGyroscopeJerk-mean()-Z
* timeBodyGyroscopeJerk-std()-X
* timeBodyGyroscopeJerk-std()-Y
* timeBodyGyroscopeJerk-std()-Z
* timeBodyAccelerometerMagnitude-mean()
* timeBodyAccelerometerMagnitude-std()
* timeGravityAccelerometerMagnitude-mean()
* timeGravityAccelerometerMagnitude-std()
* timeBodyAccelerometerJerkMagnitude-mean()
* timeBodyAccelerometerJerkMagnitude-std()
* timeBodyGyroscopeMagnitude-mean()
* timeBodyGyroscopeMagnitude-std()
* timeBodyGyroscopeJerkMagnitude-mean()
* timeBodyGyroscopeJerkMagnitude-std()
* frequencyBodyAccelerometer-mean()-X
* frequencyBodyAccelerometer-mean()-Y
* frequencyBodyAccelerometer-mean()-Z
* frequencyBodyAccelerometer-std()-X
* frequencyBodyAccelerometer-std()-Y
* frequencyBodyAccelerometer-std()-Z
* frequencyBodyAccelerometerJerk-mean()-X
* frequencyBodyAccelerometerJerk-mean()-Y
* frequencyBodyAccelerometerJerk-mean()-Z
* frequencyBodyAccelerometerJerk-std()-X
* frequencyBodyAccelerometerJerk-std()-Y
* frequencyBodyAccelerometerJerk-std()-Z
* frequencyBodyGyroscope-mean()-X
* frequencyBodyGyroscope-mean()-Y
* frequencyBodyGyroscope-mean()-Z
* frequencyBodyGyroscope-std()-X
* frequencyBodyGyroscope-std()-Y
* frequencyBodyGyroscope-std()-Z
* frequencyBodyAccelerometerMagnitude-mean()
* frequencyBodyAccelerometerMagnitude-std()
* frequencyBodyAccelerometerJerkMagnitude-mean()
* frequencyBodyAccelerometerJerkMagnitude-std()
* frequencyBodyGyroscopeMagnitude-mean()
* frequencyBodyGyroscopeMagnitude-std()
* frequencyBodyGyroscopeJerkMagnitude-mean()
* frequencyBodyGyroscopeJerkMagnitude-std()

