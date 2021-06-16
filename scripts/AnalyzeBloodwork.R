## Install and load required packages
if (!require("ggplot2")) {
  install.packages("ggplot2", dependencies = TRUE)
  library(rstudioapi)
}

if (!require("dplyr")) {
  install.packages("dplyr", dependencies = TRUE)
  library(rstudioapi)
}

if (!require("scatterplot3d")) {
  install.packages("scatterplot3d", dependencies = TRUE)
  library(rstudioapi)
}

## Read and write data
IBS1 <- read.csv("data/RobinsonEtAl_Sup1.csv", header = TRUE)
CBC <- read.csv("data/WBCsubset.csv", header = TRUE)
summary(IBS1)
summary(CBC)
write.csv(IBS1, "data_output/output.csv")

## Recursively generate histograms for each CBC parameter
## Contribution - https://stackoverflow.com/questions/49889403/loop-through-dataframe-column-names-r
## Contribution - https://statisticsglobe.com/loop-through-data-frame-columns-rows-in-r/
## Solution for iterative histogram generation - https://stackoverflow.com/questions/35372365/how-do-i-generate-a-histogram-for-each-column-of-my-table/35373419
## Solution for iterative readout for image files - https://www.r-bloggers.com/2011/04/automatically-save-your-plots-to-a-folder/
for (col in 2:ncol(CBC)) {
  mypath <- file.path("fig_output",paste(colnames(CBC[col]),".png",sep = ""))
  png(file=mypath)
  H1 <- hist(CBC[,col], freq=FALSE, main = (colnames(CBC[col])), xlab = (colnames(CBC[col])), breaks=20, col = "lightgreen")
  curve(dnorm(x, mean=mean(CBC[,col], na.rm=TRUE), sd=sd(CBC[,col], na.rm=TRUE)), add=TRUE, col="blue", lwd=2)
  print(H1)
  dev.off()
  }

## Multiple Regression for White Blood Cells
## https://www.statmethods.net/stats/regression.html
fit <- lm(BMI ~ Monocytes + Lymphocytes + Neutrophils + Basophils + Eosinophils, data=CBC)
summary(fit) # show results

##  Single Regressions for BMI vs. each blood data variable
##  Data from Robinson, et al. 2019 (doi: https://doi.org/10.1101/608208)
##  https://statquest.org/2017/10/30/statquest-multiple-regression-in-r/
##  http://www.sthda.com/english/articles/40-regression-analysis/167-simple-linear-regression-in-r/
##  http://r-statistics.co/Linear-Regression.html

single.regression <- lm(BMI ~ SerumCortisol, data=IBS1)
summary(single.regression)

single.regression <- lm(BMI ~ CRP, data=IBS1)
summary(single.regression)

single.regression <- lm(BMI ~ ESR, data=IBS1)
summary(single.regression)

single.regression <- lm(BMI ~ PlateletCount, data=IBS1)
summary(single.regression)

single.regression <- lm(BMI ~ IgA, data=IBS1)
summary(single.regression)

single.regression <- lm(BMI ~ Lymphocytes, data=IBS1)
summary(single.regression)

## Multiple Regression

multiple.regression <- lm(BMI ~ SerumCortisol + CRP, data=IBS1)
summary(multiple.regression)

multiple.regression <- lm(BMI ~ SerumCortisol + ESR, data=IBS1)
summary(multiple.regression)

multiple.regression <- lm(BMI ~ SerumCortisol + ESR, data=IBS1)
summary(multiple.regression)

multiple.regression <- lm(BMI ~ SerumCortisol + PlateletCount, data=IBS1)
summary(multiple.regression)

multiple.regression <- lm(BMI ~ SerumCortisol + ACTH, data=IBS1)
summary(multiple.regression)

multiple.regression <- lm(BMI ~ SerumCortisol + Lymphocytes, data=IBS1)
summary(multiple.regression)

multiple.regression <- lm(BMI ~ SerumCortisol + IgA, data=IBS1)
summary(multiple.regression)

multiple.regression <- lm(BMI ~ SerumCortisol + Monocytes_PCT, data=IBS1)
summary(multiple.regression)

multiple.regression <- lm(BMI ~ SerumCortisol + Monocytes, data=IBS1)
summary(multiple.regression)

multiple.regression <- lm(BMI ~ SerumCortisol + Lymphocytes_PCT, data=IBS1)
summary(multiple.regression)

multiple.regression <- lm(BMI ~ SerumCortisol + IgG, data=IBS1)
summary(multiple.regression)

multiple.regression <- lm(BMI ~ SerumCortisol + IgE, data=IBS1)
summary(multiple.regression)

multiple.regression <- lm(BMI ~ SerumCortisol + IgM, data=IBS1)
summary(multiple.regression)

multiple.regression <- lm(BMI ~ SerumCortisol + Neutrophils, data=IBS1)
summary(multiple.regression)

multiple.regression <- lm(BMI ~ SerumCortisol + Neutrophil_PCT, data=IBS1)
summary(multiple.regression)

multiple.regression <- lm(BMI ~ SerumCortisol + IL10, data=IBS1)
summary(multiple.regression)

multiple.regression <- lm(BMI ~ SerumCortisol + LBP, data=IBS1)
summary(multiple.regression)

##Select the best 3-variable regression model based on highest scores from previous tests

fit1 <- lm(BMI ~ SerumCortisol + CRP + ESR + PlateletCount + Lymphocytes , data=IBS1)
summary(fit1)

fit1 <- lm(BMI ~ SerumCortisol + CRP + ESR, data=IBS1)
summary(fit1)

fit1 <- lm(BMI ~ SerumCortisol + CRP, data=IBS1)
summary(fit1)
print(fit1)

## Scatterplots
## https://www.statmethods.net/graphs/scatterplot.html


ggplot(IBS1, aes(x=BMI, y=SerumCortisol)) +
  geom_point() +    
  geom_smooth(method=lm) 

ggplot(IBS1, aes(x=BMI, y=CRP)) +
  geom_point() +    
  geom_smooth(method=lm)  


## 3D scatterplot for the most significant 3-variable multiple regression model
## http://www.sthda.com/english/wiki/scatterplot3d-3d-graphics-r-software-and-data-visualization

s3d <- scatterplot3d(IBS1$BMI, IBS1$SerumCortisol, IBS1$CRP,  pch=16, color="steelblue", box=TRUE, highlight.3d=FALSE, type="h", main="BMI x Cortisol x CRP")
fit <- lm(SerumCortisol ~ BMI + CRP, data=IBS1)
s3d$plane3d(fit)
