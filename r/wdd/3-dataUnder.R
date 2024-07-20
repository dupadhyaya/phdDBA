# Data Understanding

#LoadData-------
#csv, excel...
#here inbuilt data is used

mtcars
?mtcars

#size------
object.size(mtcars) #much less than csv
dim(mtcars) #row/cols
nrow(mtcars)
ncol(mtcars)
length(mtcars) # cols
names(mtcars) #name of cols

#glimpse------
head(mtcars) #first x row
tail(mtcars,3) #last x rows
glimpse(mtcars)

#describe-----
class(mtcars)
str(mtcars)
summary(mtcars)

#advanced------
Hmisc::describe(mtcars)
pastecs::stat.desc(mtcars)
psych::describe(mtcars)
skimr::skim(mtcars)
#summarytools::descr(mtcars)

#MissingValues----
colSums(is.na(mtcars))

#visualSummary-----


#correlation----
cor(mtcars)

#more functions available in libraries
library(modelsummary)
datasummary_skim(mtcars)
datasummary_correlation(mtcars)
library(correlation)
datasummary_crosstab(gear ~ carb, data = mtcars)
#end----------

