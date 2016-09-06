library(jsonlite);library(rjson)

json_file <- fromJSON("https://api.github.com/users/jtleek/repos")

names(json_file)

