
rollno = 1:100
rollno

set.seed(105)
(selected = sample(x=rollno, size=10, replace=F))
sum(selected)


#Hypothesis
#t-tests = 1sample, 2sample(Indep, Paired) - mean
#anova - 1factor,  > 1factor with different level
#method, gender :
#Ho, Ha, p-value
