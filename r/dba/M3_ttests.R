# Hypothesis Tests - t tests

#1sample---------------
options(scipen = 99)
set.seed(100)
(scores = round(rnorm(n=30, mean=60, sd=5)))

#mu=65
#Ho : meanmarks  = 66
#Ha : meanmarks != 66

t.test(scores, mu=66)
#pvalue(.000000122 < .05) : reject Ho :

#2-sample test- Indep-----
(group = rep(c("ClassA", "classB"), each = 25))
set.seed(101)
(score <- round(c(rnorm(25, 70, 5), rnorm(25, 65, 5))))
data = data.frame(group, score)
head(data)
data %>% group_by(group)  %>% summarise(meanMarks = mean(score, na.rm=T))

t.test(score ~ group, data = data, var.equal = TRUE)  # assume equal variances

#Ho : meanA = meanB   (pv > .05)
#Ha : meanA != meanB  (pv < .05) - Answer Reject Ho

#2-sample test- Paired-----
#beforeAi and afterAi teaching
set.seed(102)
(before <- round(rnorm(30, mean=65, sd=4)))
(after <- round(before + rnorm(30, mean=3, sd=2))) #adding few values to show increase
cbind(before, after)
mean(before); mean(after)
mean(before) - mean(after)
t.test(before, after, paired = TRUE)
#Ho : meanBefore = meanAfter   (pv > .05)
#Ha : meanBefore != meanAfter  (pv < .05) - Answer Reject Ho
