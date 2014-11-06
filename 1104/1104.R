# Recall that U~U(0, 1), E[U]=1/2, and Var[U]=1/12. So, if u1,...,u12
# are iid U(0, 1) random numbers, then
n=1000
z=c()
for(i in 1:n){
	z[i]=sum(runif(12,0,1))-6
}

# hist(z)

# But the algorithm works quite well but it takes 12 uniform random numbers
# to deliver 1 standard normal random number.



#leacture 5 page 13
# Example: Approximate the integral ∫1 x4dx 0
# > u=runif(n=100000, 0, 1)
# > mean(u^4)*(1-0)
# The exact answer is 0.2. How good is our approximation?
u=runif(100000,0,1)
(1-0)*sum(u^4)/100000

# Example: Approximate the integral ∫25 sin(x)dx
u=runif(100000,2,5)
(5-2)*sum(sin(u))/100000


x=rexp(100000)
mean(exp(-(x+1)^2) /dexp(x))

# How can we compute the area without integrating ∫^2_0 1− |1− x | dx ?
x=seq(0, 2, by=0.05)
plot(x, 1-abs(1-x), type="l", lwd=2, ylab="g(x)") 
rect(0, 0, 2 ,1,lty=2,lwd=2)	

n=1000
U1=runif(n, 0, 2)
U2=runif(n, 0, 1)
hit=which( (U2<=1-abs(1-U1)) == TRUE)
miss=which( (U2<=1-abs(1-U1)) == FALSE)
k=sum( (U2<=(1-abs(1-U1))) == TRUE) #or just use length(hit) 
points(U1[hit], U2[hit], col= "red", pch=20)
points(U1[miss], U2[miss], col= "blue", pch=20)
2*(k/n)

##
hit_miss=function(ftn, a, b, c, d, n){
	k=0
	for (i in 1:n){
		x=runif(1, a, b)
		y=runif(1, c, d)
		hit=ifelse(y<=ftn(x), 1, 0)
		k=k+hit
	}
	I=(k/n)*(b-a)*(d-c)+c*(b-a) 
	return(I)
}

# CMPControl
installed.packages("CMPControl")

u=runif(1000000,0,1)
(1-0)*sum(u^3-7*u^2+1)/1000000


##regression
attach(cars)
L1=lm(cars$dist~cars$speed)
summary(L1)

##
# errorMLE=function(par){
# loglik=0
# for(i in 1:nrow(cars)){
# 	loglik=dnorm(dist[i],(par[i]+par[2]))
# }
# }
nlminb(c(-5,1,2),errorMLE,lower=c(-Inf,-Inf,1e-5))