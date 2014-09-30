11/11 期中考
1/6,1/13專案
elearning上會有之前的專案可以參考

###how to install package
```r
install packages("coefplot")
```


####餘數
	10%%3

####商
	17%/%5

####四捨五入到小數點第二位
	round(pi,2)

####宣告一個變數
	x = 2
	x <- 2
	assign("j",4)

####移除變數
	rm(j)

####remove all variable in system
	rm(list=ls())

####建立一個陣列
	a=c(1,2,3)	

####建立一個1~10的陣列(**:**是to的意思)
	x=1:10

####create sequence of nummbers with the increment you want
	seq(from,to,by)
	x1=seq(1,4,by=2)

####回傳不重複值的陣列
	x=1:10
	unique(x)

####排序
	x=1:10
	y=sort(x,descreasing=FALSE)	

####是否有符合條件的值
	x=1:10
	any(x>12) #true

####是否全部的成員都符合條件
	x=1:10
	all(x>12) #false

####回傳符合條件的 *成員索引* 組成的陣列
	x=1:10
	which(x>8) #[9,10]

####回傳符合條件的成員組成的陣列
	x=1:10
	x[which(x>8)] #[9,10]


####重複產生值的陣列
	repo(x,times)
	x2=rep(0,4)


####R的加法是陣列
	x=rep(0,4)
	x=x+(1:4) #[1,2,3,4]

####次方
	x=2
	x^2=> 4
	x**4 => 16

###建立陣列
	m=matrix(1:10,nrow=2,ncol=5)	

####建立字串的陣列
	educ=c("High School","college","Master","doctorate")	

####轉換為列舉
	as.factor(X) #將內容轉為可轉為數字陣列	
    as.numberic(X)

####NA(missing)
	z=c(1,2,NA)
	is.na(z)#FALSE FALSE  TRUE
	mean(z,na.rm=T) #1.5 把NA的值移除掉

####子集合，會把NA移除
	z=c(1,2,3,NA)
	subset(z, z>2)#3

####可以在[]裏面指定多個判斷式
	z=c(3,4,5,NA,7)
	z[is.na(z)==0 & z>2] #3 4 5 7

####NULL 跟NA不一樣 NULL只會回傳單一TRUE,FALSE
	z=c(3,4,5,NA,7)
	is.null(z)#FALSE 

####讀取資料
	result=read.table("D:/../result.txt",header=T)
通常不常用


####Array 多維度的陣列
通常不常用


####Matrix，超級常用
	A=matrix(1:10,nrow=5)

####Matrix 相乘(A1*B1)
	A=matrix(1:10,nrow=5)
	B=matrix(1:10,nrow=5)
	A*B

####Matrix 真正的相乘	
	A=matrix(1:10,nrow=5)
	B=matrix(1:10,nrow=5)
	A%*%t(B)	

####rbind,cbind
	假設你有兩個5X2的Matrix A,B
	rbind(A,B)#會產生5X4的陣列
	cbind(A,B)#會產生10X2的陣列

####apply
	apply(matrix,[1,2],function) #2=>column,1=>row

####matrix 常用方法
	t(A) #轉制矩陣
	eigen(A) #eigen value

###問題
1. 什麼是factor??????
