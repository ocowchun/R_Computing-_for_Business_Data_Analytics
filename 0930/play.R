#
bloodtype=c("A","B","AB")
# convert vector to nominal factors
blood.N=as.factor(bloodtype)
# convert nominal to numbers
blood.n=as.numeric(blood.N)

#ordinal factors
Grade=c("A","B","C","D","F")
Grade.O=factor(x=Grade,levels=c("F","D","C","B","A"),ordered=T)

###Pie chart
if(F){
	groupsizes=c(18,29,41,22,15)
	labels=c("A","B","C","D","E")
	pie(groupsizes,labels,col=c("grey","yellow","blue","green","red"))

}

if(F){
	x=sample(100,20,T)
	y=sample(100,20,T)
	plot(x,y)
	lines(sort(x),sort(y))	
}

# write 4 chart in 1 page
if(F){
	dev.new()
	par(mar=c(3,4,1,1))
	par(mfrow=c(2,2))
	hist(arch1,xlab="architecture",main="semester1",ylim=c(0,35))
	hist(arch2,xlab="architecture",main="semester2",ylim=c(0,35))
	hist(prog1,xlab="Programming",main="",ylim=c(0,35))
	hist(prog2,xlab="Programming",main="",ylim=c(0,35))

}

 # Suppose payments of R dollars are deposited annually into a bank account that earns constant interest i per year
 # (assuming deposits are made at the end of each year). The total amount at the end of n years is

annuityAmt=function(r,i,n) {
	r*((1+i)^n-1)/i
}

# control flow
a=10
if(a>1){
	print("a is bigger than 1")
}else{
	print("a isn't bigger than 1")
}

for(i in 1:10){
	print("I like banana")
}

# for
fruit = c("apple", "orange", "watermelon")
fruitL=rep(NA, length(fruit))
names(fruitL)=fruit
for (i in 1:length(fruit)){
	fruitL[i]=nchar(fruit[i])
}
fruitL

# while
x=1
while (x<=5){
	print(x)
	x=x+1
}