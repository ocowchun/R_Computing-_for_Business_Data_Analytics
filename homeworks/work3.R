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

