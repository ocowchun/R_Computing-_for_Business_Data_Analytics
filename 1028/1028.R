# win=sample(c(-1,1),size=50,replace=T)

# cum.win=cumsum(win)


par(mfrow=c(2, 2)) 
for(j in 1:4){
	win=sample(c(-1, 1), size=50, replace=TRUE) 
	plot(cumsum(win), type=‘l’, ylim=c(-15, 15))
	abline(h=0)  

}


snoopy=function(n=50){
	win=sample(c(1,-1),size=n,replac=T)
	sum(win)
}
rint(123)

# 
# while()
# qnorm()

print(1)

sample.norm=function(n){
	qnorm(runif(n))
}


sample.exp=function(n){
	qexp(runif(n))
}
