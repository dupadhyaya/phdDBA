#Hypothesis Testing in R
#Ho : Mean Age of Student = 15
#Ha : Mean Age of Student != 15
# Data
data <- c(12, 10, 15, 14, 18, 20, 11, 9, 17, 13)
data
length(data)
mean(data, na.rm=T)
?t.test
t.test(data, mu = 15) 
# mu is the known value (population mean) you are comparing against
#check if pvalues < 0.05 : No (pvalue > .05) . : Accept Ho : True mean = 15
# Do Not Accept alternative hypothesis: true mean is not equal to 15

# Data
group1 <- c(12, 10, 15, 14, 18, 20, 11, 9, 17, 13)
group2 <- c(18, 17, 19, 20, 22, 21, 25, 28, 29, 24)

mean(group1, na.rm=T)
mean(group2, na.rm=T)

# Hypothesis test
t.test(group1, group2)
#pvalues = .0003. <<< .05. : Reject Ho in favour of Ha 
# Ha : True means of both the groups is different

#Ho : MG1 <= MG2
#Ha : MG1 > MG2



