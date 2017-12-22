library(dplyr)

#downloading and unzipping the file

if(!file.exists("Data.zip")){
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "Data.zip")
}

if(!file.exists("UCI HAR Dataset")){
        unzip("Data.zip")
        
}

#Importing data

labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

features[,2] <- as.character(features[,2]) #this is so that grep works

features_sub <- grep(".*mean.*|.*std.*", features[,2])
features_req <- features[features_sub, 2]

#Importing the training and testing datasets

train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
train_x <- train_x[features_sub]
train_y <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subj <- read.table("UCI HAR Dataset/train/subject_train.txt")

train <- cbind( train_y, train_subj, train_x)


test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
test_x <- test_x[features_sub]
test_y <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subj <- read.table("UCI HAR Dataset/test/subject_test.txt")

test <- cbind(test_y, test_subj, test_x)


fulldata <- rbind(train, test)

#Cleaning up features_req to add to the column names

features_req <- gsub("-mean", "Mean", features_req)
features_req <- gsub("-std", "Std", features_req)
features_req <- gsub("[-()]", "", features_req)

#Names look half decent now


colnames(fulldata) <- c("activity", "subject", features_req)


#Labelling Activity

fulldata$activity <- factor(fulldata$activity, levels = labels[,1], labels = labels[,2])

fulldata_means <- summarise_each(group_by(fulldata, activity, subject), funs(mean))



#saving the data
write.table(fulldata_means, "tidy_averages.txt", row.names = FALSE, quote = FALSE)
