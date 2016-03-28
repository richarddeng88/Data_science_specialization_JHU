rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    df <- read.csv("data/hospital/outcome-of-care-measures.csv")
    
    ## Check that state and outcome are valid
    
    if(length(df[df$State== state,7])==0) {
        stop("invalid state")
    }
    
    if(!((outcome=="heart attack") | (outcome=="heart failure") | (outcome=="pneumonia"))){
        stop("invalid outcome")}
    
    
    ## Return hospital name in that state with the given rank
    if (outcome=="heart attack") {col=11}
    else if (outcome=="heart failure") {col=17}
    else if (outcome=="pneumonia") {col=23}
    
    df[,2] <- as.character(df[,2])
    df[, col] <- suppressWarnings(as.numeric(levels(df[, col])[df[, col]]))
    #df[,col] <- as.numeric(df[,col])
    
    afterstae <- df[grep(state, df$State),]
    
    orderdata <- afterstae[order(afterstae[,col],afterstae[,2],na.last=NA),]
    
    if (num=="best") {result <- orderdata[1,2] }
    else if (num=="worst") {result<- orderdata[nrow(orderdata),2]}
    #else {result <- orderdata[num,2]}
    else if (num<=nrow(orderdata)) {result <- orderdata[num,2]}
    else {result <- NA}
    
    result
 
}
