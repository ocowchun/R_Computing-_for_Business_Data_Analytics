#6.1
data()
# attach(cars) 一次就好了
plot(cars)
#
L1=lm(dist~speed)
summary(L1)
#
errorMSE=function(par){
         obj=0
         for(i in 1:nrow(cars)){
             obj=(dist[i]-(par[1]+par[2]*speed[i]))^2+obj
         }
         obj
}
#
nlminb(c(-5,1),errorMSE)
#
errorMLE=function(par){
         loglik=0
         for(i in 1:nrow(cars)){
             loglik=dnorm(dist[i],(par[1]+par[2]*speed[i]),par[3],log=T)+loglik
         }
         -loglik
}
#
nlminb(c(-5,1,2),errorMLE,lower=c(-Inf,-Inf,1e-5))
#
#Bootstrapping
n=nrow(cars)
S=500
betas=c()
for(s in 1:S){
    new=sample(1:n,size=n,replace=TRUE)
    boot.speed=speed[new]
    boot.dist=dist[new]
    boot.fit=lm(boot.dist~boot.speed)
    betas[s]=coef(boot.fit)[2]
}
hist(betas)
c(mean(betas),sd(betas))
c(quantile(betas,0.025),quantile(betas,0.975))
#
confint(L1)
#
res=residuals(L1)
mean(res)
yhat=fitted(L1)
plot(yhat,res)
plot(L1,which=1)
#
L2=lm(dist~0+speed)
summary(L2)
#
L3=lm(dist~0+speed+I(speed^2))
plot(cars)
abline(L1)
abline(L2,col='red',lwd=2,lty=2)
#abline(L3,col='blue',lwd=2,lty=3)
curve(1.239*x+0.090*x^2,add=T,col='blue',lwd=2,lty=3)


#6.2
set.seed(123)
b0=0.2
b1=0.5
n=1000
x=runif(n, -1, 1)
S=500
par.est=matrix(NA, nrow=S, ncol=4)
for(s in 1:S){
    y=b0+b1*x+rnorm(n, 0, 1)
    model=lm(y ~ x)
    vcv=vcov(model)
    par.est[s, 1]=model$coef[1]
    par.est[s, 2]=model$coef[2]
    par.est[s, 3]=sqrt(diag(vcv)[1])
    par.est[s, 4]=sqrt(diag(vcv)[2])
}
dev.new(width=12, height=5)
par(mfrow=c(1,2))
hist(par.est[,1])
abline(v=b0,col='red',lwd=2)
hist(par.est[,2])
abline(v=b1,col='red',lwd=2)
#
sd.beta0=sd(par.est[,1])
mean.se.beta0=mean(par.est[,3])
sd.beta1=sd(par.est[,2])
mean.se.beta1=mean(par.est[,4])
#
lower.beta0=par.est[ ,1]-qt(0.975, df=n-2)*par.est[,3]
upper.beta0=par.est[ ,1]+qt(0.975, df=n-2)*par.est[,3]

lower.beta1=par.est[ ,2]-qt(0.975, df=n-2)*par.est[,4]
upper.beta1=par.est[ ,2]+qt(0.975, df=n-2)*par.est[,4]

trueinCI.beta0=ifelse(b0>= lower.beta0 & b0 <=upper.beta0, 1, 0)
trueinCI.beta1=ifelse(b1>= lower.beta1 & b1 <=upper.beta1, 1, 0)

cover.beta0=mean(trueinCI.beta0)
cover.beta1=mean(trueinCI.beta1)



#6.3
detach(cars)
library(foreign)
kidiq.path="/Users/ocowchun/Dropbox/nccu/R_Computing _for_Business_Data_Analytics/1111/kidiq.dta"
kid.iq=read.dta(kidiq.path,convert.underscore=T)
attach(kid.iq)
head(kid.iq)
fit.1=lm(kid.score~mom.hs+mom.iq)
coef(fit.1)
summary(fit.1)
#
library(AER)
linearHypothesis(fit.1,c("mom.hs=0","mom.iq=0"))
#
lm(kid.score~mom.work)
lm(kid.score~as.factor(mom.work))
#
fit.2=lm(kid.score~mom.hs+mom.iq+mom.hs:mom.iq)
coef(fit.2)
confint(fit.2)
plot(mom.iq,kid.score,pch=20)
curve(cbind(1,1,x,1*x)%*%coef(fit.2),add=T,col="red")
curve(cbind(1,0,x,0*x)%*%coef(fit.2),add=T,col="blue")
#
fit.all=lm(kid.score~mom.hs+mom.iq+mom.hs:mom.iq+mom.age+
as.factor(mom.work))
summary(fit.all)
#
x.new=data.frame(mom.hs=1,mom.iq=100)
predict(fit.1,x.new,interval="prediction",level=0.95)
#
sigma=sd(residuals(fit.1))
ytilda.fixed=coef(fit.1)[1]+coef(fit.1)[2]*1+coef(fit.1)[3]*100
ytilda=ytilda.fixed+rnorm(5000,0,sigma)
c(quantile(ytilda,0.025),quantile(ytilda,0.975))

#6.4
summary(fit.2)
c.mom.hs=mom.hs-mean(mom.hs)
c.mom.iq=mom.iq-mean(mom.iq)
fit.3=lm(kid.score~c.mom.hs+c.mom.iq+c.mom.hs:c.mom.iq)


#6.5
set.seed(123)
b0=0.2
b1=0.5
 n=1000
x=runif(n, -1, 1)
S=1000
gamma=1.5
par.est=matrix(NA, nrow=S, ncol=2)
for(s in 1:S){
      y1=b0+b1*x+rnorm(n, 0, exp(x*gamma))
       model1=lm(y1~x)
       sigma=summary(model1)$sigma
       y2=b0+b1*x+rnorm(n, 0, sigma)
       model2=lm(y2~x)
       par.est[s, 1]=model1$coef[2]
       par.est[s, 2]=model2$coef[2] 
 }

dev.new(width=8, height=5)

plot(density(par.est[,2]),main="",lwd=2,xlab="")
lines(density(par.est[,1]),col= 'red', lwd=2, lty=2)
legend(0.12,3,c("Homoskedastic","Heteroskedastic"),
lty=c(1,2),lwd=c(2,2),bty="n",cex=1.1,col=c('black','red'))
mtext(expression(paste(hat(beta[1]))),side=1,line=2,cex=1.1)



library(VGAM)
set.seed(123)
b0=0.2
b1=0.5
n=1000
x=runif(n, -1, 1)
S=1000
par.est=matrix(NA, nrow=S, ncol=2)
for(s in 1:S){
       y1=b0+b1*x+rnorm(n, 0, 1)
       model1=lm(y1~x)
       y2=b0+b1*x+rlaplace(n, 0, 1)
       model2=lm(y2~x)
       par.est[s, 1]=model1$coef[2]
       par.est[s, 2]=model2$coef[2] 
}

dev.new(width=8, height=5)

plot(density(par.est[,1]),main="",lwd=2,xlab="")
lines(density(par.est[,2]),col= 'red', lwd=2, lty=2)
legend(0.3,6,c("Normal Errors","Laplace Errors"),
lty=c(1,2),lwd=c(2,2),bty="n",cex=1.1,col=c('black','red'))
mtext(expression(paste(hat(beta[1]))),side=1,line=2,cex=1.1)
abline(v=0.5,col='green')


