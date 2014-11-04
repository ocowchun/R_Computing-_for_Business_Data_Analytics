# # win=sample(c(-1,1),size=50,replace=T)

# # cum.win=cumsum(win)


# par(mfrow=c(2, 2)) 
# for(j in 1:4){
# 	win=sample(c(-1, 1), size=50, replace=TRUE) 
# 	plot(cumsum(win), type=‘l’, ylim=c(-15, 15))
# 	abline(h=0)  

# }


snoopy=function(n=50){
	win=sample(c(1,-1),size=n,replac=T)
	sum(win)
}

F=replicate(1000,snoopy())
table(F)
# plot(table(F))
sum(F==0)/1000
dbinom(25,50,0.5)




snoopy.refine=function(n=50){
	win=sample(c(1,-1),size=n,replac=T)
	cum.win=cumsum(win)
	c(F=sum(win),L=sum(cum.win>0),M=max(cum.win))
}

S=replicate(1000, snoopy.refine())

print("(a) What is the likely number of tosses where Snoopy will be in the lead?")
print(mean(S["L", ]))

print("(b) What will be the value of Snoopy’s highest fortune during the game?")
print(mean(S["M",]))

print("(c) How likely Snoopy will have a maximum cumulative earning > 10?")
print(sum(S["M",]>10)/1000)


# Suppose 7-11 announces a new set of Hello kitty magnets. The set has 101 unique magnets in total.
 # You can either buy random magnets (some of which could be repetitive) from 7-11 at cost.r=5 per magnet,
  # or buy non-repetitive magnets from the dealer at cost.n=25 per magnet. The stochastic total cost will be

collect=function(n.purchased){
	cost.r=5
	cost.d=25
	magnet.number=101
	cardsbought=sample(1:magnet.number,size=n.purchased,replace=T)
	n.hit=length(unique(cardsbought))
	n.missed=magnet.number-n.hit
	cost.r*n.purchased+cost.d*n.missed
}

# You decide to purchase 500 cards from 7-11 (good luck). The distribution of costs will be
costs=replicate(1000, collect(500)) 
summary(costs)

# If you just buy the set from the dealer, the cost is 25*101=2525 dollars.
 # What is your chance of spending <= 2525 if you buy 500 cards randomly from 7-11 first?
sum(costs<=2525)/1000

#Simulating discrete random variables
ra=function(){
	while(cdf(x)<runif())
}
