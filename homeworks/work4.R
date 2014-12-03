#Q1. Import the library AER in R, and attach the data set CPS1988.
# (a) Run the linear regression model below (using lm( )) and save the model as object “CPS_lm”.
# Note that the ethnicity is a categorical/dummy variable.

# library("AER")
# data("CPS1988")
# attach(CPS1988)
experience2=experience*experience
CPS_lm=lm(log(wage)~experience+experience2+education+as.factor(ethnicity))

# (b) Explain the results in detail. What is the statistical significance of each independent variable? 
# What are the implications of the findings? Particularly, what is the association between wage and experience? 
# Is the identified association linear? If not, what is the shape of the association?

# (c) Based on the estimated coefficients, write out the two equations of predictive models for Africa-American
 # and Caucasian respectively.


#Q2. Monte-Carlo simulation experiments of linear regression (OLS)
# Run the following codes in R
# library(mvtnorm)
# set.seed(121402)
# mclvl= seq(0, 0.95, 0.05)
# # Create two correlated independent variables
# x.corr=matrix(c(1, mclvl, mclvl, 1), ncol=2)
# # x=rmvnorm(n, mean=c(0, 0), sigma=x.corr) # n is the sample size 
# # x1=x[ , 1]
# # x2=x[, 2]

# (a) Multicollinearity
# The mclvl refers to the level of collinearity between x1 and x2.
 # Set n=1000, and for each mclvl in seq(0, 0.95, 0.05) simulate the dependent variable using
# y=b0+b1*x1+b2*x2+rnorm(n, 0, 1) #set b0=0.2; b1=0.5; b2=0.75
# Estimate b1 from lm(y~x1+x2).
 # Repeat the estimation for 1000 times and calculate the standard deviation of those 1000 estimated b1 (for a given mclvl).
# Do the whole simulation again with n=5000 and save the standard deviation of estimated b1.
# For n=1000 and n=5000, generate a plot (respectively) where the x-axis is mclvl and 
# the y-axis is the corresponding standard deviation of b1. Discuss what you find.

# library(mvtnorm)
# set.seed(121402)
# # Create two correlated independent variables


# n=1000
# b0=0.2
# b1=0.5
# b2=0.75
# mclvls= seq(0, 0.95, 0.05)

# simulate=function(n){

# 	b1.sds=c()
# 	for(i in 1:length(mclvls)){
# 		mclvl=mclvls[i]
# 		b1.estimate=c()
# 		for(j in 1:1000)
# 		{
# 			x.corr=matrix(c(1, mclvl, mclvl, 1), ncol=2)
# 			x=rmvnorm(n, mean=c(0, 0), sigma=x.corr) # n is the sample size 
# 			x1=x[ , 1]
# 			x2=x[, 2]
# 			y=b0+b1*x1+b2*x2+rnorm(n, 0, 1)
# 			lm(y~x1+x2)
# 			b1.estimate[j]=coef(lm(y~x1+x2))[2]
# 		}
# 		b1.sds[i]=sd(b1.estimate)
# 	}
# 	b1.sds
# }

# b1.1000=simulate(1000)
# b1.5000=simulate(5000)

# # c( 0.03105775,0.03187844,0.03134528,0.03060289,0.03073419,0.03117804,0.03034489,0.03144453,0.03095313,0.03132244,0.02980386,0.03178032,0.02981876,0.03067123,0.03068498,0.03095199,0.03009171,0.03177161,0.03152608,0.03132736)
# plot(mclvls,b1.1000,type='l')
# lines(mclvls,b1.5000,col='red')	



# practice
# kidiq=read.dta("/Users/ocowchun/Dropbox/nccu/R_Computing _for_Business_Data_Analytics/1111/kidiq.dta",convert.underscore=T)
# fit.1=lm(kid.score ~ mom.hs + mom.iq)

# plot(mom.iq, kid.score, xlab= "Mother IQ", ylab= "Child test score", pch=20)
# curve(cbind(1, 1, x, 1*x) %*% coef(fit.2), add=T, col= "red")
# curve(cbind(1, 0, x, 0*x) %*% coef(fit.2), add=T, col= "green")