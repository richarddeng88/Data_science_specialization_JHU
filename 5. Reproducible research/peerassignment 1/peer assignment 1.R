## download and read the data 
dir.create("data")
url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download.file(url,"data/reproducible_research/activity_monitoring.zip")
unzip("data/activity_monitoring.zip",exdir = "data/reproducible_research")
list.files("data/activity")

act <- read.csv("data/reproducible_research/activity.csv", header = T)

##1. What is the mean total number of steps taken per day?
library(dplyr)
act1 <- group_by(act,date)
ave_per_day <- summarize(act1, total=sum(steps, na.rm=T), mean = mean(steps, na.rm = T),
                         median = median(steps, na.rm = T))

hist(ave_per_day$total, breaks = 15, ylab = "frequency", xlab="total steps per day", main="")

summary(ave_per_day$total)
##======================================================================================
avgDay <- act %>% group_by(date) %>%
    summarize(total.steps = sum(steps, na.rm = T), 
              mean.steps = mean(steps, na.rm = T))

library(ggplot2)
g <- ggplot(AvgDay, aes(x=total.steps))
g + geom_histogram(binwidth = 2500) + theme(axis.text = element_text(size = 12),  
                  axis.title = element_text(size = 14)) + labs(y = "Frequency") +
                    labs(x = "Total steps/day")
##======================================================================================

## 2. What is the daily activity pattern?
act2 <- group_by(act, interval)
ave_interval <- summarize(act2, mean = mean(steps, na.rm = T))
plot(ave_interval$interval, ave_interval$mean, type = "l", xlab = "interval", ylab = "mean of steps")
max_point <- ave_interval[ave_interval$mean== max(ave_interval$mean),]
points(max_point$interval, max_point$interval, col="red",pch=11)

##======================================================================================
AvgInterval <- activityData %>% group_by(interval) %>%
    summarize(mean.steps = mean(steps, na.rm = T))
g <- ggplot(AvgInterval, aes(x = interval, y = mean.steps))
g + geom_line() + theme(axis.text = element_text(size = 12), 
                        axis.title = element_text(size = 14, face = "bold")) + 
    labs(y = "Mean number of steps") + labs(x = "Interval")
##======================================================================================

## Imputing missing values

## claculate the percentage how many values are missing
sum(is.na(act))
mean(is.na(act$steps))
act3 <- act

for (i in 1:dim(act3)[1]) {
    if (is.na(act3$steps[i])) {
        act3$steps[i]= as.numeric(ave_interval[ave_interval$interval==act3$interval[i],2])
    }
}

newdata <- group_by(act3, date)
ave_newdata <- summarize(newdata, total=sum(steps), mean = mean(steps))

hist(ave_newdata$total, breaks = 15, ylab = "frequency", xlab="total steps per day", main="")
## compare the mean and sd before and after mutating NA, we see the sd decrease 40%,
summary(ave_per_day$total)
sd(ave_per_day$total)
summary(ave_newdata$total)
sd(ave_newdata$total)

# 4. Are there differences in activity patterns between weekdays and weekends?

## make the act4$date varialbe a factor, labeled with weekday and weekend. 
act4 <- act3
act4$date <- weekdays(as.Date((as.character(act$date))))
act4$date[!(act4$date %in% c("Saturday", "Sunday"))] <- "Weekday"
act4$date[act4$date %in% c("Saturday", "Sunday")] <- "Weekend"
act4$date <- factor(act4$date, levels = c("Weekday","Weekend"))

## 
wday <- filter(act4, date=="Weekday")
wend <- filter(act4, date=="Weekend")

wday1 <- wday %>% group_by(interval) %>% summarize(total=sum(steps), mean= mean(steps))
wend1 <- wend %>% group_by(interval) %>% summarize(total=sum(steps), mean= mean(steps))

par(mfrow=c(2,1))
plot(wday1$interval, wday1$mean, type = "l", main="Weekday", 
     xlab = "interval at weekday", ylab = "number of steps",ylim = c(0,250))
plot(wend1$interval, wend1$mean, type = "l", main="Weekend", 
     xlab = "interval at weekend", ylab = "number of steps",ylim = c(0,250))







