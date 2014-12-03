#7.1
#
set.seed(3759)
b0=0.2
b1=0.5
n=1000
x=runif(n, -1, 1)
S=1000
par.est=matrix(NA, nrow=S, ncol=4)
for(s in 1:S){
    y=rpois(n,exp(b0+b1*x))
    model_glm=glm(y ~ x, family="poisson")
    model_lm=lm(y ~ x)
    par.est[s, 1]=model_glm$coef[1]
    par.est[s, 2]=model_lm$coef[1]
    par.est[s, 3]=model_glm$coef[2]
    par.est[s, 4]=model_lm$coef[2]
}
#
dev.new(width=12, height=5)
par(mfrow=c(1,2))
hist(par.est[,3],main="Poisson Reg b1")
abline(v=b1,col='red',lwd=2)
hist(par.est[,4],main="Linear Reg b1")
abline(v=b1,col='red',lwd=2)




library(AER)
data(RecreationDemand)
head(RecreationDemand)
rd_Pois=glm(trips ~ ., data=RecreationDemand, family=poisson) 
summary(rd_Pois)
#
library(arm)
attach(RecreationDemand)
#
SKI=ifelse(ski=="yes",1,0)
USERFEE=ifelse(userfee=="yes",1,0)
Poisloglikf=function(par){
           lik=0
           for(i in 1:nrow(RecreationDemand)){
               lam=exp(1*par[1]+quality[i]*par[2]+SKI[i]*par[3]+
               income[i]*par[4]+USERFEE[i]*par[5]+costC[i]*par[6]+
               costS[i]*par[7]+costH[i]*par[8])
               lik=lik+dpois(trips[i],lam,log=TRUE)
           }
           -lik
}
#
est=nlminb(c(1,rep(0.001,7)),Poisloglikf,control=list(trace=1))
#
summary(rd_Pois)
est$par
#
logLik(rd_Pois)
est$objective
#
#
var(trips)
mean(trips)
dispersiontest(rd_Pois)
#
library(MASS)
rd_NB=glm.nb(trips~.,data=RecreationDemand)
summary(rd_NB)
#
coeftest(rd_Pois)
coeftest(rd_NB)

#7.2
table(trips)[1:10]
table(round(fitted(rd_Pois)))[1:10]
table(round(fitted(rd_NB)))[1:10]
#
library(pscl)
rd_ziPois=zeroinfl(trips~.,data=RecreationDemand,dist="pois")
rd_ziNB=zeroinfl(trips~.|quality+income,data=RecreationDemand,dist="negbin")
round(colSums(predict(rd_ziPois,type="prob")[,1:10]))
round(colSums(predict(rd_ziNB,type="prob")[,1:10]))
table(trips)[1:10]
#
RD_NoZero=RecreationDemand[which(trips!=0),]
detach(RecreationDemand)
attach(RD_NoZero)
var(trips)/mean(trips)
table(trips)
#
library(VGAM)
rdnz_ztpois=vglm(trips~quality+ski+income+userfee+costC+costS+costH,
family=pospoisson,data=RD_NoZero)
rdnz_ztnb=vglm(trips~quality+ski+income+userfee+costC+costS+costH,
family=posnegbinomial,data=RD_NoZero)
summary(rdnz_ztnb)


#7.3
inv.logit=function(p){ 
return(exp(p)/(1+exp(p)))}
#
set.seed(32945)
b0=0.2
b1=0.5
n=1000
x=runif(n, -1, 1)
S=1000
par.est=matrix(NA, nrow=S, ncol=2)
for(s in 1:S){
y=rbinom(n, 1, inv.logit(b0+b1*x))
model_glm=glm(y ~ x, family=binomial(link=logit)) 
model_lm=lm(y ~ x)
par.est[s, 1]=model_glm$coef[2]
par.est[s, 2]=model_lm$coef[2]
}
#
dev.new(width=12, height=5)
par(mfrow=c(1,2))
hist(par.est[,1],main="Logistic Reg b1")
abline(v=b1,col='red',lwd=2)
hist(par.est[,2],main="Linear Reg b1",xlim=c(0,0.5))
abline(v=b1,col='red',lwd=2)

