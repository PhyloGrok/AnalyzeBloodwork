## Algorithm selection for predictive classification (Machine Learning with R and caret package)
### WBC counts as classifiers for IBS-subtype; which algorithms generate the best predictive model?

#### 1. Impute missing values by replacing 'NA' with column mean. 
```
> ## Generate list of columns with NA values
> list_na <- colnames(IBSblood)[ apply(IBSblood, 2, anyNA) ]
> list_na
[1] "Monocytes"
```
```
> # determine the mean of columns with missing NAs
> average_missing <- apply(as.matrix(IBSblood[,colnames(IBSblood) %in% list_na]), 
+                          2, 
+                          mean, 
+                          na.rm=TRUE)
> average_missing
[1] 0.4462963
```
```
> # Create a new imputed dataframe by replacing NAs with column means
> IBSblood.replacement <- IBSblood %>%
+   mutate(Monocytes = ifelse(is.na(Monocytes), average_missing[1], Monocytes))
> sum(is.na(IBSblood.replacement$Monocytes))
[1] 0
```

#### 2. Balance unequal groups by up-sampling using the groupdata2 package 

Pre-balancing, groups "Normal" "IBSC" and "IBSD" are unequal numbers:

```
> IBSblood %>%
+   count(IBS.subtype) %>%
+   kable(align = 'c')


| IBS.subtype | n  |
|:-----------:|:--:|
|    IBSC     | 19 |
|    IBSD     | 14 |
|    NORM     | 77 |

```
Post-balancing with up-sampling to 100 rows for each group:
```
> df_balanced %>%
+   count(IBS.subtype) %>%
+   kable(align = 'c')


| IBS.subtype |  n  |
|:-----------:|:---:|
|    IBSC     | 100 |
|    IBSD     | 100 |
|    NORM     | 100 |
```

#### 3. Generate fit models for 5 classification algorithms, with 10-fold cross-validation: 

```
> # Run algorithms using 10-fold cross validation
> control <- trainControl(method="cv", number=10)
> metric <- "Accuracy"
```
##### 1) Linear Discriminant Analysis (LDA) 
```
> set.seed(7) ## Seeds are set to 7 for all subsequent algorithms
> fit.lda <- train(IBS.subtype~., data=df_balanced, method="lda", metric=metric, trControl=control)
```
##### 2) Classification and Regression Trees (CART) 
```
> fit.cart <- train(IBS.subtype~., data=df_balanced, method="rpart", metric=metric, trControl=control)
```
##### 3) k-Nearest Neighbors (kNN)
```
> fit.knn <- train(IBS.subtype~., data=df_balanced, method="knn", metric=metric, trControl=control)
```
##### 4) Support Vector Machines (SVM) with a linear kernel 
```
> fit.svm <- train(IBS.subtype~., data=df_balanced, method="svmRadial", metric=metric, trControl=control)
```
##### 5) Random Forest (RF) 
```
> fit.rf <- train(IBS.subtype~., data=df_balanced, method="rf", metric=metric, trControl=control)
```

#### 4. Compare the predictive accuracy of the models: 
```
> # summarize accuracy of models
> results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf))
> # compare accuracy of models
> dotplot(results)
```
![Dotplot_ClassificationAccuracy](../fig_output/ClassificationSelection.png?sanitize=true)
