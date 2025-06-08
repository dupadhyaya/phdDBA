# Hypothesis Test 01/6/25

# This code simulates a scenario where students are divided into two groups:
# Set seed for reproducibility
set.seed(123)

# Total number of students
n <- 50

# Randomly assign students to groups: AI Tool vs No AI Tool
group <- sample(c("AI_Tool", "NoAI_Tool"), size = n, replace = TRUE)

# Generate scores using different normal distributions
# AI Tool users have slightly higher mean score
score <- ifelse(group == "AI Tool",  rnorm(n, mean = 85, sd = 10),  rnorm(n, mean = 68, sd = 10))   # Mean 75, SD 10  #  Mean 68, SD 10

score
range(score)

# Clip scores to 0–100 range
score <- pmin(pmax(score, 0), 100)
score

# Create a data frame with group and score
# Create data frame
data1 <- data.frame( student = paste0("Student_", 1:n), group = group, exam_Score = round(score, 1))
# Display the first few rows of the data frame
head(data1)

data1 %>% group_by(group) %>%  summarise(mean_score = mean(exam_Score), sd_score = sd(exam_Score), n = n())

# Perform a t-test to compare the means of the two groups
t_test_result <- t.test(exam_Score ~ group, data = data1)
# the 2 means are not same. AI & noAI mean scores are different
# Display the t-test result
t_test_result


#Extended Hypothesis ---------
# Extended Hypothesis: AI Tool users have a higher mean score than No AI Tool users#
#Gender: Male or Female
# Before_AI_Score: Simulated baseline performance before using AI tools
# After_AI_Score: Simulated improvement after the intervention
# Pass_Fail: Label based on a passing score of 50 after using AI

# Set seed for reproducibility
set.seed(123)

# Total students
n <- 50

# Generate Group: AI Tool vs No AI Tool
group <- sample(c("AI_Tool", "NoAI_Tool"), size = n, replace = TRUE)

# Generate Gender
gender <- sample(c("Male", "Female"), size = n, replace = TRUE)

# Generate 'Before AI' scores for all
before_scores <- rnorm(n, mean = 65, sd = 8)

# Generate 'After AI' scores with improvement based on group
after_scores <- ifelse(  group == "AI_Tool",
  before_scores + rnorm(n, mean = 8, sd = 5),  # More improvement
  before_scores + rnorm(n, mean = 3, sd = 5))   # Less improvement

after_scores

# Clip scores between 0 and 100
before_scores <- pmin(pmax(before_scores, 0), 100)
after_scores <- pmin(pmax(after_scores, 0), 100)

# Generate Pass/Fail label based on After AI Score >= 50
pass_fail <- ifelse(after_scores >= 50, "Pass", "Fail")

# Create dataframe
data2 <- data.frame(
  student = paste0("Student_", 1:n),
  group = group,
  gender = gender,
  before_AI_Score = round(before_scores, 1),
  after_AI_Score = round(after_scores, 1),
  Pass_Fail = pass_fail
)

# View first few rows
head(data2)

#Hypothesis
# Paired t-test:  t.test(Before_AI_Score, After_AI_Score, paired=TRUE)
# Paired t-test (Before vs. After AI tool usage)
aiData <- subset(data2, group == 'AI_Tool')
head(aiData)
t.test(aiData$before_AI_Score, aiData$after_AI_Score, paired=T)
#if p-value < 0.05, we reject the null hypothesis that there is no difference in scores before and after using the AI tool.

#-------------------
#• Independent t-test: t.test(After_AI_Score ~ Group, data=data)
#Independent t-test (After scores between groups)
t.test(after_AI_Score ~ group, data = data2)
# if p-value < 0.05, we reject the null hypothesis that there is no difference in scores between AI Tool and No AI Tool groups. : Reject Ho, Accept Ha

#• Chi-square:  chisq.test(table(data$Group, data$Pass_Fail))
#Chi-square Test (Pass/Fail vs Group)
table_data <- table(data2$group, data2$Pass_Fail)
table_data
chisq.test(table_data)
# if p-value < 0.05, we reject the null hypothesis that there is no association between group and pass/fail status.: Reject Ho, Accept Ha
# there is a significant association between the group (AI Tool vs No AI Tool) and the pass/fail status.


#• ANOVA: aov(After_AI_Score ~ Group + Gender, data = data)
#ANOVA (if you extend to 3+ study methods)
head(data2)
anova_result <- aov(after_AI_Score ~ group + gender, data = data2)
summary(anova_result)
# if p-value < 0.05 for group, we reject the null hypothesis that there is no difference in scores between groups. : Reject Ho, Accept Ha
#Df : Degrees of freedom for each factor
#Sum Sq : Total variability explained by each factor
#Mean Sq : Average variability = Sum Sq / Df
#F value : Ratio of explained variance to unexplained variance
#Pr(>F) :  p-value → probability that group differences occurred by chance

#F(1, 47) = 9.241, p = 0.00386
# ✅ The effect of AI tool usage is statistically significant (since p < 0.05).
# 🧠 Interpretation: There is a significant difference in After_AI_Score between “AI Tool” and “No AI Tool” groups.: AI is good for Students

#Gender
#F(1, 47) = 0.170, p = 0..682
#❌ Not significant → no evidence that gender affects post-intervention scores. Effect of AI use is not differentiated due to Gender

# Assumptions
library(car)
leveneTest(after_AI_Score ~ group, data = data2)
#interpret the results with ChatGPT

TukeyHSD(anova_result)

anova_result2 <- aov(after_AI_Score ~ group + gender + gender:group, data = data2)
summary(anova_result2)
TukeyHSD(anova_result2)
