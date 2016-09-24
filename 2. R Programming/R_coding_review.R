# factor
apple_colors <- c('green','green','yellow','red','red','red','green')
factor_apple <- factor(apple_colors)

#Data Frames
a <- 	data.frame(
    gender = c("Male", "Male","Female"), 
    height = c(152, 171.5, 165), 
    weight = c(81,93, 78),
    Age = c(42,38,26)
)


## Built-in Function
## Simple examples of in-built functions are seq(), mean(), max(), sum(x) and paste(...) etc. 
seq(20,40,0.1)

    ## User-defined Function
    aa <- function(a) {
        for(i in 1:a) {
            b <- i^2
            print(b)
        }
    }	
    aa(10)

######################################### string manipulation ############################################
    #Concatenating Strings - paste() function
    
    #Formatting numbers & strings - format() function
    result <- format(23.123456789, digits = 9)
    print(result)
    result <- format(c(6, 13.14521), scientific = TRUE)
    print(result)
    result <- format(23.47, nsmall = 5)
    print(result)
    result <- format(13.7, width = 6)
    print(result)
    result <- format("Hello", width = 8, justify = "l")
    print(result)
    
    #Counting number of characters in a string - nchar() function
    result <- nchar("Count the number of characters")
    print(result)

    #Changing the case - toupper() & tolower() functions
    
    #Extracting parts of a string - substring() function
    result <- substring("Extract", 5, 7)
    print(result)
    
###################################### vector creation & manipulation  ###################################
    #Using sequence (Seq.) operator
    #Using the c() function
    
    #Accessing Vector Elements
    #Vector arithmetic
    #Two vectors of same length can be added, subtracted, multiplied or divided giving the result as a vector output.
    v1 <- c(3,8,4,5,0,11)
    v2 <- c(4,11,0,8,1,2)
    add.result <- v1+v2
    print(add.result)
    
    #Vector Element Sorting
    v <- c(3,8,4,5,0,11, -9, 304)
    sort.result <- sort(v)
    print(sort.result)
    revsort.result <- sort(v, decreasing = TRUE)
    print(revsort.result)
    

################################## List creation and manipulation#########################################
    # name list elements
    list_data <- list(c("Jan","Feb","Mar"), matrix(c(3,9,5,1,-2,8), nrow = 2),list("green",12.3))
    names(list_data) <- c("1st Quarter", "A_Matrix", "A Inner list")
    print(list_data)
    print(list_data[3][1])
    
    #Merging Lists
    list1 <- list(1,2,3)
    list2 <- list("Sun","Mon","Tue")
    merged.list <- c(list1,list2)
    print(merged.list)
    
    #Converting List to Vector
    list1 <- list(1:5)
    print(class(list1))
    v1 <- unlist(list1)
    print(class(v1))
    
## facotr creation and manipulation
    # Factors are created using the factor () function by taking a vector as input.
    
    # Changing the Order of Levels
    data <- c("East","West","East","North","North","East","West","West","West","East","North")
    factor_data <- factor(data)
    print(factor_data)
    # Apply the factor function with required order of the level.
    new_order_data <- factor(factor_data,levels = c("East","West","North"))
    print(new_order_data)
    

######################################## data frame#############################################3
    #Following are the characteristics of a data frame.
        # The column names should be non-empty.
        # The row names should be unique.
        # The data stored in a data frame can be of numeric, factor or character type.
        # Each column should contain same number of data items.
    emp.data <- data.frame(
        emp_id = c (1:5), 
        emp_name = c("Rick","Dan","Michelle","Ryan","Gary"),
        salary = c(623.3,515.2,611.0,729.0,843.25), 
        
        start_date = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15", "2014-05-11",
                               "2015-03-27")),
        stringsAsFactors = FALSE
    )
    # Print the data frame.			
    print(emp.data) 

    #Get the Structure of the Data Frame
    str(emp.data)    
    
    #Summary of Data in Data Frame
    summary(emp.data)
    
    #Extract Data from Data Frame
    result <- emp.data[1:2,]
    print(result)
    result <- emp.data[,1:2]
    print(result)
    
    ##Add Row --- using rbind() function
    
## R packages
    #Get library locations 
    .libPaths()

######################################### Data Reshaping###################################################
    #Joining Columns and Rows in a Data Frame
    city <- c("Tampa","Seattle","Hartford","Denver")
    state <- c("FL","WA","CT","CO")
    zipcode <- c(33602,98104,06161,80294)
    addresses <- cbind(city,state,zipcode)
    cat("# # # # The First data frame\n") 
    print(addresses)
    
    new.address <- data.frame(
        city = c("Lowry","Charlotte"),
        state = c("CO","FL"),
        zipcode = c("80230","33949"),
        stringsAsFactors = FALSE
    )
    cat("# # # The Second data frame\n") 
    print(new.address)
    
    all.addresses <- rbind(addresses,new.address)
    cat("# # # The combined data frame\n") 
    print(all.addresses)

##Merging Data Frames
    #The data frames must have same column names on which the merging happens.
    #On choosing these two columns for merging, the records where values of these two variables match in both 
    #data sets are combined together to form a single data frame.
    library(MASS)
    merged.Pima <- merge(x = Pima.te, y = Pima.tr,
                         by.x = c("bp", "bmi"),
                         by.y = c("bp", "bmi")
    )
    print(merged.Pima)
    nrow(merged.Pima)
    
# Melting and Casting
    # Basically, you "melt" data so that each row is a unique id-variable combination. Then you "cast" the 
    # melted data into any shape you would like. Here is a very simple example.
    library(MASS)
    library(reshape2)
    print(head(ships))
    
    # we melt the data to organize it, converting all columns other than type and year into multiple rows.
    molten.ships <- melt(ships, id = c("type","year"))
    print(head(molten.ships))
    
    
    
    
    
    
    
    
    