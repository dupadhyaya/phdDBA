# sampling Techniques 
#https://homerhanumat.github.io/elemStats/sampling-and-surveys.html

#random sampling

library(manipulate)
library(tigerstats)

SimpleRandom()
#visual
data(FakeSchool)

FakeSchool
summary(FakeSchool)
dim(FakeSchool)  #28 rows, 5 cols

#types of Sampling------
#Random and Non-Random
#Random - Simple Random, Systematic, Stratefied, Cluster

#this population mean
mu <- mean(FakeSchool$GPA)
mu

#SRS----------------
set.seed(1234)
srs <- popsamp(n=7, FakeSchool)
srs

xbar.srs <- mean(srs$GPA)
xbar.srs
#Strengths
#The selection of one element does not affect the selection of others.
#Each possible sample, of a given size, has an equal chance of being selected.
#Simple random samples tend to be good representations of the population.
#Requires little knowledge of the population.
##Weaknesses
#If there are small subgroups within the population, a SRS may not give an accurate representation of that subgroup. In fact, it may not include it at all! This is especially true if the sample size is small.
#If the population is large and widely dispersed, it can be costly (both in time and money) to collect the data.


#Sytematic Sampling------
set.seed(12345)
start = sample(1:4,1)
start
#start with 4th element and then select every nth row 
rowNos = seq(start, nrow(FakeSchool), 4)
ss = FakeSchool[rowNos,]
xbar.ss = mean(ss$GPA)
xbar.ss

#Strengths
#Assures an even, random sampling of the population.
#When the population is an ordered list, a systematic sample gives a better representation of the population than a SRS.
#Can be used in situations where a SRS is difficult or impossible. It is especially useful when the population that you are studying is arranged in time.
#For example, suppose you are interested in the average amount of money that people spend at the grocery store on a Wednesday evening. A systematic sample could be used by selecting every 10th person that walks into the store.
#Weaknesses
#Not every combination has an equal chance of being selected. Many combinations will never be selected using a systematic sample!
#Beware of periodicity in the population! If, after ordering, the selections match some pattern in the list (skip interval), the sample may not be representative of the population


#Stratified Sampling -----
#In a stratified sample, the population must first be separated into homogeneous groups, or strata. Each element only belongs to one stratum and the stratum consist of elements that are alike in some way. A simple random sample is then drawn from each stratum, which is combined to make the stratified sample
summary(FakeSchool)

honors = subset(FakeSchool, Honors=='Yes')
nonhonors = subset(FakeSchool, Honors == 'No')
#we can take 4 from nonHonors and 3 from honours
honors.sts = popsamp(n=3, pop=honors)
nonhonors.sts = popsamp(n=4, pop=nonhonors)

sts = rbind(honors.sts, nonhonors.sts)
sts
summary(sts)

#Strengths
#Representative of the population, because elements from all strata are included in the sample.
#Ensures that specific groups are represented, sometimes even proportionally, in the sample
#Since each stratified sample will be distributed similarly, the amount of variability between samples is decreased.
#Allows comparisons to be made between strata, if necessary. For example, a stratified sample allows you to easily compare the mean GPA of Honors students to the mean GPA of non-Honors students.
#Weaknesses
#Requires prior knowledge of the population. You have to know something about the population to be able to split into strata!


#Cluster sampling-----

selClass = sample(unique(FakeSchool$class), size=2, replace=F)
selClass
cluster.smp = FakeSchool[ FakeSchool$class %in% selClass,]
cluster.smp
