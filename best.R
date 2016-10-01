## This file contains the definition of the function 'best'.


best <- function(stateArg, outcome){
  data <- read.csv('rproghw3/outcome-of-care-measures.csv', na.strings = 'Not Available')
  
  outVector<- c('heart attack', 'heart failure', 'pneumonia', 
            'Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack',
            'Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure',
            'Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia')
  
  stateVector<- c("AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC",
                        "DE", "FL", "GA", "GU", "HI", "IA", "ID", "IL", 
                        "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI",
                        "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH",
                        "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA",
                        "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VA",
                        "VI", "VT", "WA", "WI", "WV", "WY")
  
  outcomeColNum<- NULL
  longOutcome<- NULL
  for(i in 1:3){                          
      if(outVector[i]==outcome){
        longOutcome<- outVector[i+3]
        outcomeColNum<- (i*6 +5)
        }   
  }
  
  ## ^^for-loop: Test if 'outcome' is valid. If outcome 
  ## is valid, assign to 'longOutcome' the corresponding
  ## variable name as it appears in the cvs file.
  ## The mortality collumns in the .cvs begin at collumn 11
  ## and occur thereafter every 6th collum up to collumn 23.
  ## Therefore we compute the collumn number associated with
  ## outcome 'i', for 'i' in {1,2,3}, as i*6+5.

  
  if(is.null(longOutcome)){stop('invalid outcome')}                   ## tests if 'longOutcome' is null. It is it,
                                                                      ## then nothing has been assigned to 'longOutcome', 
                                                                      ## which means 'outcome' is invalid, so call 'stop'. 

  
  if(!(stateArg %in% stateVector)){stop('invalid state')}             ## tests if 'state' is valid. If not then call 'stop'.
  
  
  subdata<- subset(data, State==stateArg, select=c(2,outcomeColNum))  ## subset the dataframe into dataframe with 2 collumns:
                                                                      ##  Hospital Name and the 30 day mortality rate of the 
                                                                      ##  outcome argument. 
  
  IndexofBest<- which(subdata[,2]==min(subdata[,2], na.rm = TRUE))    ## which statement returns indicies of min elements
  
  NumTies<-NULL                                                       ## Determines if there is a tie. If so put names of  
  TiedVector<-c()                                                     ## tied hospitals in a vector, sort the vector, and
  if(length(IndexofBest)>1){                                          ## return the first element
    NumTies<- length(IndexofBest)
      for(i in 1:NumTies){
          TiedVector[i]<-subdata[IndexofBest[i],1]
      }
    TiedVector<-sort(TiedVector)
    return(TiedVector[1])
  }
  
  subdata[IndexofBest,1]
}