##read the file
list.files("data/pm25", recursive = T)
pm0 <- read.table("data/pm25/RD_501_88101_1999-0.txt",sep = "|",comment.char = "#",
                  header = F,na.strings = "")


##read the variable names
cnames <- readLines("data/pm25/RD_501_88101_1999-0.txt",1)
cnames <- strsplit(cnames, split = "\\|")

##assign the colum name to the dataset
######??????? i don't understand why it it cnames[[1]]
names(pm0) <- cnames[[1]]
names(pm0) <- make.names(cnames[[1]])

x0 <- pm0$Sample.Value
summary(x0)
mean(x0,na.rm=T)
mean(is.na(x0))


## read the second files
pm1 <- read.table("data/pm25/RD_501_88101_2012-0.txt",comment.char = "#",
                  header = F, sep = "|")
names(pm1) <- make.names(cnames[[1]])

#get a sense of summary 
x1 <- pm1$Sample.Value
summary(x1)
mean(x1,na.rm=T)

mean(is.na(x1)) #what percentage of missing value
mean(is.na(x0))

sum(x0,na.rm = T)
sum(x1,na.rm = T)

#ploting
boxplot(x0,x1)
boxplot(log10(x0),log10(x1))

negative <- x1<0
sum(negative, na.rm = T)
mean(negative,na.rm=T)

dates <- pm1$Date
dates <- as.character(dates)
dates <- as.Date(dates,"%Y%m%d")

par(mfrow=c(1,2))
hist(dates,"month", col="lightblue")
hist(dates[negative],"month")

site0 <- unique(subset(pm0, State.Code==36)[,c(4,5)])
site1 <- unique(subset(pm1, State.Code==36, c(4,5)))

site0 <- paste(site0[,1],site0[,2], sep=".")
site1 <- paste(site1[,1],site1[,2], sep=".")

both <- intersect(site0, site1)

pm0$county.site <- paste(pm0$County.Code,pm0$Site.ID,sep = ".")
pm1$county.site <- paste(pm1$County.Code,pm1$Site.ID,sep = ".")

cnt0 <- subset(pm0, pm0$State.Code == 36 & county.site %in% both)[,c(3,4,5,11,13,29)]
cnt1 <- subset(pm1, pm1$State.Code == 36 & county.site %in% both)[,c(3,4,5,11,13,29)]

a <- split(cnt0,cnt0$county.site)
sapply(a,nrow)

b <- split(cnt1,cnt1$county.site)
sapply(b,nrow)

library(dplyr)
pm0sub <- group_by(cnt0,county.site)
mean1 <- summarise(pm0sub,com = mean(Sample.Value,na.rm=T))

pm1sub <- group_by(cnt1,county.site)
mean2 <- summarise(pm1sub,com = mean(Sample.Value,na.rm=T))

cbind(mean1, mean2)
merge(mean1,mean2,by= "county.site")

#####
pmsub0 <- subset(cnt0,county.site==63.2008)
date0 <- pmsub0$Date
date0 <- as.Date(as.character(date0),"%Y%m%d")

pmsub1 <- subset(cnt1,county.site==63.2008)
date1 <- pmsub1$Date
date1 <- as.Date(as.character(date1),"%Y%m%d")

rng <- range(pmsub0$Sample.Value, pmsub1$Sample.Value, na.rm=T)

plot.new()
par(mfrow=c(1,2))

plot(date0,pmsub0$Sample.Value, pch=19, ylim = rng)
abline(h=mean(pmsub0$Sample.Value,na.rm = T), col="red")

plot(date1, pmsub1$Sample.Value,pch=19, ylim = rng)
abline(h=mean(pmsub1$Sample.Value,na.rm = T), col="red")

##### compare by state
mn0 <- with(pm0, tapply(Sample.Value,Site.ID,mean, na.rm=T ))
summary(mn0)

mn1 <- with(pm1, tapply(Sample.Value,Site.ID,mean, na.rm=T ))
summary(mn1)

d0 <- data.frame(state=names(mn0),mean=mn0)
d1 <- data.frame(state=names(mn1),mean=mn1)
mrg <- merge(d0,d1,by="state")

##plot

par(mfrow=c(1,1))
dim(mrg)
with(mrg, plot(rep(1999,142),mrg[,2],xlim = c(1996,2010),ylim = c(0,25),
               xlab = "year", ylab = "sample value"))
with(mrg, points(rep(2008,142),mrg[,3]))

segments(rep(1999,142),mrg[,2],rep(2008,142),mrg[,3])





