# result=read.table("/Users/ocowchun/Dropbox/nccu/R_Computing _for_Business_Data_Analytics/0923/results.txt")


# use.switch=function (x){
# switch(x,"a"="first","z"="last","other")
# }

x=1
tolerance=0.000001

# x
f=x^3+2*x^2-7
while(abs(f)>tolerance){
	f.prime=3*x^2+4*x
	x=x-f/f.prime
	f=x^3+2*x^2-7
}

newton=function (x=1){
	f=x^3+2*x^2-7
	f.prime=3*x^2+4*x
	x=x-f/f.prime
	if(abs(f)<tolerance){
		return (x)
	}
	else{
		return (newton(x))
	}
}

# 使用指定的機率來取樣
toss=sample (c("H", "T"), 50, replace=T, prob=c(0.6, 0.4))

toss_money=sample (c(1, -1), 50, replace=T, prob=c(0.6, 0.4))

pocket=c()
pocket[1]=toss_money[1]
for(i in 2:50){
	pocket[i]=pocket[i-1]+toss_money[i]
}
num=1:50
plot(num, pocket, type='o', xlab= "Toss number", ylab= "$")