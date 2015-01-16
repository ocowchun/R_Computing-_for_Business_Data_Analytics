# spend many time!!!
dd=read.csv("/Users/ocowchun/Dropbox/nccu/R_Computing _for_Business_Data_Analytics/temp/train400k.csv",header=F)
v1=dd$V1
v3=dd$V3
v4=dd$V4
v5=dd$V5
v8=dd$V8
v10=dd$V10
v11=dd$V11
v15=dd$V15
v16=dd$V16
v17=dd$V17
v18=dd$V18
v19=dd$V19
v20=dd$V20
v21=dd$V21
v22=dd$V22
v23=dd$V23
v24=dd$V24

class=dd$V2

data=cbind(v8,v10,v11,v18,v21,v22)
attr.name=c("v8","v10","v11","v18","v21","v22")
predict=train(data,class)
validate(data,predict)