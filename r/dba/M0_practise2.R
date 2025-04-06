# Data Creation
#install.packages("devtools")
#devtools::install_github("homerhanumat/tigerstats")
pacman::p_load(randomNames, dplyr, tigerstats, ggplot2)
#data
rollno <- 1L:100L
school <- sample(c('School1',' School2','School3'), 100, replace = T)
(name <- randomNames(100, ethnicity = 'Asian', name.order='first.last'))
gender <- sample(c('M', 'F'), 100, replace = T)
age <- sample(15:20, 100, replace = T)
maths <- sample(50:100, 100, replace = T)
science <- sample(50:100, 100, replace = T)
class <- sample(10:12, 100, replace = T)
section <- sample(LETTERS[1:3], 100, replace = T)
city <- sample(c('Mumbai', 'Delhi', 'Chennai','Dubai', 'Muscat'), 100, replace = T)
grades <- sample(c('A', 'B', 'C', 'D'), 100, replace = T)
(grades <- factor(grades, ordered=T, levels = c('D', 'C', 'B', 'A')))


students <- data.frame(school, rollno, class, section, name, gender, age, grades, maths, science, city)
head(students,3)


#--------
table(students$grades)
#A:90-100, B:80-89, C:70-79, D:50-69

students <- students %>% mutate( gradeLevel  = case_when (
  grades == 'A' ~ '90-100',
  grades == 'B' ~ '80-89',
  grades == 'C' ~ '70-79',
  grades == 'D' ~ '50-69',
  TRUE ~ 'Others'
))

students <- students %>% mutate( gradeCat  = case_when (
  grades == 'A' ~ 'Excellent',
  grades == 'B' ~ 'Good',
  grades == 'C' ~ 'Satisfactory',
  grades == 'D' ~ 'Average',
  TRUE ~ 'Others'
))
head(students)

students %>% group_by(class, gender, grades) %>% summarise(n=n()) %>% ggplot(., aes(x=factor(class), y=n, fill=grades)) + geom_col(position = position_dodge2(.8)) + geom_text(aes(label=n), position = position_dodge2(.8), vjust=-0.5) + scale_fill_discrete() + facet_grid(gender ~. , scales ='free')

students %>% group_by(gender, grades) %>% summarise(n=n()) %>% ggplot(., aes(x=factor(gender), y=n, fill=grades)) + geom_col(position = position_dodge2(.8)) + geom_text(aes(label=n), position = position_dodge2(.8), vjust=-0.5) + scale_fill_discrete() 

students %>% group_by(gender, grades) %>% summarise(n=n()) %>% ggplot(., aes(x=factor(gender), y=n, fill=grades)) + geom_col(position = position_stack(.8)) + geom_text(aes(label=n), position = position_stack(.8), vjust=-0.5) + scale_fill_discrete() 



