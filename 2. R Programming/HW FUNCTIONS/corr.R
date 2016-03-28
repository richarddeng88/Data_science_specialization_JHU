corr <- function(directory, threshold = 0) {

  completed_case <- complete(directory)
  choose <- completed_case["nobs"] > threshold
  ids<- completed_case[choose,]$id
  
  corrr = numeric()
  for (i in ids) { 
  
    filenames<-paste(directory, "/", formatC(i, width = 3, flag = "0"),".csv", sep = "")
    data1 <- read.csv(filenames)
    newdata <- data1[complete.cases(data1),]
    corrr <- c(corrr, cor(newdata$sulfate,newdata$nitrate))
  }
  
  corrr
  
}
