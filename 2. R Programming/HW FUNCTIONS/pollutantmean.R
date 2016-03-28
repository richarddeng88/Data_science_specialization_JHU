pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  data2 <- numeric()
  
  for (i in id){
    filenames<-paste(directory, "/", formatC(i, width = 3, flag = "0"),".csv", sep = "")
    data <- read.csv(filenames)
    data1<- data[,pollutant]
    data2 <- c(data2, data1)

  }

  mean(data2,na.rm=TRUE)

}