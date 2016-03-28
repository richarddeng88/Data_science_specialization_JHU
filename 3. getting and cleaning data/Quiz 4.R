# Q1
library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
if (!file.exists("data/get_and_cleanding_data")) {dir.create("data/get_and_cleanding_data")}
download.file(url, "data/get_and_cleanding_data/ss06hid.csv")

dt <- read.csv("data/get_and_cleanding_data/ss06hid.csv")






















