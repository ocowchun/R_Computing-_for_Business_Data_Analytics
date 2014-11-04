

#5.1
kew=read.table("d:/kew.txt",col.names=c("year","jan",
"feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec"))
summary(kew)
kew[,2:13]=kew[,2:13]/10
hist(kew[,8])

jul.rain=kew[,8]
sum(jul.rain==0)
gammaloglik=function(par){
            loglik=0
            for(i in 1:length(jul.rain)){
                loglik.i=ifelse(log(dgamma(jul.rain[i],par[1],par[2]))==-Inf,
                         0,log(dgamma(jul.rain[i],par[1],par[2])))
            loglik=loglik+loglik.i     
            }
            -loglik
}
#
mle=nlminb(c(1,1),gammaloglik,lower=c(1e-5,1e-5))
#
alpha.mle=mle$par[1]
lambda.mle=mle$par[2]
#
dev.new(width=8,height=5)
par(las=1)
hist(kew[,8],breaks=20,freq=F,xlab="rainfall(mm)",ylab="density",main="",
ylim=c(0,0.02))
t=seq(0,max(kew[,8]),0.5)
lines(t,dgamma(t,alpha.mle,lambda.mle),col='green',lwd=2)
#
normallik=function(par){
            loglik=0
            for(i in 1:length(jul.rain)){
                loglik.i=ifelse(log(dnorm(jul.rain[i],par[1],par[2]))==-Inf,
                         0,log(dnorm(jul.rain[i],par[1],par[2])))
            loglik=loglik+loglik.i     
            }
            -loglik
}
mle2=nlminb(c(mean(jul.rain),sd(jul.rain)),normallik,lower=c(1e-5,1e-5))
lines(t,dnorm(t,mle2$par[1],mle2$par[2]),col='blue',lty=2,lwd=2)
#
exponenlik=function(par){
            loglik=0
            for(i in 1:length(jul.rain)){
                loglik.i=ifelse(log(dexp(jul.rain[i],par[1]))==-Inf,
                         0,log(dexp(jul.rain[i],par[1])))
            loglik=loglik+loglik.i     
            }
            -loglik
}
mle3=nlminb(c(lambda.mle),exponenlik,lower=c(1e-5))
lines(t,dexp(t,mle3$par[1]),col='red',lty=3,lwd=2)

legend(120,0.015,c("Gamma","Normal","Exponential"),
lty=c(1,2,3),lwd=c(2,2,2),bty="n",cex=1.1,col=c('green','blue','red'))

##
jul.rain=jul.rain[jul.rain>0]
n=length(jul.rain)
f=function(a){
  alpha=a
  return(n*log(alpha)-n*log(mean(jul.rain))+sum(log(jul.rain))-
  n*numericDeriv(gamma(alpha),"alpha")/gamma(alpha))
}
#
alpha.root=uniroot(f,c(1e-5,10))$root
lambda.root=alpha.root/mean(jul.rain)
gammaloglik(c(alpha.root,lambda.root))
mle$objective

##
set.seed(100)
n=2000
la=2
x=rpois(n,la)
xbar=mean(x)
s=sd(x)
L=xbar-1.96*s/sqrt(n)
U=xbar+1.96*s/sqrt(n)
cat("estimate is",xbar,"\n")
cat("95% CI is (" ,L, ",", U, ")\n",sep="")

set.seed(100)
n=2000
la=2
plot(c(1,n),c(la-sqrt(la),la+sqrt(la)),type="n",
xlab="sample size k", ylab="k point average")
abline(h=la)
lines(1:n,la+1.96*sqrt(la/1:n),lty=2,col='red')
lines(1:n,la-1.96*sqrt(la/1:n),lty=2,col='red')
x=rpois(n,la)
xbar=cumsum(x)/1:n
lines(1:n,xbar,type='l',col='blue')

##5.2.1
win=sample(c(-1,1),size=50,replace=T)
cum.win=cumsum(win)
cum.win
sum(win)
#
dev.new(width=12,height=10)
par(mfrow=c(2,2))
for(j in 1:4){
    win=sample(c(-1,1),size=50,replace=T)
    plot(cumsum(win),type='l',ylim=c(-15,15))
    abline(h=0)
}
#
snoopy=function(n=50){win=sample(c(-1,1),size=n,replace=T)
       sum(win)}
F=replicate(10000,snoopy())
table(F)
plot(table(F))
sum(F==0)/10000
dbinom(25,size=50,prob=0.5)
#
snoopy=function(n=50){
       win=sample(c(-1,1),size=n,replace=T)
       cum.win=cumsum(win)
       c(F=sum(win),L=sum(cum.win>0),M=max(cum.win))}
S=replicate(1000,snoopy())
#
mean(S["L",])
c(quantile(S["L",],0.05),quantile(S["L",],0.95))
mean(S["M",])
sum(S["M",]>10)/1000

#
collect=function(npurchased){
        cost.r=5
        cost.d=25
        cardsbought=sample(1:101,size=npurchased,replace=TRUE)
        nhit=length(unique(cardsbought))
        nmissed=101-nhit
        cost.r*npurchased+cost.d*nmissed
}
collect(0)
2525/5
costs=replicate(1000,collect(500))
sum(costs<=2525)/1000
sum(costs<2525)/1000

#5.2.2
set.seed(42)
runif(2)

RNG.state=.Random.seed
runif(2)
set.seed(42)
runif(4)
runif(4)
#
.Random.seed=RNG.state
runif(2)

x=-1:4
plot(x,pbinom(x,3,0.5),type='s',col='red',lwd=2)


x=rnorm(10000)
x=x[(0<=x)&(x<=3)]
hist(x,probability=T)
lines(density(x,from=0,to=3),col='red',lty=2,lwd=2)
curve(dnorm(x),add=TRUE,col='green')





