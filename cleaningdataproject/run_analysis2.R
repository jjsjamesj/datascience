## First the test and train sets and their
## respective activity and subject labels
## are loaded in the data frames. Same for 
## feature labels. 

X_test <- read.table("C:/Users/randy/BIGDATA/datascience/cleaningdataproject/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
y_test <- read.table("C:/Users/randy/BIGDATA/datascience/cleaningdataproject/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
subject_test <- read.table("C:/Users/randy/BIGDATA/datascience/cleaningdataproject/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")

X_train <- read.table("C:/Users/randy/BIGDATA/datascience/cleaningdataproject/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
y_train <- read.table("C:/Users/randy/BIGDATA/datascience/cleaningdataproject/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
subject_train <- read.table("C:/Users/randy/BIGDATA/datascience/cleaningdataproject/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")

features <- read.table("C:/Users/randy/BIGDATA/datascience/cleaningdataproject/UCI HAR Dataset/features.txt")

names(X_train) <- features[,2]                 ## Descriptive names are given to the collumns of X_train & X_test
names(X_test) <- features[,2]

mergedData <- rbind(X_train, X_test)           ## Rows of X_train and X_test are merged into one data set.

MeanCols <- grep('mean()', features[,2])       ## Get collumn indicies that corresponde to mean variables. 
MeanData <- mergedData[,MeanCols]              ## Subset the mean variable observations from mergedData.

StdCols <- grep('std()', features[,2])         ## Get collumn indicied that corresponde to std variables.
StdData <- mergedData[,StdCols]                ## Subset the std variable observations from mergedData

activity <- rbind(y_train, y_test)
names(activity) <- 'activity'
subject <- rbind(subject_train, subject_test)
names(subject) <- 'subject'

mergedData <- cbind(MeanData, StdData)
mergedData <- cbind(activity, mergedData)
mergedData<- cbind(subject, mergedData)        ## cbind subject, activity, std, and mean variable observations together. Call it mergedData. 
  

actList <- mergedData$activity

for(i in 1:10299){
  if(actList[i]==1){ actList[i] <- 'walking'} 
  if(actList[i]==2){ actList[i] <- 'walking_upstairs'}
  if(actList[i]==3){ actList[i] <- 'walking_downstairs'}
  if(actList[i]==4){ actList[i] <- 'sitting'}
  if(actList[i]==5){ actList[i] <- 'standing'}
  if(actList[i]==6){ actList[i] <- 'laying'}
}

mergedData$activity <- actList

for(i in 3:length(names(mergedData))){         ## Prepends 'subj_act_avg' to collumn names
  names(mergedData)[i] <- paste('subj_act_avg', names(mergedData)[i], sep = "_")
}

tidyData <- data.frame(matrix(ncol=81))       ## Initialize tidy data set. Give it the new, descriptive names. 
names(tidyData) <- names(mergedData)
activities <- c('walking', 'walking_upstairs', 'walking_downstairs', 'sitting', 'standing', 'laying')


    for(i in 1:30){                            ## Fills in the tidy data set as per the directions. 
        subjData <- mergedData[subject==i,]
        sbjsplitdat <- split(subjData, subjData$activity)
        subjframe <- data.frame(matrix(ncol = 81, nrow = 1))
        for(j in activities){
            subjframe[1,3:81] <- colMeans(sbjsplitdat[[j]][3:81])
            names(subjframe) <- names(tidyData)
            subjframe[1,1] <- i
            subjframe[1,2] <- j
            tidyData <- rbind(tidyData, subjframe)
        }
}
    
    
 
    
    








