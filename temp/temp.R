# c=sample()
x=seq(1,10,0.1)
plot(x,c(-200,500),type="n")
f=function(x) {
	x^3-7*x^2+1
}
y=f(x)
lines(x,y,col='red')
