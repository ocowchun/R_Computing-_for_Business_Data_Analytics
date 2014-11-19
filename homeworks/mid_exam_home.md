##Q1
```r
heart_up=function(x){
	sqrt(1-(abs(x)-1)^2)
}

heart_lo=function(x){
	acos(1-abs(x))-pi
}
x=seq(-2,2,0.05)
# plot(x,heart_lo(x),ylim=c(heart_lo(0),1),type='l')
# lines(x,heart_up(x))
n=100000
macine_gun=function(n){
	up_bound=max(heart_up(x))
	lo_bound=max(heart_lo(x))
	bullet.x=runif(n,-2,2)
	bullet.y=runif(n,lo_bound,up_bound)
	hit=sum(bullet.y<=heart_up(bullet.x)&bullet.y>=heart_lo(bullet.x))
	box=4*(up_bound-lo_bound)
	box*hit/n
}
```

##Q2
```r
bessel.element=function(a,v,z,m){
	denominator=(gamma(m+a+1)*factorial(m))^v
	numerator=(z/2)^(2*m+a)
	numerator/denominator
}

fn=function(a,v,z,max,tolerance,m){
	if(m>max){
		return (0)
	}

	i=bessel.element(a,v,z,m)
	if(i>tolerance)
	{
		return (i+fn(a,v,z,max,tolerance,m+1))
	}
	else{
		return (0)
	}
}

basselI_Gen=function(a,v,z,max,tolerance){
	fn(a,v,z,max,tolerance,0)
}
```

##Q3
