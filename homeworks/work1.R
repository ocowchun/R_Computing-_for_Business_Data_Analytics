# Q1 
# (a)Create a vector called downtime. The vector should contain the following numbers: 
#0, 1, 2, 12, 12, 14, 18, 21, 21, 23, 24, 25, 28, 29, 30, 30, 30, 33, 36, 44, 45, 47, and 51.
downtime=c(1:51)

# (b) Calculate the mean, median, min, max, and range of downtime.
downtime.mean=mean(downtime)
downtime.median=median(downtime)
downtime.min=min(downtime)
downtime.max=max(downtime)
downtime.range=range(downtime)

# (c) Calculate the standard deviation, 5 percentile, and 95 percentile of downtime (Hint: Use the quantile function).
downtime.sd=sd(downtime)
downtime.quantile5=quantile(downtime,0.05)
downtime.quantile95=quantile(downtime,0.95)

# (d) What is the mode of downtime (Hint: Use the table function). What is the frequency?眾數
Mode=function(x) {
	t=table(x)
	rownames(t)[t==max(t)]
}
Mode(downtime)

Mode.frequency=function(x) {
	t=table(x)
	max(t)
}

Mode.frequency(downtime)

# (e) Pick out the subset of the mode numbers from the downtime vector.
as.numeric(Mode(downtime))

# Q2. (10%) Use rep( ) and seq( ) as needed to create the two vectors. 
# (a) 0 0 0 0 0 1 1 1 1 1 2 2 2 2 2 3 3 3 3 3 4 4 4 4 4
c(rep(0,5),rep(1,5),rep(2,5),rep(3,5),rep(4,5))

# (b) 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5
rep(1:5,5)


# Q3. (5%)
# (a) Create a 4x3 matrix that stores the values below. Also name each column correctly (x, y, z)
x=c(61,175,111,124)
y=c(13,21,24,23)
z=c(4,18,14,18)
m=cbind(x,y)
m=cbind(m,z)

# (b) Display the row 1, column 3 element of the matrix.
m[1,3]

# Q4. (10%) Calculate and compare with log(N)+0.6 for N = 500, 2000, 8000.
sum.frac=function (n){
	result=0
	for(i in 1:n){
		result=result+(i/n)
	}
	result
}
log.add06=function(n) {
	log(n)+0.6
}

compare=function(n) {
	sum.frac(n)>log.add06(n)
}
compare(500)
compare(2000)
compare(8000)

#Q5. (10%) The equation x7 +10000x6 +1.06x5 +10600x4 +0.0605x3 +605x2 +0.0005x+5 has exactly one real root. 
#Write an R program to find the root. What is the root? How many iterations of Newton’s method are required to find this root
#if the initial guess is x=0?
x=0
tolerance=0.000001
count=0
repeat{
	f=x^7+10000*x^6+1.06*x^5+10600*x^4+0.0605*x^3+605*x^2+0.0005*x+5
	if(abs(f) < tolerance) break
	f.prime=7*x^6+60000*x^5+5.3*x^4+42400*x^3+0.1815*x^2+1210*x+0.0005
	x=x-f/f.prime
	count=count+1
}
# root=-10000
# 1次

# Q6. (10%) Based on the results.txt file (in Lecture 1), write R code to reproduce the graph below.
result=read.table("/Users/ocowchun/Dropbox/nccu/R_Computing _for_Business_Data_Analytics/0923/results.txt",header = T)
attach(result)
names(result)
par(mfrow=c(2,2))
# "arch1"  "prog1"  "arch2"  "prog2" 
boxplot(arch1~gender,xlab="gender",main="Architecture Semester 1")
boxplot(arch2~gender,xlab="gender",main="Architecture Semester 2")
boxplot(prog1~gender,xlab="gender",main="Porgramming Semester 1")
boxplot(prog2~gender,xlab="gender",main="Porgramming Semester 2")

# Q7. (15%)
# (a) Compute 4!, 50!, and 5000! (Hint: Use the factorial function)
factorial(4)
factorial(50)
lfactorial(5000) #直接跑 會出現警告訊息：In factorial(5000) : 在 'gammafn' 中的值超出範圍
#所以我們只能對5000!取log 也就是說5000!=e^82108.93

# (b) Compute
choose(4,2)
choose(50,20)
lchoose(5000,2000) #同5000!，直接執行choose(5000,2000會出現Inf,所以一樣取log,c5000取2000等於e^3360.594

# (c) The factorial function tends to return Infinity when its argument is large. To tackle this, apply log( ) 
# and sum( ) to compute 5000! and  5000  . Express your answers in terms of e?.
	82108.93
	3360.594

# Q8. (10%) The Fibonacci sequence is famous in mathematics.
# (a) Write a while( ) loop to find the first Fibonacci number k > greater than 100.
	fib=function(n) {
		if(n>2){
			return (fib(n-1)+fib(n-2))
		}else{
			return (1)
		}
	}
	n=0
	while(fib(n)<=100){
		n=n+1
	}
	print(fib(n))#144
#(b) For the number Fn=k in (a), what is the index n?
	print(n)#12
# (c) Write a for( ) loop to print ALL Fibonacci numbers <= k.
	for(i in 1:n){
		print(fib(i))
	}


# Q9. (10%) Write an R function that prints out all prime numbers <= n (where n is an integer). 
# After writing the function, set n=100 and show me the results.

	primes=function(n) {
		result=NULL
		for( i in 2:n){
			is_prime=!any(i%%result==0)
			if(is_prime){
				result=c(result,i)
			}
		}
		result
	}
	primes(100) #2  3  5  7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97

#Q10.(10%) Considerthefunctiony=f(x)definedby y f(x)
	f=function(x) {
		y=0
		if(x>1){
			y=sqrt(x)
		}else if(x>0){
			y=x^2
		}else{
			y=-1*x^3
		}
		y
	}
	datas=seq(-2, 2, 0.1)
	results=rep(0,length(datas))
	for(i in  1:length(datas)){
		results[i]=f(datas[i])
	}

	plot(datas,results,type='l',xlab='x',ylab='f(x)')
	