#measurement Scales

#nominal, ordinal, interval, ratio

#nominal
colors = c('green','yellow','red')
carColors = sample(colors, size=100, replace=T, prob=c(.3, .2, .5))
carColors
mean(carColors)
median(carColors)

library(DescTools)
