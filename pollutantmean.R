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

complete <- function(directory, id=1:332 ){
  
  list.files(directory, full.names=TRUE)[id]
    
    
    
            monitorobs<- 0
           if(length(id)==1){
            monitorobs <-0
            data <- read.csv(filenames[id])
            dimension <- dim(data)[1]
                for(j in 1:dimension){
                  if(!is.na(data[['sulfate']][j]) && !is.na(data[['nitrate']][j])){
                    monitorobs <- (monitorobs+1)
                                    }
                        }
                  
            return(data.frame(id, monitorobs))
           }
            
            
          nobsarray <- 0
          k <- 1
          for(i in id){
                
                data <- read.csv(filenames[i])
                dimension <- dim(data)[1]
                    for(j in 1:dimension){
                        if(!is.na(data[['sulfate']][j]) && !is.na(data[['nitrate']][j])){
                          monitorobs <- (monitorobs+1)
                                                      }
                            }
                    nobsarray[k] <- monitorobs
                    
                    
                    k <- (k+1)
                  }
    
          data.frame(id, nobsarray)
    
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






















