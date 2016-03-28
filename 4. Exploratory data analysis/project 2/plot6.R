##get data =========================================================================
dir.create("data")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "data/emissions.zip")
unzip("data/emissions.zip",exdir = "data/emissions")
files<- list.files("data/emissions",recursive=TRUE)

##read data ========================================================================
EI <- readRDS("data/emissions/summarySCC_PM25.rds")
SCC <- readRDS("data/emissions/Source_Classification_Code.rds")


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

