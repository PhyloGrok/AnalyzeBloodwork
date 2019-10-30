## Install necessary packages

install.packages("ggplot2")
library(ggplot2)

install.packages("scatterplot3d")
library(scatterplot3d)

## Read data
IBS1 <- read.csv("RobinsonEtAl_Sup1.csv", header = TRUE)

##  Single Regressions for BMI vs. each blood data variable
##  Data was obtained from Robinson, et al. 2019 (doi: https://doi.org/10.1101/608208)
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

## Multiple Regressions

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

s3d <- scatterplot3d(IBS$BMI, IBS$SerumCortisol, IBS$CRP,  pch=16, color="steelblue", box="TRUE", highlight.3d=FALSE, type="h", main="BMI x Cortisol x CRP")
fit <- lm(SerumCortisol ~ BMI + CRP, data=IBS)
s3d$plane3d(fit)
