#ANOVA Stats Hypo Tests

pacman::p_load(tidyverse, multcomp, car)

#1-wayANOVA----- Example: 3 teaching method
set.seed(103)
(method <- factor(rep(c("A", "B", "C"), each = 20)))
(score <- round(c(rnorm(20, 65, 5), rnorm(20, 70, 5), rnorm(20, 68, 5))))
adata1 <- data.frame(method, score)
head(adata1)

adata1 %>% group_by(method) %>% summarise(meanScores = mean(score, na.rm=T))

model_1 <- aov(score ~ method, data = adata1) #aov
summary(model_1)

#p < 0.05: At least one group mean is different.
#Use post hoc tests (e.g., Tukey HSD) to find which groups differ.

#TurkeyTest------ Tukey HSD (Honestly Significant Difference) 
tukey1 = TukeyHSD(model_1)
tukey1
#Any two treatments that mean having a difference more than honestly significant difference are said to be significantly different, otherwise not.
#This tells you which pairs of groups differ significantly:
#A-B, A-C, B-C
#diff	Mean difference between B and A: B - A = 5.57
#lwr	Lower bound of the 95% confidence interval: 2.19
#upr	Upper bound of the 95% confidence interval: 8.19
#p adj	Adjusted p-value for multiple comparisons: 0.00059
#interpretation--
#There is a statistically significant difference between group B and group A, with group B scoring on average 5.57 units higher than group A.
#Since the p-value = 0.0005 < 0.05, the result is significant at the 5% level.
#Also, the confidence interval [2.19, 8.19] does not include 0, confirming significance.
###Tips
#If the confidence interval does NOT include 0, the difference is significant.
#Adjusted p-values control for Type I error across multiple comparisons.
#Effect direction matters: “B - A = +5.55” means B > A.

#othercomparisons
pacman::p_load(multcompView)
plot(tukey1, las = 1, col = "blue", cex.axis = 0.8)
(tukey1_df = as.data.frame(tukey1$method))
tukey1_df$Comparison <- rownames(tukey1_df)

(tukey1_df <- tukey1_df[, c("Comparison", "diff", "lwr", "upr", "p adj")])

library(agricolae)
tukey1B <- HSD.test(model_1, trt='method')
tukey1B

#----------------------------------------------------------
#2-wayANOVA------ Example: Gender and Method on Score
set.seed(104)
(method <- factor(rep(c("A", "B"), times = 30)))
table(method)
(gender <- factor(rep(c("M", "F"), each = 15, times = 2)))
score <- round(rnorm(60, mean=70, sd=4) + ifelse(method=="B", 3, 0) + ifelse(gender=="F", 2, 0))
adata2 <- data.frame(method, gender, score)
head(adata2)
dim(adata2)

adata2 %>% group_by(method, gender) %>% summarise(meanMarks = mean(score, na.rm=T)) %>% arrange(meanMarks)
model_2 <- aov(score ~ method * gender, data = adata2) #2way anova
summary(model_2)

TukeyHSD(model_2)
#Main effects of each factor
#Interaction effect (gender × method): If significant, the effect of one factor depends on the level of the other
with(adata2, interaction.plot(method, gender, score, fun=mean, main='Interaction Plot : Method - Gender'))
#lines are almost parallel, gap of mean scores almost same

#another way to write
model_2B <- aov(score ~ method + gender +  method * gender, data = adata2)
summary(model_2B)
#Ho: No Interaction btw levels of Methods & Genders.
#Ha : Interaction btw levels of Methods & Gender
#p value of method:gender = .77, > .05: hence Do not reject Ho
#Keeping gender constant, type of method (A or B), makes the difference to scores
#check individually
TukeyHSD(model_2B, which ='method')  #significant
TukeyHSD(model_2B, which ='gender')  #Not significant
TukeyHSD(model_2B, which ='method:gender')  #Not significant

#https://rpubs.com/jmessan/486117
#https://www.geeksforgeeks.org/how-to-do-a-tukey-hsd-test-with-the-anova-command-car-package-in-r/


#-------------------------
# Fit an ANOVA model
head(PlantGrowth)
table(PlantGrowth$group)
anova_model <- lm(weight ~ group, data = PlantGrowth)

# Perform ANOVA using the car package's Anova function
anova_results <- Anova(anova_model)
anova_results
#The p-value (0.01591) is less than 0.05, indicating that there are significant differences between at least one pair of groups.
# Perform Tukey HSD test
(tukey_results = TukeyHSD(aov(anova_model)))
#The p-values indicate that none of the pairwise comparisons are statistically significant after adjusting for multiple comparisons (all p-values > 0.05).
# Plot Tukey HSD results
plot(tukey_results, las = 1)

multcompLetters4(anova_model, tukey_results)
car::Anova(anova_model, type=3)


#endSummary
#ANOVA shows significance — ANOVA tells there is a difference, but Tukey tells where the difference lies.

#Emphasize reading direction (+ve/-ve diff) and whether CI includes 0.