##Q1
dir.create("data/quiz4")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv","data/quiz4/1.csv")
df1 <- read.csv("data/quiz4/1.csv")
name <- strsplit(names(df1),"wgtp")
name[123]

##Q2
library(dplyr)
df2<- read.csv("2.csv", skip = 4, nrows = 215, stringsAsFactors = FALSE)
dt <- select(df2,X.4)
dt <- rename(dt, gdp=X.4)
dt <- filter(dt,gdp!="..",gdp!="")
dt <- mutate(dt,gdpnew=gsub(",","",gdp))
dt[,"gdpnew"] <- as.numeric(dt[,"gdpnew"])
summarise(dt,mean(gdpnew))

##Q3
df3<- read.csv("2.csv", skip = 4, nrows = 215, stringsAsFactors = FALSE)
df3<-select(df3,X,X.1,X.3,X.4)
df3 <- rename(df3,shortname=X,rank=X.1,country=X.3,gdp=X.4)
df3[grep("^United",df3$country),]

##Q4

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv ","data/quiz4/3.csv")
df3 <- read.csv("data/quiz4/3.csv ",skip = 10,header = FALSE,nrows = 390)
#df3 <- rename(df3,CountryCode=V1)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv ","data/quiz4/4.csv")
df4 <- read.csv("data/quiz4/4.csv")
df34 <- merge(df3,df4,by.x="V1",by.y = "CountryCode",all = TRUE)
notes <- df34[grep("Fiscal year end",df34$Special.Notes),"Special.Notes"]
length(grep("June",notes))

##Q5

#download the historical stock price of amazon from quantmod.
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
df5<- sampleTimes

#how many values are collected in 2012?
Y2012 <- df5[grep("^2012",df5)]
length(Y2012) 

#how many values are collected on MOndays in 2012?
sum(weekdays(Y2012)=="Monday")



