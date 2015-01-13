# spend many time!!!
 # dd=read.csv("/Users/ocowchun/Dropbox/nccu/R_Computing _for_Business_Data_Analytics/temp/test400k.csv",header=F)

# data=cbind(dd$V8,dd$V10,dd$V11,dd$V18,dd$V21,dd$V22,dd$V24)
# class=dd$V2
# attr.name=c("V8","V10","V11","V18","V21","V22","V24")
# # 要跑在uncomment
# tree(data,class)


#  " V24 79551725819772207104 V8 2 V10 68 V11 1 V18 320 V21 0 V22 35 class=1"
# [1] " V24 2.3697831015778e+20 V8 6 V10 68 V11 1 V18 300 V21 3 V22 39 class=1"
# [1] " V24 204 V11 1 V22 39 V8 6 V10 68 V18 320 V21 0 class=1"
# [1] " V24 2.21940650776271e+21 V8 4 V10 68 V11 1 V18 320 V21 0 V22 39 class=1"
# [1] " V24 212 V8 6 V11 15 V10 113 V22 33 V18 320 V21 1 class=1"
# [1] " V24 212 V8 6 V11 9 V10 68 V18 320 V22 33 V21 1 class=1"
# [1] " V24 212 V8 8 V10 68 V11 1 V18 320 V21 0 V22 163 class=1"
# [1] " V24 126 V11 23 V8 6 V10 40 V18 320 V21 0 V22 43 class=1"
# [1] " V24 253 V11 4 V10 76 V8 6 V18 320 V21 0 V22 33 class=1"
# [1] " V24 251 V21 2 V8 2 V10 68 V11 1 V18 320 V22 35 class=1"
# [1] " V24 251 V21 2 V8 6 V18 300 V10 68 V11 1 V22 35 class=1"
# [1] " V24 246 V10 103 V21 3 V8 6 V11 4 V18 320 V22 33 class=1"
# [1] " V24 76 V10 131 V11 15 V8 6 V18 320 V21 0 V22 33 class=1"
v10.131=levels(dd$V10)[131]
v11.15=levels(dd$V11)[15]
v8.6=levels(dd$V8)[6]

dd$V2[dd$V24==76&dd$V10==v10.131&dd$V11==v11.15]


v10.103=levels(dd$V10)[103]
# v21.3=levels(dd$V10)[103]

length(dd$V2[dd$V24==246&dd$V10==v10.131&dd$V21==3])