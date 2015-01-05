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


##test1
data=cbind(v8,v10,v11,v18,v21,v22)
attr.name=c("v8","v10","v11","v18","v21","v22")
# # 要跑在uncomment
predict=train(data,class)
# P:7000多 TP:2400

##test2
# 1,3,4,5,8,10,11,15,16,17,18,19~24
data=cbind(v4,v5,v8,v10,v11,v15,v16,v17,v18,v19,v20)
attr.name=c("v4","v5","v8","v10","v11","v15","v16","v17","v18","v19","v20")
# # 要跑在uncomment
predict=train(data,class)
# P:4707 TP:1036
# 

##test3
data=cbind(v3,v4,v5,v8,v10,v11,v17,v21,v22)
attr.name=c("v3","v4","v5","v8","v10","v11","v17","v21","v22")
# # 要跑在uncomment
predict=train(data,class)

# 20,21,22,24