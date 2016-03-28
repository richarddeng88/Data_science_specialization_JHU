# Q1: 
# download the data
library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
if (!file.exists("data/get_and_cleanding_data")) {dir.create("data/get_and_cleanding_data")}
download.file(url, "data/get_and_cleanding_data/ss06hid.csv")

dt <- read.csv("data/get_and_cleanding_data/ss06hid.csv")
val <- dt$VAL>23
sum(val, na.rm =T)

# Q3:
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx "
if (!file.exists("data/get_and_cleanding_data")) {dir.create("data/get_and_cleanding_data")}
download.file(url, "data/get_and_cleanding_data/gov_NGAP.xlsx", method = "auto")

library(xlsx)
dat <- read.xlsx("data/get_and_cleanding_data/gov_NGAP.xlsx",sheetIndex = 1,header=T,colIndex = 7:15, rowIndex = 18:23)
sum(dat$Zip*dat$Ext,na.rm=T) 



#Q4:  a question about XML
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"

library(XML)
doc <- xmlInternalTreeParse(url)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
rootNode[[1]][[1]]
zipcode <- xpathSApply(rootNode,"//zipcode",xmlValue)
length(zipcode[zipcode==21231])


#Q5  q question about data.table package

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
if (!file.exists("data/get_and_cleanding_data")) {dir.create("data/get_and_cleanding_data")}
download.file(url, "data/get_and_cleanding_data/ss06pid.csv")

library(data.table)




