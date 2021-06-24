## Install required packages
if (!require("groupdata2")) {
  install.packages("groupdata2", dependencies = TRUE)
  library(groupdata2)
}

if (!require("shiny")) {
  install.packages("shiny", dependencies = TRUE)
  library(shiny)
}

if (!require("rstudioapi")) {
  install.packages("rstudioapi", dependencies = TRUE)
  library(rstudioapi)
}

if (!require("dplyr")) {
  install.packages("dplyr", dependencies = TRUE)
  library(dplyr)
}

if (!require("tidyr")) {
  install.packages("tidyr", dependencies = TRUE)
  library(tidyr)
}

if (!require("knitr")) {
  install.packages("knitr", dependencies = TRUE)
  library(knitr)
}

if (!require("caret")) {
  install.packages("caret", dependencies=c("Depends", "Suggests"))
  library(caret)
}

if (!require("ellipse")) {
  install.packages("ellipse", dependencies = TRUE)
  library(ellipse)
}

if (!require("ggplot2")) {
  install.packages("ggplot2", dependencies = TRUE)
  library(ggplot2)
}

if (!require("scatterplot3d")) {
  install.packages("scatterplot3d", dependencies = TRUE)
  library(scatterplot3d)
}

## set working directory
setwd(dirname(getActiveDocumentContext()$path))

## Subset lists by category (for dashboard)
WBClist <- c("Monocytes", "Lymphocytes", "Neutrophils", "Basophils", "Eosinophils")
RBClist <- c("RBC", "ESR", "MCH", "HCT")
PlateletList <- c("PlateletCount", "MPV")

## Read data
IBS1 <- read.csv("../data/RobinsonEtAl_Sup1.csv", header = TRUE)
CBC <- read.csv("../data/WBCsubset.csv", header = TRUE)
IBSblood <- read.csv("../data/CBC_NAomit.csv", header = TRUE)

## Recursively generate histograms for every CBC parameter

## Resource - https://stackoverflow.com/questions/49889403/loop-through-dataframe-column-names-r
## Resource - https://statisticsglobe.com/loop-through-data-frame-columns-rows-in-r/
## Resource - https://stackoverflow.com/questions/35372365/how-do-i-generate-a-histogram-for-each-column-of-my-table/35373419
## Resource - https://www.r-bloggers.com/2011/04/automatically-save-your-plots-to-a-folder/

for (col in 2:ncol(CBC)) {
  mypath <- file.path("../fig_output",paste(colnames(CBC[col]),".png",sep = ""))
  png(file=mypath)
  H1 <- hist(CBC[,col], freq=FALSE, main = (colnames(CBC[col])), xlab = (colnames(CBC[col])), breaks=20, col = "lightgreen")
  curve(dnorm(x, mean=mean(CBC[,col], na.rm=TRUE), sd=sd(CBC[,col], na.rm=TRUE)), add=TRUE, col="blue", lwd=2)
  print(H1)
  dev.off()
  }

## Multiple Regression
## https://www.statmethods.net/stats/regression.html
## Fit WBC's to BMI 
fit <- lm(BMI ~ Monocytes + Lymphocytes + Neutrophils + Basophils + Eosinophils, data=CBC)
summary(fit) # show results

## Generate Scatterplot for BMI-Lymphocytes
## https://www.statmethods.net/graphs/scatterplot.html
png("../fig_output/BMI_Lymphocytes.png")
H1 <- ggplot(CBC, aes(x=Lymphocytes, y=BMI)) +
        geom_point() +    
        geom_smooth(method=lm)
print(H1)
dev.off()

## Display the model fitting results
png("../fig_output/BMI_CBC_fit.png")
layout(matrix(c(1,2,3,4),2,2))
H1 <- plot(fit)
print(H1)
dev.off()

##  Multiple Regressions using selected parameters
##  https://statquest.org/2017/10/30/statquest-multiple-regression-in-r/
##  http://www.sthda.com/english/articles/40-regression-analysis/167-simple-linear-regression-in-r/
##  http://r-statistics.co/Linear-Regression.html
##  https://www.statmethods.net/stats/regression.html

##  Select the best 3-variable regression model 
fit1 <- lm(BMI ~ SerumCortisol + CRP + ESR + PlateletCount + Lymphocytes , data=IBS1)
summary(fit1)

## 3D scatterplot for the most significant 3-variable multiple regression model
## http://www.sthda.com/english/wiki/scatterplot3d-3d-graphics-r-software-and-data-visualization

s3d <- scatterplot3d(IBS1$BMI, IBS1$SerumCortisol, IBS1$CRP,  pch=16, color="steelblue", box=TRUE, highlight.3d=FALSE, type="h", main="BMI x Cortisol x CRP")
fit <- lm(SerumCortisol ~ BMI + CRP, data=IBS1)
s3d$plane3d(fit)

## Machine Learning to find the best predictive categorization

## Deal with missing (NA) values - impute missing values from IBSblood using sample mean
## Resource - https://www.guru99.com/r-replace-missing-values.html

## Generate list of columns with NA values
list_na <- colnames(IBSblood)[ apply(IBSblood, 2, anyNA) ]
list_na

# generate mean
## debug - https://stackoverflow.com/questions/28423275/dimx-must-have-a-positive-length-when-applying-function-in-data-frame/28423503
average_missing <- apply(as.matrix(IBSblood[,colnames(IBSblood) %in% list_na]), 
                         2, 
                         mean, 
                         na.rm=TRUE)
average_missing



