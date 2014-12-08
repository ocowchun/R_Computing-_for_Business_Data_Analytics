#Q1. Import the library AER in R, and attach the data set CPS1988.
# (a) Run the linear regression model below (using lm( )) and save the model as object “CPS_lm”.
# Note that the ethnicity is a categorical/dummy variable.

library("AER")
data("CPS1988")
attach(CPS1988)
experience2=experience*experience
CPS_lm=lm(log(wage)~experience+experience2+education+as.factor(ethnicity))



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

library(mvtnorm)
set.seed(121402)
# Create two correlated independent variables

n=1000
b0=0.2
b1=0.5
b2=0.75
simulate=function(n,mclvls){
	b1.sds=c()
	for(i in 1:length(mclvls)){
		mclvl=mclvls[i]
		b1.estimate=c()
		for(j in 1:10)
		{
			x.corr=matrix(c(1, mclvl, mclvl, 1), ncol=2)
			x=rmvnorm(n, mean=c(0, 0), sigma=x.corr) # n is the sample size 
			x1=x[ , 1]
			x2=x[, 2]
			y=b0+b1*x1+b2*x2+rnorm(n, 0, 1)
			lm(y~x1+x2)
			b1.estimate[j]=coef(lm(y~x1+x2))[2]
		}
		b1.sds[i]=sd(b1.estimate)
	}
	b1.sds
}

multicollinearity.plot=function(){
	mclvls= seq(0, 0.95, 0.05)
	b1.1000=simulate(1000,mclvls)
	b1.5000=simulate(5000,mclvls)

	plot(mclvls,seq(0,0.1,0.1/19),type='n',ylab='the corresponding standard deviation of b1')
	lines(mclvls,b1.1000,col='green')	
	lines(mclvls,b1.5000,col='red')	
}

multicollinearity.plot()

###(b) Omitted variable
library(mvtnorm)
set.seed(121402)
# Create two correlated independent variables
mclvls= c(0,0.5,1)

omitted.plot=function(n=1000){

	par.est=matrix(NA, nrow=n, ncol=3)

	for(j in 1:n)
	{

		for(i in 1:length(mclvls)){
			mclvl=mclvls[i]
			x.corr=matrix(c(1, mclvl, mclvl, 1), ncol=2)
			x=rmvnorm(n, mean=c(0, 0), sigma=x.corr) # n is the sample size 
			x1=x[ , 1]
			x2=x[, 2]
			y=b0+b1*x1+b2*x2+rnorm(n, 0, 1)
			model=lm(y~x1)
			par.est[j, i]=model$coef[2]

		}
	}
	par.est


	plot(c(min(par.est),max(par.est)),c(0,15),main="",lwd=2,xlab='b1',ylab='density',type='n')
	lines(density(par.est[,3]),col= 'green', lwd=3, lty=3)
	lines(density(par.est[,2]),col= 'red', lwd=2, lty=2)
	lines(density(par.est[,1]),col= 'black', lwd=1, lty=1)
	abline(v=b1,col='blue')

	legend(0.9,15,c("mclvl=0","mclvl=0.5","mclvl=1"), lty=c(1,2,3),lwd=c(1,2,3),bty="n",cex=1.1,col=c('black','red','green'))
}
omitted.plot()

# (c) Measurement error
measurement.plot=function(n=1000){
	errlvls=c(0,0.5,1)
	set.seed(385062)
	
	b0=0.2
	b1=0.5
	x=runif(n, -1, 1)
	par.est=matrix(NA, nrow=n, ncol=3)

	for(i in 1:length(errlvls)){
		errlvl=errlvls[i]
		xp=x+rnorm(n, 0, errlvl)
		for(j in 1:n){
			y=b0+b1*x+rnorm(n, 0, 1)
			model=lm(y~xp)
			par.est[j, i]=model$coef[2]
		}
	}
	par.est
	plot(c(min(par.est),max(par.est)),c(0,15),main="",lwd=2,xlab='b1',ylab='density',type='n')
	lines(density(par.est[,3]),col= 'green', lwd=3, lty=3)
	lines(density(par.est[,2]),col= 'red', lwd=2, lty=2)
	lines(density(par.est[,1]),col= 'black', lwd=1, lty=1)
	abline(v=b1,col='blue')

	legend(0.3,15,c("errlvl=0","errlvl=0.5","errlvl=1"), lty=c(1,2,3),lwd=c(1,2,3),bty="n",cex=1.1,col=c('black','red','green'))

}
measurement.plot()