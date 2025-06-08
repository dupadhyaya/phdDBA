#M3 - Chi Square Tests


#A school wants to examine whether student performance (Pass/Fail) is independent of the teaching method used (Traditional, Blended, or AI-Assisted).

#This is a typical Chi-Square Test of Independence situation — we want to test if two categorical variables are related.

# Create observed frequency table
edu_data <- matrix(c(
  15, 5,   # Traditional: 15 Pass, 5 Fail
  18, 2,   # Blended: 18 Pass, 2 Fail
  20, 0    # AI-Assisted: 20 Pass, 0 Fail
), nrow = 3, byrow = TRUE)

edu_data
# Add row and column names
rownames(edu_data) <- c("Traditional", "Blended", "AI_Assisted")
colnames(edu_data) <- c("Pass", "Fail")
edu_data

chisq_result <- chisq.test(edu_data)
print(chisq_result)

#Interpretation:
#Ho: Teaching method and student performance (pass/fail) are independent
#H₁: There is an association between teaching method and performance
#Since p = 0.032 < 0.05, we reject the null hypothesis.
#There is a significant association between teaching method and student performance.

chisq_result$expected
#This shows what counts we would expect if there were no association — useful for teaching.
edu_data
(15+18+20)/3 # Pass Proportion
(5+2+0)/3 #Fail proportion

mosaicplot(edu_data, main = "Teaching Method vs Performance",
           color = TRUE, shade = F, las = 1)


#ifdata is not in FT
set.seed(2025)

# Simulate 60 students with method and result
method <- sample(c("Traditional", "Blended", "AI_Assisted"), 60, replace = TRUE)
result <- ifelse(method == "AI_Assisted", sample(c("Pass", "Fail"), 20, replace=TRUE, prob = c(0.95, 0.05)),ifelse(method == "Blended", sample(c("Pass", "Fail"), 20, replace=TRUE, prob = c(0.85, 0.15)),sample(c("Pass", "Fail"), 20, replace=TRUE, prob = c(0.75, 0.25))))
result
# Combine into data frame
student_data <- data.frame(method, result)
head(student_data)

# Create frequency table
edu_table <- table(student_data$method, student_data$result)
print(edu_table)
chisq_result <- chisq.test(edu_table)
print(chisq_result)
chisq_result$expected
mosaicplot(edu_table, color = TRUE, main = "Method vs Performance")

#when to use
#Chi-square tests are used when you are working with categorical (qualitative) variables, and you want to test relationships or distributions. There are two main types:

#Indepedence - Is there an association between gender and course completion status
#chisq.test(table(gender, status))
#2-Goodness of Fit - Distribution of single Categorical variable matches expected distribution
#You have one categorical variable and You want to check whether the observed frequencies match the theoretical (expected) frequencies
observed <- c(40, 35, 25)
expected <- c(33.3, 33.3, 33.3)
chisq.test(x = observed, p = expected / sum(expected))

#assumption
#Data is frequency count	Not proportions or percentages
#Categories are mutually exclusive	A participant can belong to only one group
#Expected cell frequency ≥ 5	Rule of thumb to ensure test validity
#Independence of observations	Each observation comes from a different participant

#goodnes
#A college administrator wants to check if students prefer different learning modes equally. A survey is conducted with 100 students choosing among:
#Online, Hybrid, Offline
#The administrator expects that preferences are equally distributed. But is that assumption valid?
# Number of students selecting each learning mode
observed <- c(30, 45, 25)
names(observed) <- c("Online", "Hybrid", "Offline")
expected <- rep(100 / 3, 3)  # Equal distribution: 33.33 each
observed  
expected
chisq.test(x = observed, p = expected / sum(expected))
#Ho:Student preferences are equally distributed among Online, Hybrid, and Offline.
#H₁: Preferences are not equally distributed.
#Since p = 0.043 < 0.05, we reject the null hypothesis.
#➡️ There is a significant difference in student preferences — students do not prefer the learning modes equally.
barplot(observed, col = "skyblue", main = "Student Preference for Learning Modes")
abline(h = expected[1], col = "red", lty = 2)
#When is this useful?	Compare expected enrollment, attendance, grades, preferences with actual