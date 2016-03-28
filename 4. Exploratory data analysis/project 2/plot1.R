##get data =========================================================================
dir.create("data")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "data/emissions.zip")
unzip("data/emissions.zip",exdir = "data/emissions")
files<- list.files("data/emissions",recursive=TRUE)

##read data ========================================================================
EI <- readRDS("data/emissions/summarySCC_PM25.rds")
SCC <- readRDS("data/emissions/Source_Classification_Code.rds")

## Q1.******************************************** 
library(dplyr)
ei <- tbl_df(EI)
ei_group <- group_by(ei, year)
ei_year <- summarise(ei_group,arrange=sum(Emissions))
plot(ei_year$year,ei_year$arrange,type = "l")
barplot(ei_year$arrange,names.arg=c(1999,2002,2005,2008), 
        main = "Mean PM_2.5 emissions (Tons)", col = rainbow(20, start = 0, end = 1))