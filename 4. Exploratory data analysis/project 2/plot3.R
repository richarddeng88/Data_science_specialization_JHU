##get data =========================================================================
dir.create("data")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "data/emissions.zip")
unzip("data/emissions.zip",exdir = "data/emissions")
files<- list.files("data/emissions",recursive=TRUE)

##read data ========================================================================
EI <- readRDS("data/emissions/summarySCC_PM25.rds")
SCC <- readRDS("data/emissions/Source_Classification_Code.rds")

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
