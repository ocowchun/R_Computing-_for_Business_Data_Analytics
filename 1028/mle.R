##MLE

#5.1
kew=read.table("Dropbox/nccu/R_Computing _for_Business_Data_Analytics/1028/kew.txt",col.names=c("year","jan",
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



