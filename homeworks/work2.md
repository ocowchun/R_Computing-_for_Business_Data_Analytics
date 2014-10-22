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
