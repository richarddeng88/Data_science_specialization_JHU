library(kernlab)
data(spam)
str(spam[,1:5])
length(spam)
nrow(spam)
ncol(spam)

##exploratory data analysis
#1. seperate the dataset randomly into two dataset. 
set.seed(3435)
indicator <- rbinom(nrow(spam),1,0.5)  
table(indicator)
trainspam <- spam[indicator ==1,] # randomply seperate the original dataset
testspam <- spam[indicator == 0,]

#2. see summary and get a sense of the trainspam data
names(trainspam)
head(trainspam)
table(trainspam$type)

#3. ploting. but since all the variables are numeric excpet the last one. how to explore it?
plot(trainspam$capitalAve ~ trainspam$type)
plot(log10(trainspam$capitalAve+1) ~ trainspam$type)
plot(log10(trainspam[,1:4]+1))  #relationship between predictors
#clustering
hcluster <- hclust(dist(t(trainspam[,1:57])))
plot(hcluster)
hcluster_updated <- hclust(dist(t(log10(trainspam[1:55]+1))))
plot(hcluster_updated)

## statistical prediction and modeling
trainspam$numType <- as.numeric(trainspam$type)-1
costfunction <- function(x,y) {sum(x!=(y>0.5))}
cvError <- rep(NA,55)
library(boot)
for(i in 1:55){
    lmformula <- reformulate(names(trainspam)[i], response = "numType")
    glmfit <- glm(lmformula,family="binomial",data=trainspam)
    cvError[i] <- cv.glm(data=trainspam,glmfit, costfunction,K=2)$delta[2]
    # k: the number of groups into which the data should be split to estimate the cross
    # validation prediction error. 
}

names(trainspam)[which.min(cvError)]

## get a measure of uncertainty
#use the best model from the group
prediction_model <- glm(numType ~ charDollar, family="binomial", data = trainspam)
#get predictions on the test set
prediction_test <- predict(prediction_model,testspam)
predicted_spam <- rep("nonspam",dim(testspam)[1])
#classify as "sapm" for those with prob > 0.5
predicted_spam[prediction_model$fitted >0.5] = "spam"

##classification table
table(predicted_spam,testspam$type)









