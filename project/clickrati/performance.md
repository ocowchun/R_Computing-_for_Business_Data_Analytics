##NB
{ FP: 143146, TN: 188880, TP: 47679, FN: 20296 }
precision:0.24985719900432332
reacll:0.7014196395733726
accuracy:0.5913960215099462

###test2
return [line[3], line[4], line[7], line[9], line[10], line[14], line[15], line[16], line[17], line[18], line[19], line[1]*1];
{ FP: 29168, TN: 302858, FN: 51091, TP: 16884 }
precision:0.3666290280552419
reacll:0.24838543582199338
accuracy:0.799353001617496

###test5
{ FP: 29644, TN: 302382, FN: 50963, TP: 17012 }
precision:0.36462620027434844
reacll:0.25026848105921295
accuracy:0.7984830037924905

###test6
month, day, hh, line[3], line[4], line[7], line[9], line[10],
			line[14], line[15], line[16], line[17], line[18], line[19],line[20],line[21], line[1]*1
{ FP: 49882, TN: 282144, FN: 44218, TP: 23757 }
precision:0.32261437553470307
reacll:0.3494961382861346
accuracy:0.7647505881235297

##decision tree
V4,V20
{ TN: 329095, FN: 64457, FP: 2930, TP: 3518 }
precision:0.5455955334987593
reacll:0.05175432144170651
accuracy:0.8315325

###test2:1,3,4,5,8,10,11,15,16,17,18,19~24
####修正為葉節點比數多於一筆,葉節點的平均值+0.2四捨五入
{ TN: 297095, FN: 45175, FP: 34930, TP: 22800 }
precision:0.394941971245453
reacll:0.3354174328797352
accuracy:0.7997375