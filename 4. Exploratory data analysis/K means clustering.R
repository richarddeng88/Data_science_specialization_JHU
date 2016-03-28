#As with hierarchical clustering, this technique is most useful in the early stages of analysis when you're trying
#to get an understanding of the data, finding some pattern or relationship between different factors or variables.

#| As we said, k-means is a partioning approach which requires that you first guess how many clusters you have (or want).
#| Once you fix this number, you randomly create a "centroid" (a phantom point) for each cluster and assign each point or
#| observation in your dataset to the centroid to which it is closest. Once each point is assigned a centroid, you readjust
#| the centroid's position by making it the average of the points assigned to it.

#| Once you have repositioned the centroids, you must recalculate the distance of the observations to the centroids and
#| reassign any, if necessary, to the centroid closest to them. Again, once the reassignments are done, readjust the
#| positions of the centroids based on the new cluster membership. The process stops once you reach an iteration in which
#| no adjustments are made or when you've reached some predetermined maximum number of iterations.


###K-MEAN clustering

#randomly get 3 points as centroids, and plot them with different color
cmat
cx <- c(1.0,1.8,2.5)
cy <- c(2.0,1.0,1.5)
points(cx,cy,col=c("red","orange","purple"),pch=3,cex=2,lwd=2)

#1.1calculate the distance btw each point and the three tem centroids and group, and change the points' color. 
distTmp <- mdist(x,y,cx,cy)
cols1 <- c("red","orange","purple")
newClust <- apply(distTmp,2,which.min)
points(x,y,pch=19,cex=2,col=cols1[newClust])

#1.2reclaculate the centroid and replot them to the new coordination. 
newCx <- tapply(x,newClust,mean) 
newCy <- tapply(y,newClust,mean)
points(newCx,newCy,col=cols1,pch=8,cex=2,lwd=2)


#2.1recalculate the distance btw each point and the three tem centroids and change some points' color. 
distTmp2 <- mdist(x,y,newCx,newCy)
newClust2 <- apply(distTmp2,2,which.min)
points(x,y,pch=19,cex=2,col=cols1[newClust2])

finalCx <- tapply(x,newClust2,mean)
finalCy <- tapply(y,newClust2,mean)
#distTmp3 <- mdist(x,y,finalCx,finalCy)
#newClust3 <- apply(distTmp3,2,which.min)
points(finalCx,finalCy,col=cols1,pch=9,cex=2,lwd=2)


##########k-mean function
kmobj<-kmeans(dataFrame,centers=3)

kmObj$iter   #how many iterations the algorithm went through.
plot(x,y,col=kmObj$cluster,pch=19,cex=2)
points(kmObj$centers,col=c("black","red","green"),pch=3,cex=3,lwd=3) 

##########testing with centers=6
plot(x,y,col=kmeans(dataFrame,6)$cluster,pch=19,cex=2)
plot(x,y,col=kmeans(dataFrame,6)$cluster,pch=19,cex=1)










