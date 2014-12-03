##Q1. Import the library AER in R, and attach the data set CPS1988.
###(a) Run the linear regression model below (using lm( )) and save the model as object “CPS_lm”.Note that the ethnicity is a categorical/dummy variable.

```r
# library("AER")
# data("CPS1988")
# attach(CPS1988)
experience2=experience*experience
CPS_lm=lm(log(wage)~experience+experience2+education+as.factor(ethnicity))
```

###(b) Explain the results in detail. What is the statistical significance of each independent variable? What are the implications of the findings? Particularly, what is the association between wage and experience? Is the identified association linear? If not, what is the shape of the association?

####What is the statistical significance of each independent variable?
experience,$expreience^2$,education,ethnicity的p-value都小於0.001,因此這幾個獨立變數都是統計顯著。

####What are the implications of the findings? Particularly, what is the association between wage and experience?
wage與experience,$expreience^2$,education,ethnicity都是指數成長的關係,其中experience,education對wage都是正面的影響,$expreience^2$則是負面影響,
ethnicity為afam的話,wage成長的幅度會比較小。
experience越大,wage越大,兩者呈指數成長。

####Is the identified association linear?
no,log(wage)與獨立變數之間是線性關係,所以wage與獨立變數之間不是線性
####If not, what is the shape of the association?
指數關係


###(c) Based on the estimated coefficients, write out the two equations of predictive models for Africa-American and Caucasian respectively.
$\beta_0=4.321395,\beta_1=0.077473,\beta_2=-0.001316,\beta_3=0.085673,\beta_4=-0.243364$

$if ethnicity =Africa\,American:\\
\large wage=e^{4.078031+0.077473*experience-0.001316*experience^2+0.085673*education}$

$if ethnicity =Caucasian:\\
\large wage=e^{4.321395+0.077473*experience-0.001316*experience^2+0.085673*education}$
