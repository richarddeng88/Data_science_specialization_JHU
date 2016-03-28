# Q1
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "
download.file(url, "data/get_and_cleanding_data/ss06hid.csv")
dt <- read.csv("data/get_and_cleanding_data/ss06hid.csv")
agricultureLogical <- dt$ACR==3 & dt$AGS==6
which(agricultureLogical)[1:3] # here NA are allowed and omitted, 
# if in aa <-dt[agricultureLogical,], the result will be a lot NAs.

#Q2:
#    Can not use R to download the pictures so I download manually into the W/D.
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(url, "data/get_and_cleanding_data/jeff.jpg", mode="wb")
library(jpeg)
img <- readJPEG("data/get_and_cleanding_data/jeff.jpg", native=TRUE)
quantile(img, probs=c(0.3, 0.8))

#Q3
url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "
download.file(url1, "data/get_and_cleanding_data/gdp.csv")
df1<- read.csv("data/get_and_cleanding_data/gdp.csv", header = T, skip =4, nrows = 215)
library(dplyr)
df1 <- select(df1,X,X.1,X.3,X.4)
names(df1) <- c("CountryCode", "rankingGDP", "Long.Name", "gdp")

url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv "
download.file(url2, "data/get_and_cleanding_data/country.csv")
df2 <- read.csv("data/get_and_cleanding_data/country.csv")

df <- merge(df1, df2, by=c("CountryCode"))
sum(!is.na(unique(df$rankingGDP)))
df <- arrange(df, desc(rankingGDP))
#======================================================================================

# Q4
library(dplyr)
df %>% group_by(Income.Group) %>% summarize(gpd.mean=mean(rankingGDP,na.rm=T))

# Q5
breaks <- quantile(df$rankingGDP, prob=seq(0,1,by=0.2), na.rm = T)
df$quantileGDP <- cut(df$rankingGDP, breaks=breaks)
table(df$Income.Group,df$quantileGDP)

# answer <- df[(df$Income.Group=="Lower middle income" & df$rankingGDP <38.6), ]

