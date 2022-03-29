<h1 align=center> 
Analysis of Akimel O'otham (ie NIDDK dataset) 
</h1>  
<h2 align=center>with Python/Tensorflow</h2>

Brandon Lamotte
BTEC495, Spring 2022

Data from the Akimel O'otham dataset was collected from an NIH clinical study of the relationships between obesity, BMI, blood glucose, diastolic blood pressure, tricep fold thickness, serum insulin levels, family history of diabetes, number of times pregnant, age, and whether a person is diagnosed with type 2 diabetes or not. The study was conducted between 1965 and mid 1990s. These parameters can then be used to train a machine learning algorithm to diagnose a patient with diabetes using these data points.


This data set is from a study of Akimel O'otham people on the Gila River Indian Reservation in Arizona. Akimel O'otham means ("River People") and they are an indigenous people that used to live along the Gila, Salt, and Santa Cruz Rivers. The Pima name comes from the phrase "pi-nyi-match" which means "I don't know" and early Spanish colonists named the tribe this after the O'otham used it to answer the colonists questions. The O'otham mostly practiced communal living, farmed crops such as corn, squash, pumpkins, kindey beans, tobacco, cotton, and more with extensive agrcultural knowledge and irrigation and 500 miles of canal systems using the rivers as sources of water, and practiced hunting fishing and gathering. This meant they had a relatively low-calorie diet and because of the physical activity through farming, fishing, hunting, and gathering they were extremely fit. O'otham are also known for their intricate basket weaving even today which they used to hold various gathered crops. O'otham familial groups were also extended families and matrilocal so a daughter and her husband would live with the daughters' mother.


O'otham land started to be encroached on by Euro-American settlers after the Civil War which lead to the Gila River water being dammed and diverted for the settlers benefit and drying up the O'otham farmland which lead to mass famine and starvation. The US government then came in and gave out canned and processed foods and forced them from their ancestral lands to what is now the Gila River Indian Reservation just south of Phoenix, where today around 20,000 O'otham live. However, this is a mere sliver of thier original land which encompassed all of modern Phoenix and extended down to near what is now Tucson. This encroachment and forcible removal to reservation lead to their lives being dramatically altered and their diets and lifestyles changing dramatically from fresh crops to high-calorie processed foods and from hunting and gathering and active lifestyles to sedentary isolated lifestyles on the reservation. All of this lead to the O'otham developing extremely high type-2 diabetes and obesity levels. When compared to O'otham in Mexico for example, the Mexican O'otham only have slightly higher type-2 diabetes levels compared to non-O'otham in Mexico. This in stark contrast with the O'otham in America who have much higher levels compared to non-O'otham.
  
Using this data set we tested and trained various machine learning algorithms. Using linear regression, which is a supervised method we fitted BMI and trifold thickness data to a scatter plot. We then used Principal Component Analysis which is an unsupervised method to visualize the differences between people with a diabetes diagnosis and people without the diabetes diagnosis. Finally, we used Gausian Mixture Modeling an unsupervised method and imported the PCA data to cluster it to have a better understanding of the breakdown of people with diabetes vs without diabetes. 


| O'otham territory in 1700: |  Current O'otham territory: |  
| --- | --- |
| ![Oothamterritory1700](../Images/Oothamterritory1700.jpg?sanitize=true) | ![CurrentOothamreservation](../Images/GRIC.PNG?sanitize=true) |
|  (Trapido-Lurie & Minnis, 1996) | (Williams, 2015) |


| Portrait of an O'otham man from 1900: | Portrait of an O'otham woman: |
| --- | --- |
| ![Oothamman1900](../Images/Oothamman1900.jpg?sanitize=true) | ![Oothamwoman](../Images/Oothamwoman.jpg?sanitize=true) |
| (Curtis E.S., Kaviu - Pima 1907) | (Gila River Indian Community, 2015) |

| Photograph of O'otham men: | O'otham bowls and baskets: |
| --- | --- |
|![Ootham](../Images/Ootham.png?sanitize=true) | ![Oothambaskets](../Images/Oothambaskets.jpg?sanitize=true) |
| (Hall, 2015) | (Curtis E.S., Pima Baskets 1907) |

| Traditional O'otham house: | Another example of a traditional O'otham house with some bowls shown: |
| --- | --- |
| ![Oothamhouse](../Images/Oothamhouse.jpg?sanitize=true) | ![Oothamhouse2](../Images/Oothamhouse2.jpg?sanitize=true) |
| (Gila River Indian Community, 2015) | (Gila River Indian Community, 2015) |

```
%matplotlib inline
import seaborn as sns; sns.set()
sns.pairplot(iris, hue='species', size=1.5);
```

| Overall parameters of the data set: | Scatter plot matrix showing each data points relation to eachother: |
| --- | --- |
| ![Akimel_Dataset](../Images/data_set.png?sanitize=true) | ![Scatterplot_Matrix](../Images/scatterplot_matrix.png?sanitize=true) |

```
df.plot.scatter(x ='BMI', y = 'Tri Fold Thick')
```

```
## Linear Regression

from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt
model = LinearRegression(fit_intercept=True)

x = df['BMI']
y = df['Tri Fold Thick']

model.fit(x[:, np.newaxis], y)

xfit = np.linspace(5, 70)
yfit = model.predict(xfit[:, np.newaxis])
```

```
plt.scatter(x, y, c = "red", s = 15)
plt.plot(xfit, yfit, color='black');
plt.xlabel("BMI")
plt.ylabel("Tricep Fold Thickness (cm)")
```
| Graph showcasing the linear relationship between BMI and tricep fold thickness levels with a line of best fit: | Scatterplot of BMI and Tri Fold Thickness |
| --- | --- |
| ![BMITrifoldFitted](../Images/bmitrifoldfitted.PNG?sanitize=true) | ![BMI_Trifold](../Images/bmi_trifold.png?sanitize=true) </h2>
  

<h2> 
Citations: </h2>
 
Bock, E. (2020, July 23). Medical history matters in Era of Big Data. National Institutes of Health. Retrieved March 12, 2022, from https://nihrecord.nih.gov/2020/07/24/medical-history-matters-era-big-data

Butt, U. M., Letchmunan, S., Ali, M., Hassan, F. H., Baqir, A., & Sherazi, H. (2021). Machine Learning Based Diabetes Classification and Prediction for Healthcare Applications. Journal of healthcare engineering, 2021, 9930985. https://doi.org/10.1155/2021/9930985

Curtis, E. S. (1907). Kaviu - Pima. Library of Congress. Library of Congress. Retrieved March 16, 2022, from http://memory.loc.gov/award/iencurt/cp02/cp02003v.jpg.

Curtis, E. S. (1907). Pima Baskets. Library of Congress. Library of Congress. Retrieved March 16, 2022, from http://memory.loc.gov/award/iencurt/cp02/cp02002v.jpg.

Gila River Indian Community. (2015). History. Gila River Indian Community. Retrieved March 12, 2022, from https://www.gilariver.org/index.php/about/history#0

Hall, B. (2015, June 15). Indian wars in Phoenix, Arizona. History Adventuring. Retrieved March 25, 2022, from http://www.historyadventuring.com/2015/06/indian-wars-in-phoenix-arizona.html 

Trapido-Lurie, B., &amp; Minnis, D. (1996). Pima Territory, 1700. Arizona Geographic Alliance. Arizona State University. Retrieved March 16, 2022, from http://geoalliance.asu.edu/sites/default/files/maps/PIMA.pdf. 

Waldman, C. (2006). Akimel O'odham (Pima). In Encyclopedia of Native American tribes (pp. 4–6). section, Checkmark Books.
  
Williams, L. (2015). Map of Ambient Air Monitoring Stations on Gila River Indian Community. Gila River Indian Community Department of Environmental Quality. Retrieved March 16, 2022, from https://www.gricdeq.org/view/download.php/air-quality-program/monitoring/2014-ambient-air-monitoring-network-review. 

Schulz, L. O., & Chaudhari, L. S. (2015). High-Risk Populations: The Pimas of Arizona and Mexico. Current obesity reports, 4(1), 92–98. https://doi.org/10.1007/s13679-014-0132-9

Smith, J. W., Everhart, J. E., Dickson, W. C., Knowler, W. C., & Johannes, R. S. (1988). Using the ADAP Learning Algorithm to Forecast the Onset of Diabetes Mellitus. Proceedings of the Annual Symposium on Computer Application in Medical Care, 261–265.


<h2> Further reading: </h2>

DeJong, D. H. (2011). Forced to Abandon Our Fields: The 1914 Clay Southworth Gila River Pima Interviews. University of Utah Press.

Nabhan, G. P. (1985). Gathering the Desert. University of Arizona Press.
  
Shaw, A. M. (1994). A Pima Past. The University of Arizona Press.
  
Smith-Morris, C. (2007). Diabetes among the Pima: Stories of survival. University of Arizona Press.


