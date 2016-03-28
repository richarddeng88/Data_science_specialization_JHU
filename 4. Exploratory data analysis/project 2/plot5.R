##get data =========================================================================
dir.create("data")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "data/emissions.zip")
unzip("data/emissions.zip",exdir = "data/emissions")
files<- list.files("data/emissions",recursive=TRUE)

##read data ========================================================================
EI <- readRDS("data/emissions/summarySCC_PM25.rds")
SCC <- readRDS("data/emissions/Source_Classification_Code.rds")

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