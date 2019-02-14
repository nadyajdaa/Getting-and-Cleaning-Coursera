    #Data has already been downloaded
    #Setting the Working Directory to the folder of the excel sheets.
    
    setwd("C:/Users/Ayoubn/Documents/R course/UCI HAR Dataset/")
    
    #Reading Feature.txt and parsing the 2nd column to  characters.
    feat <- read.csv("C:/Users/Ayoubn/Documents/R course/UCI HAR Dataset/features.txt", header = FALSE, sep = ' ')
    feat <- as.character(features[,2])
    
    #Reading test Data
    data_test <- read.table("C:/Users/Ayoubn/Documents/R course/UCI HAR Dataset/test/X_test.txt")
    labels_test <- read.csv("C:/Users/Ayoubn/Documents/R course/UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "")
    subject_test <- read.csv("C:/Users/Ayoubn/Documents/R course/UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "")
    
    #Combining test Data into a single dataframe and assiging column names
    dataframe_test <- data.frame(subject_test, labels_test,data_test )
    names(dataframe_test) <- c(c("Labels", "Subject"), feat)
    
    #Reading train data
    data_train <- read.table("C:/Users/Ayoubn/Documents/R course/UCI HAR Dataset/train/X_train.txt")
    labels_train <- read.csv("C:/Users/Ayoubn/Documents/R course/UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "")
    subject_train <- read.csv("C:/Users/Ayoubn/Documents/R course/UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "")
    
    #Combining train Data into a single dataframe and assiging column names
    dataframe_train <- data.frame(subject_train, labels_train,data_train )
    names(dataframe_train) <- c(c("Labels", "Subject"), feat)
    
    #Merging train data wtih test data
    dataset <- rbind.data.frame(dataframe_test, dataframe_train)
    
    #Extracting columns that has mean or stanndard deviation functions
    extracts <- grepl("mean|std", feat)
    Measurementss <- dataset[,extracts]
    
    Activities <- read.table("C:/Users/Ayoubn/Documents/R course/UCI HAR Dataset/activity_labels.txt", col.names = c("Number", "Activity"))
    Measurementss$Subject <- Activities[Measurementss$Subject,2]
    
    #intializaing a new variable of the column Names of the dataset to clean it.
    Variable_Names <- names(Measurementss)
    Variable_Names <- gsub("[)][()]", "", Variable_Names)
    Variable_Names <- gsub("^f", "Frequency",Variable_Names)
    Variable_Names <- gsub("^t", "Time",Variable_Names)
    Variable_Names <- gsub("Gyro", "Gyroscope", Variable_Names)
    Variable_Names <- gsub("Acc", "Accelerator", Variable_Names)
    Variable_Names <- gsub("^mean", "Mean", Variable_Names)
    Variable_Names <- gsub("^std", "StandardDeviation", Variable_Names)
    
    #Assigning the new column names to the dataset.
    
    names(Measurementss) <- Variable_Names
    
    write.table(Measurementss, "SubmittedData.txt", row.names = FALSE)