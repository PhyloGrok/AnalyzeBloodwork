## AnalyzeBloodwork
![doi](../master/Images/zenodo.3373938.svg?sanitize=true)
### Single and multiple regressions, and scatterplots for clinical bloodwork and gene expression data.
### The R code and dataset are used in the UMBC courses BTEC330 and BTEC395 for training students in R coding, GitHub practices, and analysis of clinical and molecular expression data.  Each student has forked this repository and modified for analysis of a single parameter from the Complete Blood Count w/ Differential (CBC-D) results.
([AnalyzeBloodwork.R](../master/AnalyzeBloodwork.R)) will allow you to load a comma-delimited .csv with various datapoints, perform single and multiple regressions of Body Mass Index (BMI) vs. variables from the Complete Blood Count with Differential (CBC-D) results, and produce 2-D and 3-D scatterplots for the results.  The data provided is from an NIH Clinical Research Center study investigating molecular and physiological biomarkers associated with obesity, chronic abdominal pain, and inflammation.  

Data (RobinsonEtAl_Sup1.csv) is publicly available from the following sources: 

Robinson, JM. et al. 2019. Complete blood count with differential: An effective diagnostic for IBS subtype in the context of BMI? BioRxiv. doi: https://doi.org/10.1101/608208.

ImmunoGC custom Nanostring probe panel. 2019.  https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GPL25996. 

Human buffy coat gene expression, custom 250-plex Nanostring panel. GSE124549. 2019. https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE124549.  

##
### Results of single regression, BMI x Serum Cortisol
```
> single.regression <- lm(BMI ~ SerumCortisol, data=IBS1)
> print(single.regression)

Call:
lm(formula = BMI ~ SerumCortisol, data = IBS1)

Coefficients:
  (Intercept)  SerumCortisol  
      31.9454        -0.5004  
```
```
ggplot(IBS1, aes(x=BMI, y=SerumCortisol)) +
  geom_point() +    
  geom_smooth(method=lm) 
```
![BMI_Cortisol](../master/Images/CORTxBMI.png?sanitize=true)
##
### Results of single regression, BMI x C-Reactive Protein (CRP)
```
> single.regression <- lm(BMI ~ CRP, data=IBS1)
> print(single.regression)

Call:
lm(formula = BMI ~ SerumCortisol + CRP, data = IBS1)

Coefficients:
  (Intercept)  SerumCortisol            CRP  
      30.7936        -0.5231         0.6042  

```

![BMI_CRP](../master/Images/BMIxCRP.png?sanitize=true)
##
##
### Results of multiple regression, BMI x Serum Cortisol + C-Reactive Protein (CRP)
```
> fit1 <- lm(BMI ~ SerumCortisol + CRP, data=IBS1)
> summary(fit1)

Call:
lm(formula = BMI ~ SerumCortisol + CRP, data = IBS1)

Residuals:
    Min      1Q  Median      3Q     Max 
-9.1378 -3.4448 -0.9904  2.3330 20.6056 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept)    30.7936     1.4134  21.787  < 2e-16 ***
SerumCortisol  -0.5231     0.1233  -4.244 4.72e-05 ***
CRP             0.6042     0.1534   3.938 0.000147 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 5.354 on 106 degrees of freedom
  (2 observations deleted due to missingness)
Multiple R-squared:  0.232,	Adjusted R-squared:  0.2175 
F-statistic: 16.01 on 2 and 106 DF,  p-value: 8.388e-07
```
```
s3d <- scatterplot3d(IBS$BMI, IBS$SerumCortisol, IBS$CRP,  pch=16, color="steelblue", box="TRUE", highlight.3d=FALSE, type="h", main="BMI x Cortisol x CRP")
fit <- lm(SerumCortisol ~ BMI + CRP, data=IBS)
s3d$plane3d(fit)
```
![BMI_Cortisol_CRP_3d-scatterplot](../master/Images/MultipleRegression_3way.png?sanitize=true)
##
