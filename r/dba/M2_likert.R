# M2 Likert
#https://cran.r-project.org/web/packages/likert/likert.pdf
#https://jakec007.github.io/2021-06-23-R-likert/
#https://rcompanion.org/handbook/E_03.html
#https://jakec007.github.io/assets/files/2021-06-23-R-likert.pdf

#load packages
pacman::p_load(likert, tidyverse, psych)

#load data
Data

data(pisaitems)
head(pisaitems,2)
?pisaitems
dim(pisaitems)
names(pisaitems)
items28 <- pisaitems[,1:28]
p <- pisaitems[, substr(names(pisaitems), 1, 5) == "ST24Q"] 
head(p)
plot(p)
