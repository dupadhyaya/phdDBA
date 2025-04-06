# Examples of Sampling
#pl install the libraries and see that they loaded
#library------
pacman::p_load(randomNames, dplyr, tigerstats)

#data------------
rollno <- 1:100
school <- sample(c('School1','School2','School3'), 100, replace = T)
name <- randomNames(100, ethnicity = 'Asian', name.order='first.last')
gender <- sample(c('M', 'F'), 100, replace = T)
age <- sample(15:20, 100, replace = T)
maths <- sample(50:100, 100, replace = T)
science <- sample(50:100, 100, replace = T)
class <- sample(10:12, 100, replace = T)
section <- sample(LETTERS[1:3], 100, replace = T)
city <- sample(c('Mumbai', 'Delhi', 'Chennai','Dubai', 'Muscat'), 100, replace = T)
students <- data.frame(school, rollno, class, section, name, gender, age, maths, science, city)
head(students,3)
names(students)

students %>% group_by(class, section) %>% summarise(n=n(), mean_age = mean(age), mean_maths = mean(maths), mean_science = mean(science))


#-----------
mean(students$age)
mean(students$maths)
Mode(students$maths)
table(students$school)
colMeans(students[,c('age', 'maths', 'science')])
names(students)
write.csv(students, './/data/students.csv', row.names = F)

#if you load the file, read it from git
students <- read.csv('https://raw.githubusercontent.com/dupadhyaya/phdDBA/refs/heads/main/data/students.csv')
dim(students)
#simplerandom--------

#simple random sample of 10 students
set.seed(123)
students %>% slice_sample(n=10)


#systematic------
(start=3);(diff=5)
students %>% arrange(rollno) %>% slice(seq(start, n(), by=diff)) %>% select(rollno, name, school)

#stratified------
students %>% group_by(school) %>% slice_sample(n=2) %>% select(rollno, name, school)

table(students$gender)
students %>% group_by(gender) %>% slice_sample(prop=.1) %>% select(rollno, name, school, gender)

students %>% group_by(school, class) %>% slice_sample(n=1) %>% select(rollno, name, school, class, gender)
students

#install tigerstats-----
#install.packages("devtools")
#devtools::install_github("homerhanumat/tigerstats")
library(tigerstats)
males = subset(students, gender=='M')
females = subset(students, gender == 'F')
#we can take 4 from Males and 3 from females
(M4 = popsamp(n=3, pop=males))
(F3 = popsamp(n=4, pop=females))


#cluster------
(clusters <- students %>% distinct(city))
(sampled_sections <- sample(clusters$city, size = 2))
students %>% filter(city %in% sampled_sections)
#Stratified: some from all groups
#Cluster: all from some groups


#NON_PROBABILITY SAMPLING---------
#convenience------  
students %>% slice_head(n=5) %>% select(rollno, name, school, class)

#quota----
students %>% group_by(gender) %>% slice_head(n=3) %>% ungroup() %>% select(rollno, name, school, class, gender)

students %>% group_by(school, gender) %>% slice_head(n=2) %>% ungroup() %>% select(rollno, name, school, class, gender)

students %>% filter(gender == 'M') %>% slice_head(n = 5)  %>% select(rollno, name, school, class, gender)
students %>% filter(gender == 'F') %>% slice_head(n = 4) %>% select(rollno, name, school, class, gender)

#snowball------
#little difficult to understand
library(snowboot)
?artificial_networks
net <- artificial_networks[[1]]
net
a <- sample_about_one_seed(net, seed = 12, n.wave = 2)
a

#sampleSize---------
library(pwr)
#Factors---------
#   - Effect size (Cohen's d) = 0.5
#   - Significance level (alpha) = 0.05
#   - Desired power = 0.80
#   - Alternative hypothesis: one.sample, two.sided

#Example:  One-sample t-test-------
#Input: d= 0.5, a=.05, power=0.8, alternative=two.sided, type=one.sample
pwr.t.test(d = 0.5, sig.level = 0.05, power = 0.80, alternative = "two.sided", type = "one.sample") #n=33 samples
#samples size-34
