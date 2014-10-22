###Q1. (20%) Two six-sided dice are thrown sequentially, and the face values that come up are recorded.
####(a) List the sample space.
{1,1},{1,2},{1,3},{1,4},{1,5},{1,6},{2,1},{2,2},{2,3},{2,4},{2,5},{2,6},{3,1},{3,2},{3,3},{3,4},{3,5},{3,6},{4,1},{4,2},{4,3},{4,4},{4,5},{4,6},{5,1},{5,2},{5,3},{5,4},{5,5},{5,6},{6,1},{6,2},{6,3},{6,4},{6,5},{6,6},

####(b) List the elements that make up the following events: 
(1) A=the sum of the two values is at least 5
{1,4},{1,5},{1,6},{2,3},{2,4},{2,5},{2,6},{3,2},{3,3},{3,4},{3,5},{3,6},{4,1},{4,2},{4,3},{4,4},{4,5},{4,6},{5,1},{5,2},{5,3},{5,4},{5,5},{5,6},{6,1},{6,2},{6,3},{6,4},{6,5},{6,6},

(2) B=the value of the first die is higher than the value of the second
{2,1},{3,1},{3,2},{4,1},{4,2},{4,3},{5,1},{5,2},{5,3},{5,4},{6,1},{6,2},{6,3},{6,4},{6,5},

(3) C=the first value is 4.
{4,1},{4,2},{4,3},{4,4},{4,5},{4,6},

####(c)Listtheelementsofthefollowingevents:
(1)\\(A \cap C\\)
{4,1},{4,2},{4,3},{4,4},{4,5},{4,6},

(2)\\(B \cup C\\)
{2,1},{3,1},{3,2},{4,1},{4,2},{4,3},{4,4},{4,5},{4,6},{5,1},{5,2},{5,3},{5,4},{6,1},{6,2},{6,3},{6,4},{6,5},

(3)\\(A \cap (B \cup C) \\)
{3,2},{4,1},{4,2},{4,3},{4,4},{4,5},{4,6},{5,1},{5,2},{5,3},{5,4},{6,1},{6,2},{6,3},{6,4},{6,5},

####(d)Based on the classical approach,derive \\(P(A \cap C), P(B \cup C),and P(A \cap (B \cup C)) \\). 
 
 \\(P(A \cap C) \\)=1/6
 \\(P(B \cup C)\\)=1/2
 \\(P(A \cap (B \cup C)) \\)=4/9


####(e) Use the `sample` function to simulate the throwing of two dice 1,000 times.Compute \\(P(A \cap C), P(B \cup C),and \,P(A \cap (B \cup C)) \\) from the 1,000 runs (i.e., the relative frequency approach). How different are the results from (d) (show me the R code in the .R file)?
```r
n=1000
d1=sample(6,n,replace=T)

d2=sample(6,n,replace=T)

result=cbind(d1,d2)

#"P(A and C)= "
p1.sample=length(result[(d1==4&d1+d2>=5),1])
p1.sample=p1.sample/n
print(paste0("sample P(A and C)= ",p1.sample))
print(paste0("different between classical approach and sample:",(p1/36)-p1.sample))
#P(B or C)
p2.sample=length(result[(d1>d2|d1==4),1])
p2.sample=p2.sample/n
print(paste0("sample P(B or C)= ",p2.sample))
print(paste0("different between classical approach and sample:",(p2/36)-p2.sample))
#P("A and (B or C)")
p3.sample=length(result[d1+d2>=5&(d1>d2|d1==4),1])
p3.sample=p3.sample/n
print(paste0("sample P(A and (B or C))= ",p3.sample))
print(paste0("different between classical approach and sample:",(p3/36)-p3.sample))
```

###Q2. (20%) Use the choose function in R to answer (c), (d), and (e) 
####(a)Prove Bonferroni’sinequality: \\( P (A \cap B) \geq P(A) + P(B) -1 \\)
\\(
P(A \cap B) \leq 1 \\
P(A)+P(B)=P(A \cup B) + P(A \cap B) \leq 1 + P(A \cap B)
\\)
所以
\\(
 P(A \cap B)+1 \geq P(A)+P(B)
\\)
兩邊減一
\\(
 P(A \cap B) \geq P(A)+P(B) -1 
\\)

###(b) The first three digits of a university telephone exchange are 452. What is the probability that a randomly selected university phone number contains seven distinct digits?
\\(
P^7_4/10^4 =7*6*5/10000=0.021
\\)

###(c) How many different meals can be made from four kinds of meat, six vegetables, and three starches if a meal consists of one selection from each group?
```r
choose(4,1)*choose(6,1)*choose(3,1)
```

###(d) A committee consists of five Chicanos, two Asians, three African Americans, and two Caucasians. A subcommittee of five is chosen at random. What is the probability that all the ethnic groups are represented on the subcommittee?
```r
total=5+2+3+2
choose(5,1)*choose(2,1)*choose(3,1)*choose(2,1)*choose(total-4,1)/choose(total,5)
```

###A drawer of socks contains seven black socks, eight blue socks, and nine green socks. Two socks are chosen in the dark. 
####What is the probability that they match?
```r
socks.total=7+8+9
(choose(7,2)+choose(8,2)+choose(9,2))/choose(socks.total,2)
```
####What is the probability that a black pair is chosen?
```r
(choose(7,2))/choose(socks.total,2)
```
