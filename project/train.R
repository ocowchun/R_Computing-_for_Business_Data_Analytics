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

# Real T=67975
##test1
data=cbind(v8,v10,v11,v18,v21,v22)
attr.name=c("v8","v10","v11","v18","v21","v22")
# # 要跑在uncomment
predict=train(data,class)
# { TN: 329737, FN: 64624, TP: 3351, FP: 2288 }
# precision:0.5942543004078737
# reacll:0.049297535858771606
# accuracy:0.83272

##test2
# 1,3,4,5,8,10,11,15,16,17,18,19~24
data=cbind(v4,v5,v8,v10,v11,v15,v16,v17,v18,v19,v20)
attr.name=c("v4","v5","v8","v10","v11","v15","v16","v17","v18","v19","v20")
# # 要跑在uncomment
predict=train(data,class)
# { TN: 327406, FN: 60849, TP: 7126, FP: 4619 }
# precision:0.6067262664963814
# reacll:0.10483265906583303
# accuracy:0.83633

# 修正為葉節點比數多於一筆,葉節點的平均值+0.2四捨五入
# { TN: 297095, FN: 45175, FP: 34930, TP: 22800 }
# precision:0.394941971245453
# reacll:0.3354174328797352
# accuracy:0.7997375


##test3
data=cbind(v3,v4,v5,v8,v10,v11,v17,v21,v22)
attr.name=c("v3","v4","v5","v8","v10","v11","v17","v21","v22")
# # 要跑在uncomment
predict=train(data,class)
# RangeError: Maximum call stack size exceeded


# 20,21,22,24

##test4
# V4,V20
# { TN: 329095, FN: 64457, FP: 2930, TP: 3518 }
# precision:0.5455955334987593
# reacll:0.05175432144170651
# accuracy:0.8315325

# test5
# return [month, day, hh, line[3], line[4], line[7], line[9], line[10],
		# 	line[14], line[15], line[16], line[17], line[18], line[19], line[1]
		# ];
# { TN: 326149, FN: 59467, FP: 5876, TP: 8508 }
# precision:0.5914905450500556
# reacll:0.12516366311143803
# accuracy:0.8366425
# [Finished in 46.8s]

# 葉節點比數多於5筆,葉節點的平均值+0.2四捨五入
# { TN: 306262, FN: 49653, FP: 25763, TP: 18322 }
# precision:0.4156062152659635
# reacll:0.26954027215888193
# accuracy:0.81146