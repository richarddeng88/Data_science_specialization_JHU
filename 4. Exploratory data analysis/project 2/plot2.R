##get data =========================================================================
dir.create("data")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "data/emissions.zip")
unzip("data/emissions.zip",exdir = "data/emissions")
files<- list.files("data/emissions",recursive=TRUE)

##read data ========================================================================
EI <- readRDS("data/emissions/summarySCC_PM25.rds")
SCC <- readRDS("data/emissions/Source_Classification_Code.rds")


## Q2 **********************************************************
ei <- tbl_df(DI)
ei_group <- group_by(ei, year)
ei_year_baltimore <- summarise(filter(ei_group,fips == "24510"),arrange=sum(Emissions))
plot(ei_year_baltimore$year,ei_year_baltimore$arrange,type = "l")
barplot(ei_year_baltimore$arrange,names.arg=c(1999,2002,2005,2008), 
        main = "Mean PM_2.5 emissions (Tons) \n in Baltimore city", col = terrain.colors(6))