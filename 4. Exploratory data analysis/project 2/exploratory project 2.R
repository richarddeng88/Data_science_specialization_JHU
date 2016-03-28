##get data =========================================================================
dir.create("data")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "data/emissions.zip")
unzip("data/emissions.zip",exdir = "data/emissions")
files<- list.files("data/emissions",recursive=TRUE)

##read data ========================================================================
NEI <- readRDS("data/emissions/summarySCC_PM25.rds")
SCC <- readRDS("data/emissions/Source_Classification_Code.rds")


##exploratory analysis==============================================================
#get a sense of data
head(EI,3)
summary(EI)
str(EI)

## Q1.******************************************** 
library(dplyr)
ei <- tbl_df(DI)
ei_group <- group_by(ei, year)
ei_year <- summarise(ei_group,arrange=sum(Emissions))
plot(ei_year$year,ei_year$arrange,type = "l")
barplot(ei_year$arrange,names.arg=c(1999,2002,2005,2008), 
        main = "Mean PM_2.5 emissions (Tons)", col = rainbow(20, start = 0, end = 1))

#2nd solution
years <- c("1999", "2002", "2005", "2008")
means <- vector()  #initializing data
for (i in years) {
    means[i] <- mean(EI$Emissions[which(EI$year == i)], na.rm = TRUE)
}
# basic plot
barplot(means, col = rainbow(20, start = 0, end = 1), main = "Mean PM_2.5 emissions (Tons)")

## Q2 **********************************************************
ei <- tbl_df(DI)
ei_group <- group_by(ei, year)
ei_year_baltimore <- summarise(filter(ei_group,fips == "24510"),arrange=sum(Emissions))
plot(ei_year_baltimore$year,ei_year_baltimore$arrange,type = "l")
barplot(ei_year_baltimore$arrange,names.arg=c(1999,2002,2005,2008), 
        main = "Mean PM_2.5 emissions (Tons) \n in Baltimore city", col = terrain.colors(6))

#other solution
means.baltimore <- vector()  # preparing plot data
for (i in years) {
    means.baltimore[i] <- mean(NEI$Emissions[which(NEI$year == i & NEI$fips == 
                                                       "24510")], na.rm = TRUE)
}
# basic plot
barplot(means.baltimore, col = terrain.colors(2), main = "Mean PM_2.5 emissions (Tons)\n in Baltimore city")


## Q3 **********************************************************
ei <- tbl_df(DI)
ei_group <- group_by(ei, year)
ei_baltimore <- filter(ei_group,fips == "24510")

#using qplot
library(ggplot2)
qplot(year,Emissions,data=ei_baltimore,facets=.~type,col=type,method="lm",geom=c("point","smooth"))

#using ggplot
g<- ggplot(data=ei_baltimore,aes(year,Emissions))
g<- g+geom_point(aes(color=type),size=4,alpha=0.8)
g<- g+facet_grid(.~type)
g<- g+geom_smooth(method="lm",color="black",linetype=1,size=1,se=FALSE)
print(g)

## Q4 **********************************************************
ei <- tbl_df(DI)
scc<- tbl_df(SCC)
scc_coal <- filter(scc,grepl("Coal",EI.Sector))
ei_coal <- ei[ei$SCC %in% scc_coal$SCC,]
both <- merge(ei_coal,scc_coal,by.x = "SCC", by.y = "SCC")[,c(4,6,9)]

#there are 3 type of coal related emissions here. first, we plot the total for each year. 
ei_group_coal <- group_by(ei_coal, year)
ei_coal_summary <- summarise(ei_group_coal,arrange=sum(Emissions))
barplot(ei_coal_summary$arrange,names.arg=c(1999,2002,2005,2008), 
        main = "Mean PM_2.5 emissions (Tons)", col = rainbow(20, start = 0, end = 1))

# socond, we plot by different type of coal emissions. 
library(ggplot2)
g <- ggplot(data=both,aes(year,Emissions))+geom_point(aes(color=EI.Sector),size=4,alpha=0.5)
g <- g + facet_grid(.~EI.Sector) +geom_smooth(method="lm",linetype=1,color="black",size=1,se=F)
print(g)

## Q5 **********************************************************
ei <- tbl_df(DI)
scc<- tbl_df(SCC)

ei_baltimore <- filter(ei,fips == "24510")
scc_motor <- filter(scc,grepl("Mobile",EI.Sector))
ei_motor_baltimore <- ei_baltimore[ei_baltimore$SCC %in% scc_motor$SCC,]

both_motor_bal <- merge(ei_motor_baltimore,scc_motor,by.x = "SCC", by.y = "SCC")[c(4,6,9)]
#remove outliers. how do you know they are outliers?
both_motor_bal <- filter(both_motor_bal, EI.Sector!= "Mobile - Commercial Marine Vessels" & EI.Sector!="Mobile - Aircraft")

#using ggplot2, there are 8 type of MOTOR, so we try to use lattice plotting system
g <- ggplot(data=both_motor_bal,aes(year,Emissions))+geom_point(aes(color=EI.Sector),size=4,alpha=0.5)
g <- g + facet_grid(.~EI.Sector) +geom_smooth(method="lm",linetype=1,color="black",size=1,se=F)
print(g)

#using lattice plotting system now. 
library(lattice)
xyplot(Emissions~year | EI.Sector, data = both_motor_bal,
       layout=c(4,2),xlab = "Years",main="Motor in Bal")


## Q6 **********************************************************
ei <- tbl_df(DI)
scc<- tbl_df(SCC)

ei_bal <- filter(ei,fips == "24510")
scc_motor <- filter(scc,grepl("Mobile",EI.Sector))
ei_motor_bal <- ei_bal[ei_bal$SCC %in% scc_motor$SCC,c(1,4,6)]
ei_motor_bal <- cbind(ei_motor_bal,city=c("Baltimore"))

ei_los <- filter(ei,fips == "06037")
ei_motor_los <- ei_los[ei_los$SCC %in% scc_motor$SCC,c(1,4,6)]
ei_motor_los <- cbind(ei_motor_los,city=c("Los Angeles County"))

both_bal_los <- rbind(ei_motor_bal,ei_motor_los)

g6 <- ggplot(both_bal_los, aes(x = year, y = Emissions, fill = city))+geom_bar(stat = "identity", position = position_dodge())
print(g6)






