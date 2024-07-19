# Sampling
pacman::p_load(tidyverse)
#Population - Stratification - Sample
#Power Analysis

#selectData ------
df <- mtcars
dim(df)
names(df)

#subsetCols------
df1 <- df %>% select(mpg, wt, hp, am, gear ) 
df1
dim(df1)
set.seed(123)
df2 <- df1 %>% group_by(gear) %>% sample_frac(.4, replace=F) %>% ungroup() #%>% group_by(gear) %>% tally()
df2 <- df2 %>% mutate(car = row_number()) %>% select(car, gear, mpg, wt, hp, am)
df2
#Population--------------------
summary(df2)

#SampleDesign-------------------

#simpleRandom--------
#only mpg of 5 cars or 30% of cars
s2 <- sample(df2$mpg, size=5, replace=F)
s2

#stratifiedSample-------
df2 %>% group_by(am) %>% tally()
df2 %>% group_by(am) %>% sample_n(size=3) # 3 rows from each am (Tx Type)
df2 %>% group_by(am) %>% slice_sample(n=3) # 3 rows from each am (Tx Type)

df2 %>% group_by(am) %>% slice_sample(prop=.4) # 40% rows from each am (Tx Type)
df2 %>% group_by(gear) %>% slice_sample(prop=.5) # 50% rows from each gear type
df2 %>% slice_sample(prop=.5, by='gear') # 50% rows from each gear type


#strata----
library(sampling)
strats1 <- strata(df2, c('gear'), size = c(3,2,1), method='srswor')
#srswor : w/o replacement; srswr:with replacement
df2[strats1$ID_unit,]
df2[strats1$ID_unit,] %>% group_by(gear) %>% tally()


#systematic----------
library(TeachingSampling)
S.SY(14, 2) #every 2nd position
S.SY(nrow(df2), 3) #every 3rd row from no of rows in data
as.integer(S.SY(nrow(df2), 3)) #convert from matrix to integer nos

df2[as.integer(S.SY(nrow(df2), 3)),]

#cluster---------
#predefined group like gear here
library(SDaA)
unique(df2$gear)

(c1 <- cluster(df2, clustername=c("gear"), size=3, method="srswor")) #3 clusters
(c1_data = getdata(df2, c1))



#https://medium.com/analytics-vidhya/sampling-methods-in-r-b3c92e580c57

#Power------
library(pwr)
?pwr.t.test
pwr.t.test(d=0.5, power=0.8, sig.level=0.05, type="two.sample", alternative="two.sided")
?pwr.chisq.test
pwr.chisq.test(w=0.3, power=0.8, df=1, sig.level=0.05)
