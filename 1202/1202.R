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
 	par.est[s, 4]= sqrt(diag(vcv)[2])
 }

# 繪圖
 # dev.new(width=12, height=5)
 # par(mfrow=c(1,2))
 # hist(par.est[,1])
 # abline(v=b0,col= 'red', lwd=2) 
 # hist(par.est[,2])
 # abline(v=b0, col= 'red', lwd=2)

 #install.packages('foreign')
 # library(foreign)
 # kidiq=read.dta("/Users/ocowchun/Dropbox/nccu/R_Computing _for_Business_Data_Analytics/1111/kidiq.dta",convert.underscore=T)
 # attach(kidiq)

fit.1=lm(kid.score ~ mom.hs + mom.iq)
coef(fit.1)

library(AER)
linearHypothesis(fit.1,c("mom.hs=0","mom.iq=0"))

# 如果你直接將mom.work帶入lm,他會被視作一個連續變數
lm(kid.score~mom.work)

# 不過mom.work的1,2,3,4其實代表work的四種類型,因此你不應該把mom.work視為一個連續變數,
# 他應該要是一個類別變數,所以下列的寫法會比較適合:
lm(kid.score~as.factor(mom.work))

