#measurement Scales

#nominal, ordinal, interval, ratio

#nominal----
#category without an order
#gender, color, ..
colors = c('green','yellow','red')

carColors = sample(colors, size=150, replace=T, prob=c(.3, .2, .5))
carColors
table(carColors)
barplot(table(carColors), col=1:3)
pie(table(carColors), col=1:3)
81/150
prop.table(table(carColors))

mean(carColors)
median(carColors)

library(DescTools)  #load a library
Mode(carColors)

#ordinalData-----
#Opinion, Likert, size of shirts
likert = c('Excellent','Good', 'Satisfactory','Poor')
ordData = sample(likert, size=100, replace=T, prob=c(.3, .2, .4, .1))
ordData
ordData = factor(ordData, ordered=T, levels=rev(likert))
ordData

mean(ordData)
length(ordData)

median(ordData)   #error
length(ordData)/2
ordData
sort(ordData)
sort(ordData)[50]
sort(ordData)[length(ordData)/2]

Mode(ordData)
table(ordData)


#interval-----
#temp in C

tempC = sample.int(n=50, size=100, replace=T)
tempC

mean(tempC)
median(tempC)
Mode(tempC)
table(tempC)
sd(tempC)

sd(c(100,102))

#ratio-----
#height, age, weight, salary, earnings
salary = round(runif(n=100, min=1000, max=1200))
salary

mean(salary)
median(salary)
Mode(salary)
range(salary)
min(salary)
max(salary)

