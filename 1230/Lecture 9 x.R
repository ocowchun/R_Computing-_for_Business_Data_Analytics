#9.1
f=expression(x^3*sin(x/3)*log(sqrt(x)))
g=D(f,"x")
gfun=function(x){eval(g)}
x0=1
exact=gfun(x0)
#
ffun=function(x){x^3*sin(x/3)*log(sqrt(x))}
h=1e-5
(ffun(x0+h)-ffun(x0))/h
#
library(numDeriv)
grad(ffun, 1, method="simple") 
grad(ffun, 1, method= "Richardson" )

#
library(PolynomF)
x=polynom()
p=(x-1)^2+10*x^3+5*x^4
integral(p)
#rm(list=ls())
integral(p, limits=c(0, 2))
#
integrate(p, 0, 2)
#
f=function(x){x^(1/3)/(1+x)}
integrate(f,0,2)
#
#In-class I








#
library(cubature)
f=function(x){1/(1+x[1]^2+x[2]^2)}
adaptIntegrate(f, c(0, 0), c(1, 1))
#
library(pracma)
f=function(x, y){1/(1+x^2+y^2)}
integral2(f, 0, 1, 0, 1)
#
fy=function(y){integrate(function(x){1/(1+x^2+y^2)}, 0, 1)$value}
Fy=Vectorize(fy)
integrate(Fy, 0, 1)


#9.2
x1=x2=seq(-1.5,1.5,0.1)
z=outer(x1, x2, FUN=function(x1, x2){
100*(x2-x1^2)^2+(1-x1)^2})
persp(x1,x2,z,theta=150)
#
fr=function(x){
x1=x[1]
x2=x[2]
100*(x2-x1^2)^2+(1-x1)^2
}
#
optim(c(0,0), fr)
grr=function(x){
x1=x[1]
x2=x[2]
c(-400*x1*(x2-x1^2)-2*(1-x1),200*(x2-x1^2))
}

optim(c(0,0), fr, grr, method="BFGS")
nlm(fr, c(0,0))
optim(c(4,5), fr, method="L-BFGS-B", lower=c(3.5, 3.5), upper=c(5, 5))
nlminb(c(4, 5), fr,lower=c(3.5, 3.5), upper=c(5, 5) )

library(alabama)
f=function(x){sin(x[1]*x[2]+x[3])}
heq=function(x){-x[1]*x[2]^3+x[1]^2*x[3]^2-5}
hin=function(x){
    h=c()
    h[1]=x[1]-x[2]
    h[2]=x[2]-x[3]
    h
}
ans=constrOptim.nl(c(3,1,0),f, heq, hin)

library(Rsolnp)
upper=rep(5, 3)
lower=rep(0, 3)
ans=solnp(c(3, 1, 0), f, eqfun=heq, ineqfun=hin, LB=lower, UB=upper, 
ineqLB=c(0, 0), ineqUB=c(5,5))


#In-class II







#9.3
#Linear programming
library(lpSolve)
simple.lp=lp(objective.in=c(5,8), const.mat=matrix(c(1,1,1,2),2),
const.rhs=c(2,3), const.dir=c(">=",">="))

#In-class excercise III





#
unres.lp=lp(objective.in=c(1,10,-10), const.mat=matrix(c(1,1,1,-1,-1,1),2),
const.rhs=c(2,3), const.dir=c(">=","<="))
unres.lp$solution
#
#MILP
integ.LP=lp(objective.in=c(2,3,4,-1), const.mat=matrix(c(1,0,0,2,3,1,
0,1,0,0,0,1),3),const.rhs=c(9,9,10), const.dir=c(">=",">=","<="),
            )



#Quadratic programming
library(quadprog)
Dmat=matrix(c(1,-1,-1,2), nrow=2)
dvec=c(2,6)
Amat=matrix(c(-1,-1,1,-2,-2,-1), nrow=2)
bvec=c(-2,-2,-3)
solve.QP(Dmat, dvec, Amat, bvec)



