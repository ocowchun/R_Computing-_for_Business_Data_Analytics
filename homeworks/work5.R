#Q1. (10%) Import the library AER in R, and attach the data set CPS1988 (like what you did for HW4). 
# Focus on four variables – wage, education, experience, and ethnicity (African-American versus Caucasian). 
# Your job is to finish the following tasks.
# (a) Run the linear regression model below (using lm( )) and save the model as object “CPS_lm”. 
# Note that the ethnicity is a categorical/dummy variable.
# library("AER")
# data("CPS1988")
# attach(CPS1988)
experience2=experience*experience
CPS_lm=lm(log(wage)~experience+education+experience2+as.factor(ethnicity))

# (b) Run the same model again using glm(....., family= “gaussian”). 
# Are the results different from the results from part (a)? If not, why is that?
CPS_glm=glm(log(wage)~experience+education+experience2+as.factor(ethnicity), family="gaussian")

#(c) Estimate the same model using quantile regression (section 7.5).
# Similar to what I do in 7.5, run the model from 5% quantile to 95% quantile,
# and VISUALIZE the impact of each variable on log(wage) across the whole range of quantiles. Explain what you see.
library(quantreg)
cps_f=log(wage)~experience+education+experience2+as.factor(ethnicity)
cps_rqbig=rq(cps_f, tau=seq(0.05, 0.95, 0.05), data=CPS1988)
cps_rqbigs=summary(cps_rqbig)
plot(cps_rqbigs)
