#hypothesis tests
#Z, t- 1 sample, 2 sample
options(scipen = 99)
df3 <- mtcars %>% select(mpg, gear, hp)
df3

mean(df3$mpg)
sort(df3$mpg)
#ttest- 1S -----
data <- c(12, 10, 15, 14, 18, 20, 11, 9, 17, 13)
t.test(data, mu = 15) #mu is population mean 
#sample data has mean of population (True here)

#ttest- 2S --------
group1 <- c(12, 10, 15, 14, 18, 20, 11, 9, 17, 13)
group2 <- c(18, 17, 19, 20, 22, 21, 25, 28, 29, 24)
t.test(group1, group2)
#mean of both gps are same ie diff=0 (Reject here)
mean(group1); mean(group2)

#ttest - Paired-------
pre_treatment <- c(12, 10, 15, 14, 18, 20, 11, 9, 17, 13)
post_treatment <- c(14, 12, 17, 16, 20, 22, 13, 11, 19, 15)
t.test(pre_treatment, post_treatment, paired = TRUE)




#-------
t.test(df3$mpg, mu=16)

#Ho = Mean Mileage is 16
#95% confid that mpg lies between 17 & 22
#its  true here; Accept Ho
#p-value  > .05 (.9328)

#in hypothesis we consider sample size and values combined

t.test(df3$mpg, mu=16, alternative = 'greater') #accept
t.test(df3$mpg, mu=16, alternative = 'less') #reject



#correlation------
cor(df3$mpg, df3$hp)
cor.test(df3$mpg,df3$mpg)
#Ho: No Correlation (Reject)




#links------
#https://www.r-bloggers.com/2021/10/paired-sample-t-test-using-r/
  
