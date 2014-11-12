# data()
# attach(cars)
# plot(cars)
L1=lm(dist~speed)
summary(L1)
c(quantile(betas,0.025),quantile(betas,0.975))

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
