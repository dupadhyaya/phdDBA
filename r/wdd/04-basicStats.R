#basic Stats  SOCS

#Shape(S), Outliers(O), Center(C), Spread(S)
dim(mtcars)
head(mtcars)

summary(mtcars)
#mean, median, mode
colMeans(mtcars)
apply(mtcars, 2, median)

#range, min, max
apply(mtcars, 2, range)
apply(mtcars, 2, min)
summary(mtcars)

#mode
modeest::mlv(mtcars$gear, method='mfv')
DescTools::Mode(mtcars$gear)

DescTools::Mode(mtcars$hp)

apply(mtcars, 2, DescTools::Mode)#[[1]]

#std, cov, cor
round(apply(mtcars, 2, sd),2) #round
cov(mtcars[1:5])
cor(mtcars[1:5])

M = cor(mtcars[1:5])
corrplot::corrplot(M, method = 'number')
corrplot::corrplot(M, method = 'circle')
corrplot::corrplot(M, order = 'hclust', addrect = 2)
#https://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html

#skewness, kurtosis
moments::skewness(mtcars$mpg)
moments::kurtosis(mtcars$mpg)
apply(mtcars,2, moments::kurtosis)
hist(mtcars$mpg, breaks='FD') #FD enough bars

#quantiles-------
summary(mtcars)
(mileage = mtcars$mpg)
sort(mileage)
quantile(mileage)
IQRm <- IQR(mileage)
Q1 = quantile(mileage, probs = .25)
Q3 = quantile(mileage, probs = .75)

#Outliers-----
#values < Q1 - 1.5* IQR & > # + 1.5 * IQR are outliers
mileage[ mileage < Q1 - 1.5 * IQRm | mileage > Q3 + 1.5 * IQRm ]
hist(mileage)
boxplot(mileage)
boxplot.stats(mileage)

#---
library(outliers)
grubbs.test(mileage)


#endhere------