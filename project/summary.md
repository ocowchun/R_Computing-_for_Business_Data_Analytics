id: ad identifier
click: 0/1 for non-click/click
hour: format is YYMMDDHH, so 14091123 means 23:00 on Sept. 11, 2014 UTC.
C1 -- anonymized categorical variable
banner_pos
site_id
site_domain
site_category
app_id
app_domain
app_category
device_id
device_ip
device_model
device_type
device_conn_type
C14-C21 -- anonymized categorical variables


#100個樣本
> unique(data$V3)
[1] 14103023
> unique(data$V4)
[1] 1005 1002
> unique(data$V5)
[1] 0 1

 unique(data$V6)
22 Levels: 0a742914 0eb72673 16c73019 1fbe01fe 517b8671 5b08c53b 6c5b482c 7294ea0f ... f61eaaae

 unique(data$V7)
20 Levels: 510bd839 58a89a43 5c9ae867 6b59f079 7256c623 75f9ddc3 7687a86e 7e091613 ... f3845767

> unique(data$V8)
[1] 50e219e0 f028772b 3e814130 28905ebd
Levels: 28905ebd 3e814130 50e219e0 f028772b

unique(data$V9)
18

unique(data$V10)
8

unique(data$V11)
6

V12:17
13:98
14:79
15:2
16:3
17:56
18:2
19:2
20:39
21:3
22:18
23:25
24:12



#ROCR

```r
#第一個參數是n個0~1的數字,第2參數是
> pred=prediction(runif(872),SwissLabor$participation)

#繪圖
> dev.new(width=12,height=5)
> par(mfrow=c(1,2))
> plot(performance(pred,"acc"))
> plot(performance(pred,"tpr","fpr"))
> abline(0,1,lty=2)
```




一共有40428967筆

可行的屬性
8,9,10,11,17,18,20,21,22,24
9,17,20的value比較多
