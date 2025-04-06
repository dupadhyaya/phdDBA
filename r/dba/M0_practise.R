# Fateh
x = c(1:1000) #cntrl + enter to run the code
y <- c(100:2000)
#x is vector
x
max(x)
mean(x)
median(x)
sd(x)
min(y)
max(y)

df = read.csv(file = file.choose())
df
library(DescTools)
Mode(df$gender)
table(df$gender) #nominal

Mode(df$grades)
table(df$grades) #ordinal
length(df$grades)/2
sort(df$grades)[round(length(df$grades)/2)]
median(df$grades)
#------
#count, mode, median, mean, sd, min, max
df
mean(df$temp)
max(df$temp)
min(df$temp)
Mode(df$temp)
median(df$temp)
sort(df$temp) 
#df= read.csv(file='/Users/du/dup/analytics/projects/phdDBA/r/dba/students.csv')

# Things being in Excel--------
# avg, min, max, median, mode
# pivot, trend analysis, 
# formatting, report 
# search, Top X 
# text start, partial text

#----------------
data = read.csv('https://raw.githubusercontent.com/dupadhyaya/phdDBA/refs/heads/main/data/students.csv')

head(data)
str(data)
