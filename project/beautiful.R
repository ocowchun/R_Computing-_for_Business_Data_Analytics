tree=function(data,class,str=c()){

	data.entropy=c()
	for(i in 1:length(data[1,])){
		data.entropy[i]=entropy(data[,i],class)
	}
	min.idx=which(data.entropy==min(data.entropy))[1]
	attr.selected=data[,min.idx]
	attr.val=unique(attr.selected)
	result=c()
	for(i in 1:length(attr.val)){
		val=attr.val[i]
		data.set=seprate(min.idx,val,data,class)
		str1=c(str,c(attr.name[min.idx],val))

		if(all(is.na(data.set$data[1,]))){
			cl=round(mean(data.set$class)+0.1)

			if(cl==1)#只顯示會買的
			{
				print(str1)
				result=cbind(result,str1)

			}
		}else{
			result=cbind(result,tree(data.set$data,data.set$class,str1))
		}

	}
	result	
}
