#8.1
install.packages("MVA")
install.packages("HSAUR2")
install.packages("fMultivar")
#
library(fMultivar)
library(MVA)
data(USairpollution)
attach(USairpollution)
#
round(cov(USairpollution),3)
round(cor(USairpollution),3)
round(dist(scale(USairpollution,center=FALSE)),3)
#
mu1=0
mu2=0.5
sig1=0.5
sig2=2
rho=0
x=seq(-3,3,0.01)
y=seq(-3,3,0.01)
#
bivariate=function(x,y){
          term1=1/(2*pi*sig1*sig2*sqrt(1-rho^2))
          term2=(x-mu1)^2/sig1^2
          term3=-(2*rho*(x-mu1)*(y-mu2))/(sig1*sig2)
          term4=(y-mu2)^2/sig2^2
          z=term2+term3+term4
          term5=term1*exp((-z/(2*(1-rho^2))))           
          return(term5)
}
#
z=outer(x,y,bivariate)
#
persp(x,y,z,main="Bivariate Normal Distribution",theta=55,phi=30,r=40,
d=0.1,expand=0.5,ltheta=90,lphi=180,shade=0.4,ticktype="detailed",nticks=5)


#8.2
install.packages("scatterplot3d")
install.packages("rgl")
install.packages("Rcmdr")
#
pairs(USairpollution, pch=".",cex=2)
library(scatterplot3d)
s3d=scatterplot3d(temp, wind, SO2, type= "h", highlight.3d=T, angle=55)
fit=lm(SO2~temp+wind)
s3d$plane3d(fit)
#
library(rgl)
plot3d(temp,wind,SO2,col='red',size=3,type='p')
#
library(Rcmdr)
scatter3d(temp,wind,SO2)
#
library(lattice)
plot(xyplot(SO2 ~ temp| cut(wind, 2)))
plot(xyplot(SO2 ~ temp| cut(wind, 3), layout=c(3,1)))
pollution=with(USairpollution, equal.count(SO2, 4))
plot(cloud(precip ~ temp*wind | pollution, panel.aspect=0.5))
#
#PCA
round(cor(USairpollution[,-1]),3)
usair_pca=princomp(scale(USairpollution[,-1]))
summary(usair_pca,loadings=TRUE)
#
plot(usair_pca$sdev^2,xlab="component number",ylab="eigenvalue",type='l')
abline(h=1,lty=2,col='red')
#
usair_pca$scores[,1]
usair_pca$loadings[,1]%*%t(scale(USairpollution)[,-1])
#
usair_reg1=lm(SO2~.,data=USairpollution)
usair_reg2=lm(SO2~usair_pca$scores[,1:3],data=USairpollution)
summary(usair_reg1)
summary(usair_reg2)
usair_reg3=lm(SO2~usair_pca$scores[,c(1,4:6)],data=USairpollution)
summary(usair_reg3)
#
round(cor(USairpollution),3)
summary(usair_pca,loadings=TRUE)
#
#8.3
#
dm=dist(scale(USairpollution[ , -1]))
dev.new(width=15, height=5)
par(mfrow=c(1,3))
plot(cs <- hclust(dm, method= "single"))
plot(cc <- hclust(dm, method= "complete"))
plot(ca <- hclust(dm, method= "average"))

cutree(cs, h=2)
table(cutree(cs, h=2))

dm_pc=dist(usair_pca$scores[ , 1:3])
plot(cs_pc <- hclust(dm_pc, method= "single"))
table(cutree(cs_pc, h=2))
#
usair_ck=kmeans(scale(USairpollution[,-1]),centers=3)
usair_ck$cluster
#
k=6
WGSS=c()
for(i in 1:k){
    WGSS[i]=sum(kmeans(scale(USairpollution[,-1]),centers=i)$withinss)
}
#
plot(1:k,WGSS,type="b")
#
#
Stirling2nd=function(n,k){
            term=0
            for(j in 0:k){
                term=term+(-1)^(k-j)*choose(k,j)*j^n
            }
            term/factorial(k)
}
#
Stirling2nd(15,3)
#










