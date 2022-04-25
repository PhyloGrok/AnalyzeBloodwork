## Reference code: http://www.sthda.com/english/wiki/descriptive-statistics-and-graphics

## 1. Import the data:
##Package
install.packages('dplyr')
instal.packages("tidyverse")
library(dplyr)
library(ggplot2)
##Importing raw data from Github:
cardio_data <- read.csv("https://raw.githubusercontent.com/PhyloGrok/AnalyzeBloodwork/master/data/Cardio.csv")
#View(cardio_data)    #uncomment to view

## 2. Make some observations (descriptive statistics) , Mean, Median, SD, Print out a table of the summary stastistics
##Create a sub table of continuous data
cont_data <- select(cardio_data, age, BP, cholesterol,maxHR,peak,BP.1)
##Summary table: Mean, Median, SD
cont_data <- lapply(cont_data,as.numeric)
sum_table <- data.frame(
    Mean = sapply(cont_data,mean),
    Median = sapply(cont_data,median),
    Variance = sapply(cont_data,var),
    SD = sapply(cont_data,sd)
)
#View(sum_table)   #uncomment to view

## 3. Print out Histograms for the continuous data
#Age
ggplot(cardio_data, aes(x=age))+
    geom_histogram(color = "black", fill = "white", bins = 12)+
    labs(x="Age", title = "Age Distribution")
#BP
ggplot(cardio_data, aes(x=BP))+
    geom_histogram(color = "black", fill = "white", bins = 12)+
    labs(x="Blood Pressure (mmHg)", title = "Blood Pressure")
#Cholesterol
ggplot(cardio_data, aes(x=cholesterol))+
    geom_histogram(color = "black", fill = "white", bins = 12)+
    labs(x="Cholesterol level (mg/dL)", title = "Cholesterol")
#Max HR
ggplot(cardio_data, aes(x=maxHR))+
    geom_histogram(color = "black", fill = "white", bins = 12)+
    labs(x="Maximum Heart Rate (bpm)", title = "Maximum Heart Rate")
#Peak
ggplot(cardio_data, aes(x=peak))+
    geom_histogram(color = "black", fill = "white", bins = 12)+
    labs(x="Peak", title = "Peak")
#BP.1
ggplot(cardio_data, aes(x=BP.1))+
    geom_histogram(color = "black", fill = "white", bins = 12)+
    labs(x="Blood Pressure (mmHg)", title = "Blood Pressure.1")

## 4. Hypothesis testing (T-tests)
#in process
