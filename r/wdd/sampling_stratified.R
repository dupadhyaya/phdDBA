# Stratified Sampling


#Stratified sampling involves dividing the population into subgroups or strata and then sampling from each stratum proportionally. Let’s assume we have a dataset of students’ grades in different subjects, and we want to select a sample that maintains the proportion of students from each subject. We can achieve this using the sample() function along with additional parameters. Consider the following example:

subjects <- c("Math", "Science", "English", "History")
grades <- c(80, 90, 85, 70, 75, 95, 60, 92, 88, 83, 78, 91)
