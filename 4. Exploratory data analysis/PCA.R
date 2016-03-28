#principal component analysis (PCA) and singular value decomposition (SVD), two important and related techniques of dimension reduction.
set.seed(678910)
dataMatrix <- matrix(rnorm(400),40,10)
head(dataMatrix)
heatmap(dataMatrix)

source(file="addPatt.R",local = TRUE)



#| In other words, we'd like to find the best matrix created with fewer variables (that is, a lower rank matrix) that
#| explains the original data. This is related to data compression.




















