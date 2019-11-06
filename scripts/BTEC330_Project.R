
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

## Output the results to a file
## http://www.cookbook-r.com/Data_input_and_output/Writing_text_and_output_from_analyses_to_a_file/
sink('data_output/LDH_regression.txt', append = TRUE)
print(LDH.regression)
sink()

## ANOVA: IBS-subtype vs. Bloodwork parameter
## http://www.sthda.com/english/wiki/one-way-anova-test-in-r
LDH.aov <- aov(LDH ~ IBS.subtype, data = IBS)
summary(LDH.aov)
sink('data_output/LDH_anova.txt', append = TRUE)
print(LDH.aov)
sink()

## Print scatterplot and box plots as .png files into "fig_output" project directory.
## http://www.sthda.com/english/wiki/ggsave-save-a-ggplot-r-software-and-data-visualization

## Scatterplots
## https://www.statmethods.net/graphs/scatterplot.html

ggplot(IBS, aes(x = BMI, y = LDH)) +
  geom_point() +    
  geom_smooth(method = lm) 

png("fig_output/LDH_scatterplot.png")
LDH_scatterplot <- ggplot(IBS, aes(x = BMI, y = LDH)) +
  geom_point() +    
  geom_smooth(method = lm) 
       )
print(LDH_scatterplot)
dev.off()

## Box plots
## https://www.statmethods.net/graphs/boxplot.html

png("fig_output/LDH_boxplot.png")
LDH_boxplot <- boxplot(LDH ~ IBS.subtype, data = IBS, main="LDH by IBS subtype", 
       xlab = "IBS.subtype", ylab = "LDH"
       )
print(LDH_boxplot)
dev.off()



