# Example: A computer system uses passwords of five characters, each being one of a-z or 0-9.
#  The first character must be a letter. Assume passwords are NOT case sensitive.
# Find the probabilities that 

# (A) a password begins with a vowel (a, e, i, o, u);; 
# 5/26

# (B) ends with an odd number (1, 3, 5, 7, 9);; and 
#  5/(26+10)=5/36

# (C) begins with vowel or ends with an odd number.
# P(A or B)=P(A)+P(B)-P(A & B)
# 5/26+5/36-(5/26*5/36)




f=function(X){
	x^(1/3)


}

# plot(x,y,type='l')
# Root finding
# library(rootSolve)
# uniroot.all

# Example: To obtain a model for campus Internet security in NCCU, the number of attacks occurring each week was observed over a period of 1 year. It was found that
# 0 attacks occurred in each of 9 weeks; 1 attack occurred in each of 14 weeks 2 attacks occurred in each of 13 weeks; 3 attacks occurred in each of 9 weeks 4 attacks s occurred in each of 4 weeks; 5 attacks occurred in each of 2 weeks 6 attacks occurred in each of 1 weeks
# By obtaining the relative frequency of attacks, we can estimate the distribution using R 
 attacks=c(9, 14, 13, 9, 4, 2, 1)
 probability=attacks/sum(attacks)
 probdens=round(probability, 2)

# Visualize the pdf > Attacks=0:6
plot(0:6, probdens, xlab= "# of attacks per week", ylab= "p(x)", type= "h")

# For the aforementioned number of attacks, write out the cdf.
cumprob=cumsum(probdens)
plot(0:6, cumprob, xlab= "# of attacks", ylab= "probability", type= "S")

# compute the expected values
 x=0:6
 sum(x*probability)

# We can further simulate the mean and variance.
attacks_100=sample(c(0:6), 100, replace=T, prob=probability)

# sim 
sum1=rgeom(100,prob=0.03)