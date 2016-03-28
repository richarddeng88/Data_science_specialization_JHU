#hierarchical clustering, a simple way of quickly examining and displaying multi-dimensional data.
#This technique is usually most useful in the early stages of analysis when you're trying to get 
#an understanding of the data, finding some pattern or relationship between different factors or variables. 
#hierarchical clustering creates a hierarchy of clusters.

#"How do we define close?", "How do we group things?", and "How do we interpret the grouping?"
# each observation starts in its own cluster, and pairs of clusters are merged as one moves up the hierarchy.
#This means that we'll find the closest two
# points and put them together in one cluster, then find the next closest pair in the updated picture, and so forth. We'll
# repeat this process until we reach a reasonable stopping place.

# how to dfine close? Distance or similarity are usually the metrics used.
#  there are several ways to measure distance or similarity. 
#   Euclidean distance and correlation similarity are continuous measures, while Manhattan distance is a binary measure.
#   Manhattan distance is the sum of the absolute values of the distances between each coordinate, 

distxy <- dist(ct)
hc <- hclust(distxy)
plot(hc)
plot(as.dendrogram(hc))
abline(h=80,col="blue") 
abline(h=65,col="red")

#complete linkage ,  average linkage
#a heat map is "a graphical representation of data where the individual
# values contained in a matrix are represented as colors

heatmap(dataMatrix,col=cm.colors(25))

set.seed(1234)

x<-rnorm(12,mean=rep(1:3,each=4),sd=0.2)
