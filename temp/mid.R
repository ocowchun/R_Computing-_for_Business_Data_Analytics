##Q1
#(a)= \lambda/k

#(b)
dpos2=function(n,lambda){
	if(n>0){
		return (dpos2(n-1,lambda)*lambda/k)
	}
	else{
		return (exp(-lambda))
	}

}

# Q2. (20%) (a) NCCU issues professors identical-looking keys to various doors. 
# A professor has 5 keys on his key ring and only one will open the door to his office.
 # He tries a key selected at random to see if it unlocks the door.
  # If unsuccessful, he always drops the key ring so that he cannot identify the key 
# that he tried before and must again try a key at random from the key ring.
 # Let a random variable X denote the number of attempts that it takes for him 
# to successfully unlock his door. Show me the probability density function of X 
# as well as the possible range of x.


dkey=function(x){
	(.8)^(x-1)*.2
}


# (b) A couple has three children. Births are independent with the probability of a boy being 0.5
# for each birth. First, obtain the probability that all three children are boys if you know that
# the number of boys is odd (奇數). Second, obtain the probability that the first-born child is
# a boy if you know that the family has at least one boy 
# (Hint: Write out the sample space would help).
1/2
4/7

# Q3
# you haveproventhememorylessproperty P(X st|X s)P(X t) inHW3.Now,wewantto
# verify the property by simulating 5000 exponential random numbers from rexp(5000, rate)
 # where rate is a positive number. Show me the R codes you will write to verify the idea.
lambda=0.5
s=2
t=5
s.exp=pexp(t,lambda)
data=rexp(5000,lambda)
p.ideal=1-pexp(t,lambda)
p.sample=length(data[data>s+t])/length(data[data>s])

# q5 Not Feasible
pdf=function(x,theta){
	if(x>1||x<1){
		return ("Not Feasible")
	}
	if(theta<=1){
		return ("Not Feasible")

	}
	return (theta*x*(theta-1))
}