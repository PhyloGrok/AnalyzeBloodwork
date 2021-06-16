<h1 align="center">
AnalyzeBloodwork</h1>
<h2 align="center">
with base R</h2>

![doi](../master/Images/zenodo.3373938.svg?sanitize=true)

This repository is maintained by Dr. Jeffrey Robinson, course developer and instructor for the courses BTEC330 "Software Applications in the Life Sciences", and BTEC350 "Biostatistics", in the UMBC Translational Life Science Technology (TLST) Bachelor of Science Program.  The analyses are based upon published and publicly available data from the pre-prints and database accessions cited below. 

For these classes, students train in R programming language, GitHub practices, and analysis of clinical and molecular expression data by forking this repository and modifying it according to their skill level and assignment specifics.

The long-term research goal of this project is the automation of Machine Learning and regression models for biomarker discovery from CBC and gene-expression data. The repository is under continuous development, versions will be incremented with each new functional feature. 

#### Current functionality: The included R-script performs single and multiple regressions, and generates histograms and scatterplots for Complete Blood Count (CBC-D).

([AnalyzeBloodwork.R](../master/AnalyzeBloodwork.R)) automatically loads required libraries, imports the sample .csv with patient data, generates histograms for each parameter, and performs single and multiple regressions.

The standard CBC parameters provide point-of-care physicians with powerful diagnostic capabilities using: 

1) White Blood Cell counts (absolute and relative counts for Monocytes, Lymphocytes, Neutrophils, Basophils, and Eosinophils), 
2) Red blood cell and hemoglobin parameters (RBC count, Hematocrit (HCT), Mean Corpuscular Hemoglobin (MCH), Erythrocyte Sedimentation Rate (ESR)), 
3) Platelet parameters (Platelet Counts, Mean Platelet Volume (MPV))

Furthermore, the sample dataset was collected during an NIH natural history clinical study of the relationship between obesity, inflammation, stress, and gastrointestinal disorders.  An associated 250-gene panel of Nanostring RNA expression data from white blood cells is also available (links in citations below).

of Body Mass Index (BMI) vs. variables from the Complete Blood Count with Differential (CBC-D) test results, and produce 2-D and 3-D scatterplots for the results.  The data provided is from an NIH Clinical Research Center study investigating molecular and physiological biomarkers in white blood cells associated with obesity, chronic abdominal pain, and inflammation.  








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

### Citations
Robinson, JM. et al. 2019. Complete blood count with differential: An effective diagnostic for IBS subtype in the context of BMI? BioRxiv. doi: https://doi.org/10.1101/608208.

Staser eta al. 2018. OMIP-042: 21-color flow cytometry to comprehensively immunophenotype major lymphocyte and myeloid subsets in human peripheral blood. Cytometry A. 93(2):186-189. DOI:10.1002/cyto.a.23303. 

### Nanostring source data: 
ImmunoGC custom Nanostring probe panel. 2019.  https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GPL25996. 

Human buffy coat gene expression, custom 250-plex Nanostring panel. GSE124549. 2019. https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE124549.  


### R source code adapted for the project:
[STHDA: ggplot2 histogram: easy histogram with ggplot2 R package](http://www.sthda.com/english/articles/40-regression-analysis/167-simple-linear-regression-in-r/)

[STHDA: Scatterplot3d: 3D graphics - R software and data visualization](http://www.sthda.com/english/wiki/scatterplot3d-3d-graphics-r-software-and-data-visualization)

[Quick R by DataCamp (StatMethods.net): Scatterplots](https://www.statmethods.net/graphs/scatterplot.html)
