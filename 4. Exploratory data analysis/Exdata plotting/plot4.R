#get data
dir.create("data")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "data/power_comsumption.zip")
unzip("data/power_comsumption.zip",exdir = "data/power")
files<- list.files("data/power",recursive=TRUE)


#read data
data <- read.table("data/power/household_power_consumption.txt",sep = ";", header = T, na.strings = "?")

#clean data and take out a sample of data
data$Datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data_feb01 <- data[grep("2007-02-01",data$Datetime),]
data_feb02 <- data[grep("2007-02-02",data$Datetime),]
df <- rbind(data_feb01,data_feb02)
rm(data_feb01,data_feb02)

#4
par(mfrow=c(2,2))
#plot1
plot(df$Datetime,df$Global_active_power,type = "l", ylab = "Global Active Power",xlab = "")

#plot2
plot(df$Datetime,df$Voltage ,type = "l", ylab = "Voltage",xlab = "Datetime",ylim = c(234,246))

#plot3
plot(df$Datetime, df$Sub_metering_1, xlab = "", ylab = "Energy sub meeting", type = "l")
points(df$Datetime, df$Sub_metering_2, type = "l", col="red")
points(df$Datetime, df$Sub_metering_3, type = "l", col="blue")
legend("topright",lty=1, col= c("black","red","blue"),legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),bty="n",text.font=8)

#plot4
plot(df$Datetime,df$Global_reactive_power ,type = "l", ylab = "Global_reactive_power",xlab = "Datetime",ylim = c(0, 0.5))









