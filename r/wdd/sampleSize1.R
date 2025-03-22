# Sample Size 

#library-----
library(pwr)
#Factors---------
#   - Effect size (Cohen's d) = 0.5
#   - Significance level (alpha) = 0.05
#   - Desired power = 0.80
#   - Alternative hypothesis: one.sample, two.sided

#Example:  One-sample t-test-------
#Input: d= 0.5, a=.05, power=0.8, alternative=two.sided, type=one.sample
pwr.t.test(d = 0.5, sig.level = 0.05, power = 0.80, alternative = "two.sided", type = "one.sample") #n=33 samples

#Example:  Two-sample t-test(Indep)-------
#Input: d= 0.5, a=.05, power=0.8, alternative=two.sided, type=two.sample
pwr.t.test(d = 0.5, sig.level = 0.05, power = 0.80, alternative = "two.sided", type = "two.sample") #n=63 samples for each gp

# Example: Two-sample t-test (Paired)-----
#Input: d= 0.5, a=.05, power=0.8, alternative=two.sided, type=paired
pwr.t.test(d = 0.5, sig.level = 0.05, power = 0.80, alternative = "two.sided", type = "paired") #n=33 pairs

# Example: ANOVA (one-way)-----
# Input: Effect size (f) = 0.25 (small), 0.50 (medium), 0.75 (large)
# Number of groups (k) = 3; a= 0.05; power=0.8
pwr.anova.test(k = 3, n = NULL, f = 0.50, sig.level = 0.05, power = 0.80) #
#sample size per group (n) =13 to achieve 80% power with a medium-to-large effect size (f = 0.5) across 3 groups at the 0.05 significance level.. Total Sample = 13 x 3 = 39



#effect of sample size on power
# Define effect sizes and power levels
effect_sizes <- seq(0.1, 1.2, by = 0.01)
power_levels <- c(0.6, 0.7, 0.8, 0.9)

# Create an empty list to store sample sizes
sample_sizes <- list()

# Loop through power levels and calculate sample sizes for paired t-test
for (p in power_levels) {
  sample_sizes[[as.character(p)]] <- sapply(effect_sizes, function(d) {
    pwr.t.test(d = d, power = p, sig.level = 0.05,
               type = "paired", alternative = "two.sided")$n
  })
}

# Plotting
plot(effect_sizes, sample_sizes[["0.8"]], type = "l", lwd = 2, col = "blue",
     ylim = c(0, max(unlist(sample_sizes))),
     xlab = "Effect Size (Cohen's d)", ylab = "Required Sample Size (per group)",
     main = "Sample Size vs. Effect Size for Paired t-Test")

# Add other power curves
lines(effect_sizes, sample_sizes[["0.6"]], col = "orange", lwd = 2)
lines(effect_sizes, sample_sizes[["0.7"]], col = "green", lwd = 2)
lines(effect_sizes, sample_sizes[["0.9"]], col = "red", lwd = 2)

# Add a legend
legend("topright", legend = paste("Power =", power_levels),
       col = c("orange", "green", "blue", "red"), lwd = 2)

# Optional: add reference lines
abline(v = 0.5, col = "gray", lty = 2)
abline(h = 34, col = "gray", lty = 2)

#ggplot------
# Create a data frame of all combinations
grid <- expand.grid(effect_size = effect_sizes, power = power_levels)
head(grid)
# Calculate sample size for each combination
grid$sample_size <- mapply(function(d, p) { pwr.t.test(d = d, power = p, sig.level = 0.05, type = "paired", alternative = "two.sided")$n}, d = grid$effect_size, p = grid$power)

# Convert power to factor for color grouping
grid$power <- as.factor(grid$power)

# Plot with ggplot2
ggplot(grid, aes(x = effect_size, y = sample_size, color = power)) + geom_line(linewidth = 1.2) + labs(title = "Sample Size vs. Effect Size (Paired t-Test)", x = "Effect Size (Cohen's d)", y = "Required Sample Size (per group)", color = "Power") + geom_hline(yintercept = 34, linetype = "dashed", color = "gray") +  geom_vline(xintercept = 0.5, linetype = "dashed", color = "gray") +  theme_minimal(base_size = 14)
