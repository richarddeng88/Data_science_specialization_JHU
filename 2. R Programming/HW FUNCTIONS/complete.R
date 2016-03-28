complete <- function(directory, id = 1:332) {

  nobs <- numeric()
  
  for (i in id){
    
    filenames<-paste(directory, "/", formatC(i, width = 3, flag = "0"),".csv", sep = "")
    data1 <- read.csv(filenames)
    nobs <- c(nobs, sum(complete.cases(data1)))
  }
  
 return(data.frame(id,nobs))
  
}
