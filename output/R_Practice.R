## Basic calculations

2 + 3
2 * 3
sqrt(36)
log10(100)
10 / 3
10 %/% 3
10 %% 3

## Assignment Operator

a <- 10
a = 100
a

## Data Types

class(a)
print(a)

a <- as.character(a)
print(a)
class(a)

## Packages

install.packages("car")
library(car)
require(car)
library()
library(help=car)

##Import/Export Data

myData <- read.table("c:/myInputData.txt", header = FALSE, sep="|", colClasses=c("integer","character","numeric")) 
                     
myData <- read.csv("c:/myInputData.csv", header=FALSE)



write.csv(rDataFrame, "/data_output/output.csv")
