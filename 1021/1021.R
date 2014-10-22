# P(X \leq 0.5| \lambda = 4) in R it is just
pexp(0.5,4)

# P(X \geq 20| \lambda = 4) in R it is just
#= 1- P(X \leq 20| \lambda = 4)
1-pexp(20,4)

# We need to find k such that P(X <= k)=0.95
qexp(0.95,4)

x=seq(0,30,0.1)
plot(x,dexp(x,0.2),type='l',lwd=2)


lines(x,dgamma(x,1,0.2))
lines(x,dgamma(x,2,0.2),col='red',lty=2,lwd=3)
lines(x,dgamma(x,5,0.2),col='green',lty=3,lwd=3)

# lty=line type 
# lwd=line width

# simulate some data
t_to_event=rgamma(1000,5,0.2)
plot(density(t_to_event))


curve(dnorm(x,1.5,0.5),from=0,to=3)

y=cbind(dnorm(x,1.65,.25),dnorm(x,1.85,.25))

matplot(x,y,type="l",xlab="",ylab="f(x)")

# if X~N(mu1,sigama1^2) & Y~N(mu2,sigama2^2) independent of X,then X+Y~N(mu1+mu2,sigama1^2+sigama2^2)
# sim
z1=rnorm(10000,1,1)
z2=rnorm(10000,1,2)
z=z1+z2
par(las=1)
hist(z,breaks=seq(-10,14,0.2),freq=F)
abline(v=2,col='red')
f=function(x){exp(-(x-2)^2/10)/sqrt(10*pi)}
x=seq(-10,14,0.1)
lines(x,f(x),col='green')

# chi square
z1=rnorm(10000)
z2=rnorm(10000)
x=z1^2+z2^2
hist(x,freq=F)
xchisq=seq(min(x),max(x))
lines(xchisq,dchisq(xchisq,df=2),lty=2,lwd=2,col='red')

x=rnorm(10000)
y=rchisq(10000,df=10)
t=x/sqrt(y/10)
hist(t,freq=F)
tfit=seq(min(t),max(t),0.05)
lines(tfit,dt(tfit,df=10),col='green')