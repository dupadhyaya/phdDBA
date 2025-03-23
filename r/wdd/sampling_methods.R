# Sampling
pacman::p_load(tidyverse, sampling, TeachingSampling, SDaA, pwr)
#https://medium.com/analytics-vidhya/sampling-methods-in-r-b3c92e580c57
## sampling Methods 
### Probability -> Simple Random(SRS), Systematic(SSS), Stratified (STS), Cluster(CLS)
#### when you need unbiased, generalizable results.
###Non-Probability -> Convenience, Judgement, Quota, Snowball
#### when probability sampling is impractical or unnecessary.

#Population - Stratification - Sample
#Power Analysis

#createData ------
set.seed(123)
data <- data.frame( id = 1:100, age = sample(18:65, 100, replace=T), sname=paste('student', str_pad(1:100, 3, pad = "0")), section=sample(LETTERS[1:3], 100, prob=c(.3,.4,.1), replace=T), marks=sample(50:100, 100, replace=T))
head(data)
tail(data)

#----------------
#PS -> SRS--------
sz=8
(srs <- sample(data$id, sz, replace=F))
data[srs,]
print(paste('Simple Random Selection of sample size ', sz, ' from population of ', nrow(data)))
(srsr <- sample(data$id, sz, replace=T)) # with replacement

#PS -> SSS-----
set.seed(124)
seq(from=1, to=nrow(data), by=5)
#choose size, interval, start index
(sz = 7) #sample size
(si = floor(nrow(data)/sz)) #sampleinterval
(start = sample(1:si, 1)) #start from random position)
seq(from=1, to=nrow(data), by=si)
(sss <- data[seq(from=start, to=nrow(data), by=si),])
print(paste('Systematic Sampling : Start from', start, ' interval of ', si, ' and size of ', sz))
#using library
library(TeachingSampling)
S.SY(nrow(data), 7) #every 2nd position


#PS-> STS---------------------------------------------
#strata sampling
#pop divided into subgroups (strata) and samples are taken from each.
(stsn <- data %>% group_by(section) %>% slice_sample(n=3)) # 3 samples from each section
(stsp <- data %>% group_by(section) %>% slice_sample(prop=.1)) # 10% samples from each section
#check
data %>% group_by(section) %>% tally() %>% mutate(p=.1, perc = round(.1 * n))
#usingLibrary
library(sampling)
strats1 <- strata(data, c('section'), size = c(3,4,1), method='srswor')
strats1
data[strats1$ID_unit,]

#iris
sampling::strata(iris, c('Species'), size = c(2,3,5), method='srswor')
#srswor- simple random sampling without replacement
#srswr - simple random sampling with replacement
#poission - poission sampling
#systematic - systematic sampling
#ppps - probability proportional to size
sampling::strata(iris, c('Species'), size = c(2,3,5), method='srswr', description=T)


#PS -> CLS---------------------------
#pop is divided into clusters, and some clusters are randomly selected.
head(data)
#create kmeans cluster
set.seed(123)
data$cluster <- kmeans(data[,c('age', 'marks')], centers=5)$cluster
head(data)
(cls <- data %>% filter(cluster %in% sample(unique(data$cluster), 2, replace=F))) #select all rows of 2 clusters only

library(SDaA)
data('teachers')
head(teachers) #about teachers load etc
table(teachers$school)
?cluster
#random selection of 3 schools
(cl =sampling::cluster(teachers, clustername=c("school"), size=3, method="srswor"))
(cl_data = getdata(teachers, cl))
cl_data %>% group_by(school) %>% sample_n(size = 2) # from the 3 clusters, select 2 randomly

#Non-Probability -----------------------------------
#NP->Convenience------
#Selects samples based on ease of access.
head(data, 4)

#NP->Judgement/ Purposeful------
#researcher selects samples based on specific criteria.(5th obsvn)
data %>% filter(id %%5 == 0)


#NP->Snowball------
library(igraph)
# non-probability sampling technique used in research, particularly when studying hard-to-reach or specialized populations. It involves using existing study participants to recruit future participants from their social or professional networks.
#start with one or few cases and ask them to refer others
#create simulated social network
n=100
g <- sample_pa(n, m=1, directed=F) #10 individuals
g
(V(g)$name <- 1:n)
#start with 1 participant
seed <- sample(V(g)$name, 1)
sample_snowball <- c(seed)
sample_snowball
# Add friends of the seed
sample_snowball <- c(sample_snowball, neighbors(g, seed)$name)
print(sample_snowball)



#NP-QS--------
#quotaSampling
set.seed(1837)
library(tigerstats)
str(iris)
quest_1 = subset(iris, Species=="setosa") #selecting a sub group of data
quest_1
x= popsamp(4, quest_1)  # sampling in that group 
x
n_pop <- 1000
#example
set.seed(123) ; n_pop <- 1000
age_group <- sample(c("18-24", "25-34", "35-44", "45+"), n_pop, replace = TRUE, prob = c(0.25, 0.35, 0.25, 0.15))
gender <- sample(c("Male", "Female"), n_pop, replace = TRUE)
population <- data.frame(ID = 1:n_pop, age_group, gender)
head(population)
quotas <- expand.grid(age_group = c("18-24", "25-34", "35-44", "45+"), gender = c("Male", "Female")) %>% mutate(quota = 20)
quotas
quota_sample <- population %>% group_by(age_group, gender) %>% slice_sample(n = 20) %>% ungroup()
quota_sample
table(quota_sample$age_group, quota_sample$gender)

##Libraries to Explore-------
#sampling, SDAaA, TeachingSampling, pwr


#addlFunctions----------
#Define a population vector
(population_vector <- c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100))

# Replicate sampling 5 times without replacement
(replicated_samples <- replicate(5, sample(population_vector, size = 3, replace = FALSE)))

