# cronbach alpha
#Cronbach’s alpha is a measure of internal consistency, that is, how closely related a set of items are as a group.    It is considered to be a measure of scale reliability. 
#Cronbach's alpha is a way to measure the internal consistency of a survey or questionnaire. It can help determine whether variables are homogeneous
#https://www.geeksforgeeks.org/how-to-calculate-cronbachs-alpha-in-r/

library(dplyr)
library(ltm)
LSAT

?cronbach.alpha
cronbach.alpha(LSAT, CI=T, B=500)


# create sample data
sample_data <- data.frame(var1=c(1, 2, 1, 2, 1, 2, 1, 3, 3, 1, 4),   var2=c(1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3), var3=c(2, 1, 3, 1, 2, 3, 3, 4, 4, 2, 1))
sample_data
cronbach.alpha(sample_data)
#Here, the alpha value of 0.231 means that the sample_data dataset is highly inconsistent
cronbach.alpha(sample_data, CI=TRUE, standardized=TRUE)


library(psych)
alpha(sample_data)


library(psy)
cronbach(sample_data)

#eg2----
##https://www.youtube.com/watch?v=JkOiLUZkutc
item1 = c(6,5,9,3,2,1,5)
item2 = c(6,5,8,2,3,1,4)
item3 = c(8,6,6,4,2,2,6)
df2 = data.frame(item1,item2, item3)
df2

lapply(df2, var)
colSums(df2)
rowSums(df2)
df2B <- df2 %>% rowwise() %>% mutate(total = item1 + item2 + item3)
df2b
lapply(df2B, var)

(S2y = var(df2B$total))
(SumS2i = sum(var(df2B$item1), var(df2B$item2), var(df2B$item3)))

(k=3)
(k/(k-1)) * (S2y - SumS2i)/ S2y
cronbach(df2)
#good value is closer to 1
?lapply
#links
#https://www.youtube.com/watch?v=W9uPvAmtTOk
