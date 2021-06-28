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

# Replace NA values with the calculated mean
average_missing[1]

IBSblood.replacement <- IBSblood %>%
  mutate(Monocytes = ifelse(is.na(Monocytes), average_missing[1], Monocytes))

sum(is.na(IBSblood.replacement$Monocytes))

## IBS.subtype levels are unequal and therefore susceptible to inaccurate testing results
## Balance dataset using groupdata2 package (ie. New rows are generated by random resampling)
## https://cran.r-project.org/web/packages/groupdata2/vignettes/description_of_groupdata2.html#balance-1

## Data as-is
IBSblood %>%
  count(IBS.subtype) %>%
  kable(align = 'c')

## Balance by making each group have 100 rows
df_balanced <- balance(IBSblood, 100, cat_col = "IBS.subtype") %>% 
  arrange(IBS.subtype, ID)

## Data after balancing
df_balanced %>%
  count(IBS.subtype) %>%
  kable(align = 'c')

## Print out descriptive plots for CBC parameters

# summarize the distributions by class
percentage <- prop.table(table(df_balanced$IBS.subtype)) * 100
cbind(freq=table(df_balanced$IBS.subtype), percentage=percentage)

# summarize attribute distributions
summary(df_balanced)

# split input and output
x <- df_balanced[,3:8]
y <- df_balanced[,2]

# Generate box-and-whiskers for each attribute on one image
par(mfrow=c(1,6))
for(i in 1:6) {
  boxplot(x[,i], main=names(x)[i])
}
# Export a scatterplot matrix  
png("../fig_output/ScatterplotMatrix.png")
H1 <- featurePlot(x=x, y=y, plot="ellipse")
print(H1)
dev.off()

# Run algorithms using 10-fold cross validation
control <- trainControl(method="cv", number=10)
metric <- "Accuracy"

# a) linear algorithms
set.seed(7)
fit.lda <- train(IBS.subtype~., data=df_balanced, method="lda", metric=metric, trControl=control)
# b) nonlinear algorithms
# CART
set.seed(7)
fit.cart <- train(IBS.subtype~., data=df_balanced, method="rpart", metric=metric, trControl=control)
# kNN
set.seed(7)
fit.knn <- train(IBS.subtype~., data=df_balanced, method="knn", metric=metric, trControl=control)
# c) advanced algorithms
# SVM
set.seed(7)
fit.svm <- train(IBS.subtype~., data=df_balanced, method="svmRadial", metric=metric, trControl=control)
# Random Forest
set.seed(7)
fit.rf <- train(IBS.subtype~., data=df_balanced, method="rf", metric=metric, trControl=control)

# summarize accuracy of models
results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf))
summary(results)

# compare accuracy of models with an exported boxplot
png("../fig_output/ClassificationSelection.png")
H1 <- dotplot(results)
print(H1)
dev.off()
