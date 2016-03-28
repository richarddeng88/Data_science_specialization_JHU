#get data
dir.create("data")
url <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip"
download.file(url, "data/hospital_data.zip")
unzip("data/hospital_data.zip",exdir = "data/hospital")
files<- list.files("data/hospital",recursive=TRUE)

#read data
hos_data <- read.csv("data/hospital/hospital-data.csv")
outcome<-read.csv("data/hospital/outcome-of-care-measures.csv",colClasses = "character")

outcome[, 11] <- as.numeric(outcome[, 11])
## we will get a warning about NAs being introduced;that is okay;
hist(outcome[,11])

#find the best hospital in a state,create a fuction 
best <- function(state, outcome) {
    
  df <- read.csv("data/hospital/outcome-of-care-measures.csv")
  #stage <-levels(df[,7])
  
  ## Check that state and outcome are valid
  if(length(df[df$State== state,7])==0) {
      stop("invalid state")
  }
  
  if(!((outcome=="heart attack") | (outcome=="heart failure") | (outcome=="pneumonia"))){
      stop("invalid outcome")}
  
  ## Return hospital name in that state with the given rank 30-day death 
  ## rate
  if (outcome=="heart attack") {col=11}
  else if (outcome=="heart failure") {col=17}
  else if (outcome=="pneumonia") {col=23}
  
  df[,2] <- as.character(df[,2])
  df[,col] <- as.numeric(df[,col])
  afterstae <- df[grep(state, df$State),]
  orderdata <- afterstae[order(afterstae[,col],afterstae[,2],na.last=TRUE),]
  result <-orderdata[1,2]
  return(result)
  
}


