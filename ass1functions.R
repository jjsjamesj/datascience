pollutantmean <- function(directory, pollutant, id=1:332){
  id <- formatC(id, width = 3, flag = '0')
  MyMean <- 0
  summands <- 0
  sum <- 0
  
  for(i in id){
    
    fileName <- paste(as.character(i), 'csv', sep='.')
    pathName <- file.path(directory, fileName)
    data<- read.csv(pathName)
    
    for(j in 1 : dim(data)[1]){
      if(!is.na(data[[pollutant]][j])){
        summands <- (1 + summands)
        sum <- (sum + data[[pollutant]][j])
      }
    }
  }
  sum/summands
}

complete2 <- function(directory, id=1:332 ){
  if(is.unsorted(id)){id <- sort(id)}
  filenames <- list.files(directory, full.names=TRUE)[id]
  ObsAtMonitorI<- 0
  MonitorObsList <- 0
  k <- 1
  for(i in 1:length(id)){
    
    mydata <- read.csv(filenames[i])
    dimension <- dim(mydata)[1]
    for(j in 1:dimension){
      if(!is.na(mydata[['sulfate']][j]) && !is.na(mydata[['nitrate']][j])){
        ObsAtMonitorI <- (ObsAtMonitorI+1)
      }
    }
    MonitorObsList[k] <- ObsAtMonitorI
    
    
    k <- (k+1)
  }
  
  data.frame(id, MonitorObsList)
  
}




corr <- function(directory, threshold =0){
  filenames <- list.files(directory, full.names=TRUE)
  leng <- length(filenames)
  k <- 1
  corray <- 0
  for(i in 1:leng){
    numbcomplete <- (complete(directory, i)[[2]][1])
    if(numbcomplete > threshold){
      
      datatable <- read.csv(filenames[i])
      corray[k] <- cor(datatable[2], datatable[3], use = 'complete.obs')
      k <- (k+1)
    }
  }
  corray
}

