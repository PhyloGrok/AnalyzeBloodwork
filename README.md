<h1 align="center">
AnalyzeBloodwork</h1>
<h2 align="center">
with Machine Learning</h2>

![doi](../master/Images/zenodo.3373938.svg?sanitize=true)
#### Current functionality: ([AnalyzeBloodwork.R](scripts/AnalyzeBloodwork.R)) loads required packages and sample data, generates linear models and diagnostic plots for single and multiple regressions for variables including BMI, Complete Blood Count (CBC), and other blood-based biomarkers of inflammation.  Imputes data for columns with missing (NA) values, balances unequally-sized sample groups.

#### Sample Dataset:
Data from the sample dataset was collected during an NIH natural history clinical study of the relationship between obesity, inflammation, stress, and gastrointestinal disorders and is fully open-sourced (citations and links below).  

The <em>standard CBC parameters</em> provide point-of-care physicians with powerful diagnostic capabilities using: 
1) White Blood Cell counts (absolute and relative counts for Monocytes, Lymphocytes, Neutrophils, Basophils, and Eosinophils), 
2) Red blood cell and hemoglobin parameters (RBC count, Hematocrit (HCT), Mean Corpuscular Hemoglobin (MCH), Erythrocyte Sedimentation Rate (ESR)), 
3) Platelet parameters (Platelet Counts, Mean Platelet Volume (MPV))

Additional sample data in the context of obesity, inflammation, and gastrointestinal disorders includes:
1) Body Mass Index (BMI), 
2) Stress hormones: Cortisol and ACTH,
3) Inflammation markers: C-Reactive Protein (CRP), sCD14, Lipopolysaccharide Binding Protgin (LBP),
4) Clinical diagnoses of subtypes of Irritable Bowel Syndrome (IBS)
5) Nanostring White Blood Cell RNA expression data: an associated 250-gene panel of Nanostring RNA expression data (links in citations below).

This dataset and analyses are used by Robinson in teaching for UMBC's BTEC330 (Software Applications) and BTEC350 (Biostatistics) classes, students are trained in R programming language, GitHub practices, and analysis of clinical and molecular expression data by forking this repository and modifying it according to their skill level and assignment specifics.

The long-term research goal of this project is the automation of Machine Learning and regression models for biomarker discovery from CBC and gene-expression data. The repository is under continuous development, versions will be incremented with each new functional feature. 

## A. Linear model for Body Mass Index (BMI) vs. stress & inflammation biomarkers Serum Cortisol and C-Reactive Protein (CRP).
### Single linear regression: (BMI ~ Serum Cortisol), with scatterplot.
```
> BMI.Cortisol <- lm(BMI ~ SerumCortisol, data=IBS1)
> summary(BMI.Cortisol)

Call:
lm(formula = BMI ~ SerumCortisol, data = IBS1)

Residuals:
    Min      1Q  Median      3Q     Max 
-10.043  -4.043  -1.440   3.008  19.658 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept)    31.9454     1.4736  21.679  < 2e-16 ***
SerumCortisol  -0.5004     0.1312  -3.814 0.000229 ***
---
```
```
ggplot(IBS1, aes(x=BMI, y=SerumCortisol)) +
  geom_point() +    
  geom_smooth(method=lm) 
```
![BMI_Cortisol](../master/Images/CORTxBMI.png?sanitize=true)
##

### Multiple linear regression: (BMI ~ Serum Cortisol + C-Reactive Protein), with 3d-scatterplot. 
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
> s3d <- scatterplot3d(IBS1$BMI, IBS1$SerumCortisol, IBS$CRP,  pch=16, color="steelblue", box=TRUE, highlight.3d=FALSE, type="h", main="BMI, Cortisol, CRP")
> fit <- lm(SerumCortisol ~ BMI + CRP, data=IBS1)
> s3d$plane3d(fit)
```
![BMI_Cortisol_CRP_3d-scatterplot](../master/Images/MultipleRegression_3way.png?sanitize=true)

### Multiple linear regression: (BMI ~ Monocytes + Lymphocytes + Neutrophils + Basophils + Eosinophils). 

```
> fit <- lm(BMI ~ Monocytes + Lymphocytes + Neutrophils + Basophils + Eosinophils, data=CBC)
> summary(fit) # show results

Call:
lm(formula = BMI ~ Monocytes + Lymphocytes + Neutrophils + Basophils + 
    Eosinophils, data = CBC)

Residuals:
   Min     1Q Median     3Q    Max 
-8.780 -4.037 -1.732  4.062 18.030 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  22.4000     2.7445   8.162 1.02e-12 ***
Monocytes    -3.0891     4.1140  -0.751   0.4545    
Lymphocytes   2.7465     1.2745   2.155   0.0336 *  
Neutrophils   0.1459     0.4141   0.352   0.7254    
Basophils   -21.1991    41.1140  -0.516   0.6073    
Eosinophils   1.8739     5.4544   0.344   0.7319

> layout(matrix(c(1,2,3,4),2,2))
> plot(fit)
```

![BMI_vs White Blood Cells model fitting diagnostic plots](../master/fig_output/BMI_CBC_fit.png?sanitize=true)

### Literature Citations
Robinson, JM. et al. 2019. Complete blood count with differential: An effective diagnostic for IBS subtype in the context of BMI? BioRxiv. doi: https://doi.org/10.1101/608208.

Robinson, J. Differential Gene Expression Associated with BMI, Gender, and IBS-subtype in Human White Blood Cells: Results from a Custom 250-plex Nanostring Probe Panel. Preprints 2019, 2019120180 (doi: 10.20944/preprints201912.0180.v1).

Staser eta al. 2018. OMIP-042: 21-color flow cytometry to comprehensively immunophenotype major lymphocyte and myeloid subsets in human peripheral blood. Cytometry A. 93(2):186-189. DOI:10.1002/cyto.a.23303. 

### Nanostring source data: 
ImmunoGC custom Nanostring probe panel. 2019.  https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GPL25996. 

Human buffy coat gene expression, custom 250-plex Nanostring panel. GSE124549. 2019. https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE124549.  


### Adapted R source code:
[STHDA: ggplot2 histogram: easy histogram with ggplot2 R package](http://www.sthda.com/english/articles/40-regression-analysis/167-simple-linear-regression-in-r/)

[STHDA: Scatterplot3d: 3D graphics - R software and data visualization](http://www.sthda.com/english/wiki/scatterplot3d-3d-graphics-r-software-and-data-visualization)

[Quick R by DataCamp (StatMethods.net): Scatterplots](https://www.statmethods.net/graphs/scatterplot.html)

[MachineLearningMastery.com: Machine Learning in R Step-by-Step](https://machinelearningmastery.com/machine-learning-in-r-step-by-step/)

[R-Bloggers.com: Regression analysis essentials for machine learning](https://www.r-bloggers.com/2018/03/regression-analysis-essentials-for-machine-learning/)


