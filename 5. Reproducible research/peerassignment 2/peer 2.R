data <- read.csv("data/reproducible_research/repdata-data-StormData.csv")
origin <- data

data<-origin
dim(data)

nmising <- function(x){sum(is.na(x))}
sapply(data,nmising)

names(data) <- tolower(names(data))


library(dplyr)
data$casuality <- data$injuries+data$fatalities
info <- data %>% group_by(evtype) %>% summarize(total=sum(casuality))
info <- info[order(info$total, decreasing = T),][1:10,]
info <- info[order(info$evtype),]


data$propdmgexp <- as.character(data$propdmgexp)
data$propdmgexp[data$propdmgexp=="K"] <- 1000
data$propdmgexp[data$propdmgexp=="M"]=1000000
data$propdmgexp[data$propdmgexp=="B"]=1000000000
data$propdmgexp[data$propdmgexp=="H"]=100
data$propdmgexp <- as.numeric(data$propdmgexp)
data$propdmgexp[is.na(data$propdmgexp)]=0
data$prop <- data$propdmg*data$propdmgexp

info2 <- data %>% group_by(evtype) %>% summarize(total=sum(prop))
info2 <- info2[order(info2$total, decreasing = T),][1:10,]
info2 <- info2[order(info2$evtype),]


barplot(info$total,names.arg=info$evtype, col="blue", xlab="Top 10 events",
        ylab="Casualties",main="Casualties due to severe weather events\nin the U.S from 1950-2011")

library(ggplot2)
p <- qplot(data=info, aes(evtype,total), stat='identity',geom = "bar", fill= evtype,
           xlab="Top 10 events",ylab="Casualties",main="Casualties due to severe weather events\nin the U.S from 1950-2011")



barplot(info2$total,names.arg=info2$evtype, col="lightgreen", xlab="Top 10 events",
        ylab="Economic loss",main="Economic loss due to severe weather events\nin the U.S from 1950-2011")


