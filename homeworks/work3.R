PTF=function(k,a,b,g){
	p.list=PTF.initList(a,b,g)
	r.list=c(PTF.r0(a,g))
	for(i in 2:k){
		j.list=c(1:(i-1))
		pn=(b*g*p.list[i-1]+sum(rev(r.list)*p.list*j.list))/i		
      # add p to p.list
		p.list[i]=pn
      # add r to r.list
		rn=(i-2+a)/i*g*r.list[i-1]
		r.list[i]=rn	
	}
	tail(p.list,n=1)
}

PTF.initList=function(a,b,g){
	p0=PTF.p0(a,b,g)
	p1=b*g*p0
	c(p1)
}


PTF.p0=function(a,b,g){
	p0=0
	if(a==0){
		p0=(1-g)^b
	}
	else{
		p0=exp(b*((1-g)^a-1)/a)
	}
	p0
}
PTF.r0=function(a,g){
	(1-a)*g
}

#Q2
#(b) Continuing (a), given p=0.5, simulate n=50, n=5000, n=500,000 Bernoulli random numbers.
#For each simulated sample of size n, calculate pˆMLE from the sample and compare pˆMLE to the TRUE p=0.5,
#what have you observed?
p=0.5
n.list=c(50,5000,500000)
p.mle=c()
for(i in 1:length(n.list)){
	n=n.list[i]
	mle=sum(rbinom(n,1,0.5))/n
	p.mle[i]=mle
}
p.mle-p
#(d) Continuing (c), given λ=0.5, simulate n=50, n=5000, n=500,000 exponential random numbers.
# For each simulated sample of size n, calculate \\(\hat{\lambda}_{MLE}\\) from the sample 
# and compare \\(\hat{\lambda}_{MLE}\\)  to the TRUE λ=0.5, what have you observed?
p=0.5
n.list=c(50,5000,500000)
p.mle=c()
for(i in 1:length(n.list)){
	n=n.list[i]
	mle=n/sum(rexp(n,0.5))
	p.mle[i]=mle
}
p.mle-p

#Q3. (20%) Binomial and Poisson Distributions
#(a) The table below records the historical number of car accidents/week in a district.
 # Create a vector called car.accident that stores 109 zeros, 65 ones, 22 twos, 3 threes, and 1 four.
car.accident=c(rep(0,109),rep(1,65),rep(2,22),rep(3,3),rep(4,1))

# (b) Apply the fitdistr( ) function in R (load the MASS library first) to fit the car.accident data with the Poisson distribution.
 # What is the value of estimated λ? What is the log-likelihood?
fitdistr(car.accident,"Poisson")# 0.61000000 
fitdistr(car.accident,"Poisson")$loglik#-206.1067

#(c) Given the estimated λ, use R to do the computation and finish the 3rd column of table below.
# Are the predicted frequencies close to the actual frequency? 
car.lambda=0.61000000 
for(i in 0:4){
	p=dpois(i,car.lambda)
	frequency.ideal=200*p
	print(paste0("200*P(X=",i,"| λ)=",frequency.ideal))
}
p.lt4=1-ppois(4,car.lambda)
frequency.lt4=200*p.lt4
print(paste0("200*P(X >4|λ)=",frequency.lt4))

#(d) Given the estimated λ, finish the 4th column of table below using R.
for(i in 0:4){
	frequency.ideal=200*dbinom(i,200,p=car.lambda/200)
	print(paste0("200*P(X =",i,"|n, p)=",frequency.ideal))
}
p2.lt4=1-pbinom(4,200,p=car.lambda/200)
frequency2.lt4=200*p2.lt4
print(paste0("200*P(X >4|n, p)=",frequency2.lt4))

###Q4. (20%) Binomial, Poisson, and Normal Distributions
####(a) Finish the second, third, and fourth column of the table below using R.
for(i in 0:8){
	p.binom=dbinom(i,20,0.2)
	p.pois=dpois(i,4)
	p.norm=dnorm(i,4,2)
	print(paste0(i,"|",p.binom,"|",p.pois,"|",p.norm,"|"))
}

#(b) Based on the probability densities you calculate, generate a plot in which the x-axis is 0:8 and the y-axis lies between [0, 0.25].
#The plot should have three lines with different width and colors. (red thin line for Binomial, green thick line for Poisson, 
#blue thicker line for Normal).
y.binom=c()
y.pois=c()
y.norm=c()
for(i in 0:8){
	y.binom[i+1]=dbinom(i,20,0.2)
	y.pois[i+1]=dpois(i,4)
	y.norm[i+1]=dnorm(i,4,2)
	print(paste0(i,"|",p.binom,"|",p.pois,"|",p.norm,"|"))
}
x=seq(0,8)
plot(c(0,8),c(0,0.25),type="n")
lines(x,y.binom,col='red')
lines(x,y.pois,col="green",lwd=2)
lines(x,y.norm,col="blue",lwd=5)

#Q5. (20%) Random Numbers and Monte-Carlo Simulation
#(a) Implement the algorithm in the bottom of page 10 in lecture 5. Write a function runi.congru 
# that has five arguments (N, A, B, m, seed) (N is the number of random variates to be simulated). 
# After that, generate five uniform random numbers using A=1217, B=0, m=32767, and seed=1.
# Save the five numbers as a vector u in R and show me the five numbers.

runi.congru =function(N, A, B, m, seed){
	x=seed
	numbers=c()
	for(i in 1:N){
		x=(A*x+B)%%m
		numbers[i]=x/m
	}
	numbers
}

u=runi.congru(5,1217,0,32767,1)#  0.03714103 0.20062868 0.16510514 0.93295083 0.40116581

#(b) Implement the inverse transformation method in the bottom of page 11 in lecture 5. 
# Write a function rbinom.invtran that has four arguments (N, n, p, uni) and returns N binomial random numbers.
 # Set n=3, p=0.5, and use the vector u in part (a) as inputs to uni to generate five binom random variates. Show me the simulated numbers too.

rbinom.invtran=function(N,n,p,uni){
	numbers=c()
	for(i in 1:N){
		x=0
		while(pbinom(x,n,p)<uni[i]){
			x=x+1
		}
		numbers[i]=x
	}
	numbers
}
rbinom.invtran(5,3,0.5,u) # 0 1 1 3 1

# (c) Now, use the function runi.congru in (a) to simulate another 50 numbers
# by setting seed=2 (A=1217, B=0, m=32767 still) and store the 50 numbers in a vector U.
U=runi.congru(50,1217,0,32767,2)# 1217  6574  5410 30570 13145
#  [1] 7.428205e-02 4.012574e-01 3.302103e-01 8.659017e-01 8.023316e-01 4.375744e-01 5.280313e-01 6.140324e-01
#  [9] 2.774438e-01 6.490677e-01 9.153417e-01 9.707938e-01 4.560381e-01 9.983520e-01 9.943846e-01 1.660512e-01
# [17] 8.432264e-02 6.206549e-01 3.370464e-01 1.854915e-01 7.431562e-01 4.211249e-01 5.090182e-01 4.751732e-01
# [25] 2.857753e-01 7.885678e-01 6.869716e-01 4.449599e-02 1.516160e-01 5.166173e-01 7.232887e-01 2.423170e-01
# [33] 8.997467e-01 9.917295e-01 9.347819e-01 6.296274e-01 2.565081e-01 1.703238e-01 2.840663e-01 7.086703e-01
# [41] 4.517655e-01 7.986084e-01 9.063692e-01 5.133213e-02 4.712058e-01 4.574419e-01 7.068392e-01 2.233039e-01
# [49] 7.608875e-01 6.103702e-05


#(d) For the zero-truncated Poission distribution
#Following the logic of inverse transformation, write a function rztpois.invtran that has three arguments (N, lambda, uni) (lambda for λ)
#and returns N zero-truncated Poisson random numbers. 
#Set lambda=4 and use the vector U (part (c)) as inputs to uni to generate 50 non-zero Poisson random variates. Show me the simulated numbers too.

dztpois=function(x,lambda){
	lambda^x*exp(-lambda)/(factorial(x)*(1-exp(-lambda)))
}

pztpois=function(x,lambda){
	if(x>1){
		return (dztpois(x,lambda)+pztpois(x-1,lambda))
	}
	else{
		return (dztpois(1,lambda))
	}
}

rztpois.invtran=function(N, lambda, uni){
	numbers=c()
	for(i in 1:N){
		x=1
		while(pztpois(x,lambda)<uni[i]){
			x=x+1
		}
		numbers[i]=x
	}
	numbers
}
rztpois.invtran(50,4,U)
#  [1]  1  3  3  6  6  4  4  4  3  5  7  8  4 11 10  2  2  4  3  2  5  3  4  4  3  6  5  1  2  4  5  3  7 10  7  5  3  2
# [39]  3  5  4  6  7  1  4  4  5  2  5  1

#(e)
customers.counts=rztpois.invtran(50,4,U)
seat2=length(customers.counts[customers.counts<=2])
seat4=length(customers.counts[customers.counts<=4&customers.counts>2])
seat6=length(customers.counts[customers.counts<=6&customers.counts>4])
room.private=length(customers.counts[customers.counts>6])


