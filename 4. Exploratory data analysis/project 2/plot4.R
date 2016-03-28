##get data =========================================================================
dir.create("data")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "data/emissions.zip")
unzip("data/emissions.zip",exdir = "data/emissions")
files<- list.files("data/emissions",recursive=TRUE)

##read data ========================================================================
EI <- readRDS("data/emissions/summarySCC_PM25.rds")
SCC <- readRDS("data/emissions/Source_Classification_Code.rds")


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
