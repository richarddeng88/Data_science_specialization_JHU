library(XML)
url <- "http://www.w3schools.com/xml/simple.xml"
xmlFile <- xmlTreeParse(url, useInternalNodes = T)
xmlFile <- xmlParse(url)
# print root size, root name, child name
root <- xmlRoot(xmlFile) #gives content of root
class(root)
xmlName(root) #give name of node, PubmedArticleSet
xmlSize(root)  #how many children in node, 5
names(root) #name of root's children

# have a look at the content of the first child entry
root[[1]]
# have a look at the content of the 2nd child entry
root[[2]]

xmlSize(root[[1]]) #number of nodes in each child
xmlApply(root[[1]], xmlValue)
xmlApply(root[[1]], xmlName)
xmlApply(root[[1]], xmlAttrs)
xmlApply(root[[1]], xmlSize)
price <- xpathSApply(df, "//li[@class='price']",xmlValue)

# XML TO DATAFRAME
data <- xmlToDataFrame(df)



########################################################################################
library(XML)
library(methods)
library(plyr)
# df <- xmlTreeParse("data/XML/resume_w_xsl.xml", useInternalNodes = T)
df <- xmlParse(file = "data/XML/resume_w_xsl.xml")
root <- xmlRoot(df)
xmlName(root)
xmlSize(root)

xmlSize(root[[1]])
xmlApply(root[[1]], xmlName)

root[[1]][[10]]
xmlSize(root[[1]][[10]])
xmlApply(root[[1]][[10]], xmlName)

a <- xmlToDataFrame(root[[1]])





#### teat on db
df <- xmlParse(file = "data/XML/departments.xml")
root <- xmlRoot(df)
xmlName(root)
xmlSize(root)

xmlSize(root[[1]])
xmlApply(root[[1]], xmlName)



