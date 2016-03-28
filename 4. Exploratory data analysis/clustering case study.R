files <- list.files("data/samsung", recursive = T)
load("data/samsung/samsungData.rda")
names(samsungData)


## convert the activity variable from "char" type to "factor" type.
class(samsungData$activity)
samsungData$activity <- factor(samsungData$activity)
class(samsungData$activity)

##
par(mfrow=c(1,2))
#samsungData <- transform(samsungData, activity = factor(activity))
sub1<- subset(samsungData,subject==1)
plot(sub1[,1],col=sub1$activity, ylab = names(sub1)[1])
plot(sub1[,2],col=sub1$activity, ylab = names(sub1)[2])
legend("bottomright", legend = unique(sub1$activity), 
       col = unique(sub1$activity),pch=1)


##clustering
distance <- dist(sub1[,1:3])
clustering <- hclust(distance)
plot(clustering)


#ploting the max acceleration
plot(sub1[,10],col=sub1$activity, ylab = names(sub1)[10],pch=19)
plot(sub1[,11],col=sub1$activity, ylab = names(sub1)[11],pch=19)
distance <- dist(sub1[,10:12])
clustering <- hclust(distance)
plot(clustering)


