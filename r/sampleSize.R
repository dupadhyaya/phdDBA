# Sample Size

library(pwr)

#3. Sample Size-----------
#2sample t-test (Independent)
#Effect Size = 0.5 (Cohen's d (effect size). Here, 0.5 is a medium effect), Power = 0.8 (Desired power of the test: 80%. Means an 80% chance of detecting an effect if it exists.), a = 0.05 (5% chance of error); alternative = "two.sided" (Testing if the two group means are different, not just greater or less). type = "two.sample" (comparing two independent groups (e.g., treatment vs control).
library(pwr)
pwr.t.test(d = 0.5, sig.level = 0.05 , power = 0.80, alternative = "two.sided", type = "two.sample")
