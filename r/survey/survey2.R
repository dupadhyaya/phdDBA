# Suvey2

#https://www.youtube.com/watch?v=Djta5-Ilm24
#http://users.stat.umn.edu/~gmeeden/classes/5201/handouts/survey_handout.pdf
library(survey)
data.entry()

set.seed(1)
y <- c(rnorm(500),rnorm(500,mean=5))
x <- y + rnorm(1000)
group <- c(rep('a',500),rep('b',500))
pop <- data.frame(group,x,y)

srs.rows <- sample(1000,100)
srs <- pop[srs.rows,]
str.rows <- c(sample(500,50),sample(501:1000,50))
str <- pop[str.rows,]
fpc.srs = rep(1000,100)
des.srs <- svydesign(id=~1,strata=NULL,data=srs,fpc=fpc.srs)
des.srs

svytotal(~y, design=des.srs)
svymean(~y, design=des.srs)
confint(svytotal(~y,design=des.srs))
known.x.total <- sum(pop$x)
(srs.ratio <- svyratio(numerator=~y,denominator=~x,design=des.srs))


#stratfied Sampling----
fpc.str <- rep(500,100)
des.str <- svydesign(id=~1,strata=~group,data=str,fpc=fpc.str)
svytotal(~y,des.str)
predict(svyratio(numerator=~y,denominator=~x,design=des.str), total=known.x.total)




#-----------
#https://www.geeksforgeeks.org/survey-package-in-r/
library(survey) 

# Load a sample survey dataset included with the package 
data(api)
apipop
# Create a survey design object 
api_design <- svydesign(id = ~1, strata = ~stype, weights = ~pw, data = apistrat,    fpc = ~fpc) 

# Calculate weighted descriptive statistics 
# Calculate the weighted mean of enrollment 
svymean(~enroll, design = api_design)  
