# Module M1 : Research
library(modeest)
library(DescTools)

#Measurement Scale-------
#R Functions-------
(gender = c('M', 'F', 'M', 'F', 'M', 'F', 'F', 'F', 'F', 'F'))
table(gender)
modeest::mlv(gender)
Mode(gender)

#mean(gender)
(grades = c('A','B','C','D','B','C','A','B','B','D'))
mean(grades)
modeest::mlv(grades)
Mode(grades)
median(grades)
(grades2 = factor(grades, ordered=T, levels=c('A','B','C','D')))
median(grades2)
sort(grades2)
sort(grades2)[length(grades2)/2]

temp = c(1,2,0,4,5,2,7,8,0,7, 0, 9,0)
table(temp)
mean(temp)
modeest::mlv(temp)
Mode(temp)
temp[6]- temp[5]

marks = c(10, 20, 30, 15, 45, 20, 30, 30, 20, 19)
table(marks)
mean(marks)
modeest::mlv(marks)
Mode(marks)
median(marks)
marks[5]/marks[2] 
marks[5]-marks[2]

##Cattemperature##Cat-1-----
###Qualitative Data------

###Quantitative Data------

#Cat-2-----
#Nominal Scale------
#count, mode, freq, =, !=

#Ordinal Scale------
# +above, median, <,>, Rank Correlation

#Interval Scale------
# +above, +,-,/, *correlation, regression, mean,


#Ratio Scale------
# +above; other types of means, ratio, 

