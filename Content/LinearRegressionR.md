<h1>Linear regression in R examples: </h1>
#### a. Linear model with Body Mass Index (BMI), Serum Cortisol and C-Reactive Protein (CRP) (stress & inflammation biomarkers).
#### b. Linear model with BMI and White Blood Cells (absolute counts WBCs, Neutrophils, Monocytes, Lymphocytes, Eosinophils, Basophils)

Regressions follow the canonical form:
![BMI_Cortisol](../Images/linearmodel.png?sanitize=true)

In R language this is expressed as:
<em>lm(y ~ x1 + x2 + xn, data=dataframe)</em>

### 1. Single linear regression: (BMI ~ Serum Cortisol), with scatterplot.
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
![BMI_Cortisol](../Images/CORTxBMI.png?sanitize=true)
##

### 2. Multiple linear regression: (BMI ~ Serum Cortisol + C-Reactive Protein), with 3d-scatterplot. 
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
![BMI_Cortisol_CRP_3d-scatterplot](../Images/MultipleRegression_3way.png?sanitize=true)

### 3. Multiple linear regression for BMI and White Blood Cells (WBCs): 
#### (BMI ~ Monocytes + Lymphocytes + Neutrophils + Basophils + Eosinophils). 

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

![BMI_vs White Blood Cells model fitting diagnostic plots](../fig_output/BMI_CBC_fit.png?sanitize=true)
