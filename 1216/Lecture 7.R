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

#Zero-truncation
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

#7.2
library(betareg)
data("GasolineYield",package="betareg")
head(GasolineYield)
gy.logit=betareg(yield~batch+temp,data=GasolineYield)
summary(gy.logit)
gy.logit2=betareg(yield~batch+temp|temp,data=GasolineYield)
summary(gy.logit2)
#
#
gy.probit=betareg(yield~batch+temp,data=GasolineYield,link="probit")
gy.loglog=betareg(yield~batch+temp,data=GasolineYield,link="loglog")
gy.cloglog=betareg(yield~batch+temp,data=GasolineYield,link="cloglog")
gy.cauchy=betareg(yield~batch+temp,data=GasolineYield,link="cauchit")
#
AIC(gy.logit,gy.logit2,gy.probit,gy.loglog,gy.cloglog,gy.cauchy)


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
#
#
library(AER)
data("SwissLabor")
attach(SwissLabor)
plot(participation~age,ylevels=2:1)
plot(participation~education,ylevels=2:1)
#
swiss_logit=glm(participation~.+I(age^2),data=SwissLabor,
family=binomial(link="logit"))
swiss_probit=glm(participation~.+I(age^2),data=SwissLabor,
family=binomial(link="probit"))
#
swiss_logit0=update(swiss_logit,formula=.~1)
summary(swiss_logit0)
1-as.vector(logLik(swiss_logit)/logLik(swiss_logit0))
#
anova(swiss_logit0,swiss_logit,test="Chisq")
#
table(true=SwissLabor$participation,pred=round(fitted(swiss_logit)))
table(true=SwissLabor$participation,pred=round(fitted(swiss_probit)))
#
library(ROCR)
pred=prediction(fitted(swiss_probit),SwissLabor$participation)
#
dev.new(width=12,height=5)
par(mfrow=c(1,2))
plot(performance(pred,"acc"))
plot(performance(pred,"tpr","fpr"))
abline(0,1,lty=2)
#
swiss_cloglog=glm(participation~.+I(age^2),data=SwissLabor,
family=binomial(link="cloglog"))
pred2=prediction(fitted(swiss_cloglog),SwissLabor$participation)
plot(performance(pred2,"tpr","fpr"),col='red',lty=2,lwd=2)
plot(performance(pred,"tpr","fpr"),add=T)
#
#
#Complete separation
data("MurderRates")
murder_logit=glm(I(executions>0)~time+income+noncauc+lfp+southern,
data=MurderRates,family=binomial)
coeftest(murder_logit)
#
murder_logit2=glm(I(executions>0) ~ time + income + noncauc + lfp + southern, 
data=MurderRates, family=binomial, control=list(epsilon=1e-15, maxit=50, trace=F))
coeftest(murder_logit2)
#
murder_logit3=glm(I(executions>0)~time+income+noncauc+lfp,
data=MurderRates,family=binomial)
coeftest(murder_logit3)


#7.4
library(quantreg)
data("CPS1988")
cps_f=log(wage) ~ experience + I(experience^2) + education
cps_lad=rq(cps_f, data=CPS1988)
cps_ols=lm(cps_f, data=CPS1988)
summary(cps_lad)
summary(cps_ols)
#
cps_rq=rq(cps_f, tau=c(0.25, 0.75), data=CPS1988)
summary(cps_rq)
#
cps_rq25=rq(cps_f, tau=0.25, data=CPS1988)
cps_rq75=rq(cps_f, tau=0.75, data=CPS1988)
anova(cps_rq25, cps_rq75)
#
cps_rqbig=rq(cps_f, tau=seq(0.05, 0.95, 0.05), data=CPS1988)
cps_rqbigs=summary(cps_rqbig)
plot(cps_rqbigs)






