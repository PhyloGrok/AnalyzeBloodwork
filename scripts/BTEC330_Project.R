
## BTEC330 F2019 Project2 Robinson

## Install necessary packages
install.packages("ggplot2")
library(ggplot2)

## Read data
IBS <- read.csv("data/RobinsonEtAl_Sup1.csv", header = TRUE)
head(IBS)
write.csv(IBS, "data_output/LDH.csv")

##  Single Regressions 
##  Data obtained from Robinson, et al. 2019 (doi: https://doi.org/10.1101/608208)
##  https://statquest.org/2017/10/30/statquest-multiple-regression-in-r/
##  http://www.sthda.com/english/articles/40-regression-analysis/167-simple-linear-regression-in-r/
##  http://r-statistics.co/Linear-Regression.html

## Single Regression Test, BMI vs. Bloodwork parameter
LDH.regression <- lm(BMI ~ LDH, data = IBS)
summary(LDH.regression)

## Scatterplots
## https://www.statmethods.net/graphs/scatterplot.html

ggplot(IBS1, aes(x = BMI, y = LDH)) +
  geom_point() +    
  geom_smooth(method = lm) 

## ANOVA Tests IBS-subtypes vs. Bloodwork parameter
## http://www.sthda.com/english/wiki/one-way-anova-test-in-r
LDH.aov <- aov(LDH ~ IBS.subtype, data = IBS)
summary(LDH.aov)

## Box plots
## https://www.statmethods.net/graphs/boxplot.html
boxplot(LDH ~ IBS.subtype, data = IBS, main="LDH by IBS subtype", 
       xlab = "IBS.subtype", ylab = "LDH"
       )

## Print .png files of images into "Fig_output" projects directory.
##http://www.sthda.com/english/wiki/ggsave-save-a-ggplot-r-software-and-data-visualization

