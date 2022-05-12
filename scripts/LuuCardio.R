## Reference code: http://www.sthda.com/english/wiki/descriptive-statistics-and-graphics

## 1. Import the data:

##Installing Packages
install.packages('dplyr')
instal.packages("tidyverse")

##Load library
library(dplyr)
library(ggplot2)

##Importing raw data from Github:
cardio_data_raw <- read.csv("https://raw.githubusercontent.com/PhyloGrok/AnalyzeBloodwork/master/data/Cardio.csv")
# View(cardio_data_raw)    #uncomment to view

#Refer to another name to preserve the original data-set:
cardio_data <- cardio_data_raw
# View(cardio_data)

# Transform categorical variable to R factors
cardio_data$sex <- as.factor(cardio_data$sex)
cardio_data$chest_pain_type <- as.factor(cardio_data$chest_pain_type)
cardio_data$PG_fasting <- as.factor(cardio_data$PG_fasting)
cardio_data$ECG_rest <- as.factor(cardio_data$ECG_rest)
cardio_data$angina <- as.factor(cardio_data$angina)
cardio_data$slope <- as.factor(cardio_data$slope)
cardio_data$thal <- as.factor(cardio_data$thal)
cardio_data$class <- as.factor(cardio_data$class)


# Define levels for categorical values
levels(cardio_data$sex) <- c("Female", "Male")
levels(cardio_data$chest_pain_type) <- c("Asymptomatic", "Abnormal Angina", "Angina", "NoTang")
levels(cardio_data$PG_fasting) <- c("No", "Yes")
levels(cardio_data$ECG_rest) <- c("Adnormal", "Hyp", "Normal")
levels(cardio_data$angina) <- c("No", "Yes")
levels(cardio_data$slope) <- c("Down", "Flat", "Up")
levels(cardio_data$thal) <- c("Fix", "Normal", "Rev")
levels(cardio_data$class) <- c("Healthy", "Sick")


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
# View(sum_table)   #uncomment to view

## 3. Print out Histograms for the continuous data
#Age
ggplot(cardio_data, aes(x=age))+
    geom_histogram(color = "black", fill = "green", bins = 12)+
    labs(x="Age", title = "Age Distribution")
#BP
ggplot(cardio_data, aes(x=BP))+
    geom_histogram(color = "black", fill = "green", bins = 12)+
    labs(x="Blood Pressure (mmHg)", title = "Blood Pressure")
#Cholesterol
ggplot(cardio_data, aes(x=cholesterol))+
    geom_histogram(color = "black", fill = "green", bins = 12)+
    labs(x="Cholesterol level (mg/dL)", title = "Cholesterol")
#Max HR
ggplot(cardio_data, aes(x=maxHR))+
    geom_histogram(color = "black", fill = "green", bins = 12)+
    labs(x="Maximum Heart Rate (bpm)", title = "Maximum Heart Rate")
#Peak
ggplot(cardio_data, aes(x=peak))+
    geom_histogram(color = "black", fill = "green", bins = 12)+
    labs(x="Peak", title = "Peak")
#BP.1
ggplot(cardio_data, aes(x=BP.1))+
    geom_histogram(color = "black", fill = "green", bins = 12)+
    labs(x="Blood Pressure (mmHg)", title = "Blood Pressure.1")

## 4. Print out Histograms for the categorical data
#Class (healthy and sick)
ggplot(cardio_data, aes(class, fill=class)) + 
    geom_bar() +
    labs(x="Disease", y="Number of patients",
         title = "Healthy or Sick Individuals") +
    scale_fill_discrete(name = "Class")

#Sex
ggplot(cardio_data, aes(sex, fill=sex)) + 
    geom_bar() +
    labs(x="Sex", y="Number of patients",
         title = "Gender (Male or Female)") +
    scale_fill_discrete(name = "Gender")

#chest_pain_type:
ggplot(cardio_data, aes(chest_pain_type, fill=chest_pain_type)) + 
    geom_bar() +
    labs(x="Chest Pain Type", y="Number of patients",
         title = "Chest Pain Type") +
    scale_fill_discrete(name = "Type")

#PG_fasting
ggplot(cardio_data, aes(PG_fasting, fill=PG_fasting)) + 
    geom_bar() +
    labs(x="PG Fasting", y="Number of patients",
         title = "Plasma Glucose Fasting") +
    scale_fill_discrete(name = "Fasting")

#ECG_rest
ggplot(cardio_data, aes(ECG_rest, fill=ECG_rest)) + 
    geom_bar() +
    labs(x="ECG rest", y="Number of patients",
         title = "Electrocardiogram on rest") +
    scale_fill_discrete(name = "ECG rest")

#Thal
ggplot(cardio_data, aes(thal, fill=thal)) + 
    geom_bar() +
    labs(x="Thalach", y="Number of patients",
         title = "Maximum heart rate achieved (thalach)") +
    scale_fill_discrete(name = "Thalach")

#Angina
ggplot(cardio_data, aes(angina, fill=angina)) + 
    geom_bar() +
    labs(x="Angina", y="Number of patients",
         title = "Angina chest pain") +
    scale_fill_discrete(name = "Angina")

#slope
ggplot(cardio_data, aes(slope, fill=slope)) + 
    geom_bar() +
    labs(x="Slope", y="Number of patients",
         title = "Slope of ST Segment") +
    scale_fill_discrete(name = "Slope")

##Essentially, we do not want to just look at each categorical data, but we want to compare them
##Here, I will compare data with Healthy/Sick status

######Add ' position = "fill" ' in geom_bar() if want to see 2 column for each, otherwise they are stacked

#Gender vs Class (Healthy/Sick)
ggplot(cardio_data, aes(sex, fill=class)) + 
    geom_bar() +
    labs(fill="Disease", x="Gender", y="Number of patients",
         title = "Gender (F/M) vs. Class (Healthy/Sick)")

#Age vs Class (Healthy/Sick)
ggplot(cardio_data, aes(age, fill=class)) + 
    geom_bar() +
    labs(fill="Disease", x="Age", y="Number of patients",
         title = "Age vs. Class (Healthy/Sick)")


#chest pain type vs Class (Healthy/Sick)
ggplot(cardio_data, aes(chest_pain_type, fill=class)) + 
    geom_bar() +
    labs(fill="Disease", x="Age", y="Number of patients",
         title = "Chest paint type vs. Class (Healthy/Sick)")

#chest pain type vs Class (Healthy/Sick)
ggplot(cardio_data, aes(ECG_rest, fill=class)) + 
    geom_bar() +
    labs(fill="Disease", x="ECG Rest", y="Number of patients",
         title = "Electrocardiogram on rest vs. Class (Healthy/Sick)")

#thalach vs Class (Healthy/Sick)
ggplot(cardio_data, aes(thal, fill=class)) + 
    geom_bar() +
    labs(fill="Disease", x="Thalach", y="Number of patients",
         title = "Maximum heart rate achieved vs. Class (Healthy/Sick)")

#Slope vs Class (Healthy/Sick)
ggplot(cardio_data, aes(slope, fill=class)) + 
    geom_bar() +
    labs(fill="Disease", x="Slope", y="Number of patients",
         title = "Slope of ST Segment vs. Class (Healthy/Sick)")
#Slope vs Class vs Peak
ggplot(cardio_data, aes(x=slope, y=peak, fill=class)) +
    geom_boxplot() +
    labs(fill="Disease", x="Slope of ST segment", y="Depression of ST segment")


## Hypothesis testing (T-tests)
#in process
