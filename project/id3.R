# age=c(1,1,1,1,1,2,2,2,2,2,3,3,3,3,3)
# job=c(0,0,1,1,0,0,0,1,0,0,0,0,1,1,0)
# house=c(0,0,0,1,0,0,0,1,1,1,1,1,0,0,0)
# credit=c(1,2,2,1,1,1,2,2,3,3,3,2,2,3,1)
# class=c(0,0,1,1,0,0,0,1,1,1,1,1,1,1,0)

age=c(1,1,2,3,3,3,2,1,1,3,1,2,2,3)
income=c(3,3,3,2,1,1,1,2,1,2,2,2,3,2)
student=c(0,0,0,0,1,1,1,0,1,1,1,0,1,0)
credit=c(0,1,0,0,0,1,1,0,0,0,1,1,0,1)
data=cbind(age,income,student,credit)

class=c(0,0,1,1,1,0,1,0,1,1,1,1,1,0)


class2=c("n","n","t","t","t","n","t","n","t","t","t","t","t","n")


ig=function(ps,ns){
	p=length(ps)
	n=length(ns)
	deno=p+n
	if(p==0||n==0){
		return (0)
	}
	else
	{
		return (-(p/deno)*log2(p/deno)-(n/deno)*log2(n/deno))
	}
}

# entropy越小越好
entropy=function(attr,class){
	if(is.na(attr[1])){
		return (100)
	}
	else{
		attr.val=unique(attr)
		val.length=length(attr.val)
		data.length=length(attr)
		result=0
		for(i in 1:val.length){
		# 屬性等於某個值
			val=attr.val[i]		
		# 屬性等於某個值的集合
			set=attr[attr==val]
		# 該集合的長度
			set.length=length(set)
		# 該集合對應的class集合
			set.c=class[attr==val]
			p=set.c[set.c==1]
			n=set.c[set.c==0]	
			result=result+(set.length/data.length)*ig(p,n)	
		}
		return (result)
	}
}

attr.name=c("age","income","student","credit")
# data=list(age=age,income=income)
tree=function(data,class,str=c()){
# print("tt")
# find attr with min entropy
	data.entropy=c()
	for(i in 1:length(data[1,])){
		data.entropy[i]=entropy(data[,i],class)
	}
	# print(data.entropy)
	# min.idx=min.entropy(data.entropy)
	min.idx=which(data.entropy==min(data.entropy))[1]
	# print(min.idx)
	# seprate
	attr.selected=data[,min.idx]
	attr.val=unique(attr.selected)
	result=c()
	for(i in 1:length(attr.val)){
		val=attr.val[i]
		# print(min.idx)
		data.set=seprate(min.idx,val,data,class)
		# str1=c(str,attr.name[min.idx],val)
		# str1=paste(str,attr.name[min.idx],val)
		str1=c(str,c(attr.name[min.idx],val))
# 如果全部的data都是na 代表結束了
		# print("QQ")
		if(all(is.na(data.set$data[1,]))){
			cl=round(mean(data.set$class))
			if(cl==1)#只顯示會買的
			{
				# print(c(str,"class",cl))
				# sentence=paste(str1,"class=1")
				print(str1)
				result=cbind(result,str1)#[length(result)+1]=paste(str1)

			}
		}else{
			# print("t2")
			result=cbind(result,tree(data.set$data,data.set$class,str1))
		}

	}
	result
	
}

train=function(data,class){
	guides=tree(data,class)
	learn(guides)
}

min.entropy=function(data.entropy){
	m=min(data.entropy)
	idx=1
	for(i in 1:length(data.entropy)){
		if(data.entropy[i]==m){
			idex=i
		}
	}
	idx
}

# seprate(1,1,data,class)
seprate=function(idx,val,data,class){
	attr.selected=data[,idx]
	attr.val=unique(attr.selected)
	result=c()
	for(i in 1:length(data[1,])){
		if(i==idx){
			result=cbind(result,rep(NA,length(which(attr.selected==val))))
		}
		else{
			c1=data[,i][attr.selected==val]
			result=cbind(result,c1)
		}
	}
	list(data=result,class=class[attr.selected==val])
}

isEq=function(feature,val){
	function(data){
		result=c()
		for(i in 1:length(feature)){
			result[i]=(data[feature[i]]==val[i])
		}
		all(result==T)
	}
}

predict.one=function(guide){
	guide.l=length(guide)/2
	feature=c()
	val=c()
	for(i in 1:guide.l){
		feature[i]=guide[i*2-1]
		val[i]=guide[i*2]
	}
	isEq(feature,val)
}

learn=function(guides){
	function(data){
		classifier=list()
		result=c()
		for(i in 1:length(guides[,1])){
			key=paste('c',i,sep="")
			guide=guides[,i]
		# classifier[key]=learn.one(guide)
			result[i]=predict.one(guide)(data)
		}
	# classifier
		any(result==T)
	}

}
