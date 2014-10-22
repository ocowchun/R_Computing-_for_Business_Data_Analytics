#Q1. (20%) Two six-sided dice are thrown sequentially, and the face values that come up are recorded.
# (a) List the sample space.
for(i in 1:6)
{
	for(j in 1:6)
	{
		print(paste0("{", i,",",j,"}"))
	}
}

# (b) List the elements that make up the following events: 
# (1) A=the sum of the two values is at least 5
print("A=the sum of the two values is at least 5:")
for(i in 1:6)
{
	for(j in 1:6)
	{
		if(i+j>=5){
			print(paste0("{", i,",",j,"}"))
		}
	}
}


# (2) B=the value of the first die is higher than the value of the second,

print("B=the value of the first die is higher than the value of the second,")
for(i in 1:6)
{
	for(j in 1:6)
	{
		if(i>j){
			print(paste0("{", i,",",j,"}"))
		}
	}
}

# (3) C=the first value is 4.
print("C=the first value is 4.")
for(i in 1:6)
{
	for(j in 1:6)
	{
		if(i==4){
			print(paste0("{", i,",",j,"}"))
		}
	}
}

# (1)\\(A \cap C\\)
print("A and C")
for(i in 1:6)
{
	for(j in 1:6)
	{
		if(i==4&&i+j>=5){
			print(paste0("{", i,",",j,"}"))
		}
	}
}
# (2)\\(B \cup C\\)
print("B or C")
for(i in 1:6)
{
	for(j in 1:6)
	{
		b=i>j
		c=i==4
		if(b||c){
			print(paste0("{", i,",",j,"}"))
		}
	}
}

# (3)\\(A \cap (B \cup C) \\)
print("A and (B or C)")
for(i in 1:6)
{
	for(j in 1:6)
	{
		a=i+j>=5
		b_or_c=(i>j)||(i==4)
		if(a && b_or_c){
			print(paste0("{", i,",",j,"}"))
		}
	}
}

#(d)Based on the classical approach,derive \\(P(A \cap C), P(B \cup C),and P(A \cap (B \cup C)) \\). 
#"P(A and C)= "
p1=0
for(i in 1:6)
{
	for(j in 1:6)
	{
		if(i==4&&i+j>=5){
			p1=p1+1
		}
	}
}
print(paste0("P(A and C)= ",p1,"/36"))

#P(B or C)
p2=0
for(i in 1:6)
{
	for(j in 1:6)
	{
		b=i>j
		c=i==4
		if(b||c){
			p2=p2+1
		}
	}
}
print(paste0("P(B or C)= ",p2,"/36"))

#P("A and (B or C)")
p3=0
for(i in 1:6)
{
	for(j in 1:6)
	{
		a=i+j>=5
		b_or_c=(i>j)||(i==4)
		if(a && b_or_c){
			p3=p3+1
		}
	}
}
print(paste0("P(A and (B or C))= ",p3,"/36"))

#(e) Use the `sample` function to simulate the throwing of two dice 1,000 times.Compute \\(P(A \cap C), P(B \cup C),and \,P(A \cap (B \cup C)) \\) from the 1,000 runs (i.e., the relative frequency approach). How different are the results from (d) (show me the R code in the .R file)?
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
