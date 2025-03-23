# Sample Code for Workshop/Training - 22Mar25
#https://github.com/dupadhyaya/phdDBA/blob/main/r/wdd/wddCode.R

#R software: unfriendly but probably the best for stats https://pmc.ncbi.nlm.nih.gov/articles/PMC7063554/

#0-Setup
R.version #4.4.3 (latest)

#A- Bibliometrics-------------------
#https://rforanalytics.com/06-method3.html

pacman::p_load(bibliometrix, pander, knitr, kableExtra, ggplot2, bibliometrixData)
data('scientometrics')
?scientometrics
head(scientometrics)
str(scientometrics)

#descriptive----
# Descriptive analysis
M = scientometrics  #just to reuse the other code
res1 = biblioAnalysis(M, sep = ";")
s1 = summary(res1, k = 10, pause = FALSE, verbose = FALSE) #summary
d1 = s1$MainInformationDF  #main information 
d2 = s1$MostProdAuthors  #Most productive Authors 
d3 = s1$MostCitedPapers  #most cited papers 
pander(d1, caption = "Summary Information")
#productiveauthors
s1$MostProdAuthors
pander(d2, caption = "Most Productive Authors", table.split = Inf)
#mostcited
pander(d3, caption = "Most Cited Papers")
p1 = plot(res1, pause = FALSE)
p1[[1]] + theme_bw() + scale_x_discrete(limits = rev(levels(as.factor(p1[[1]]$data$AU))))
p1[[2]] #countries

threeFieldsPlot(M, fields = c("DE", "AU", "AU_CO")) #visualise multiple attributes at once , sankey plot
Netmatrix2 = biblioNetwork(M, analysis = "co-occurrences", network = "keywords", sep = ";")
net = networkPlot(Netmatrix2, normalize = "association", weighted = T, n = 50, Title = "Keyword Co-occurrences", type = "fruchterman", size = T, edgesize = 5, labelsize = 0.7)

#1.Distributions-------------------

#normal
data <- rnorm(1000, mean = 0, sd = 1)
hist(data, main ="Normal Distribution", col = "lightblue", breaks = 30)
shapiro.test(data)
#pv > 0.05, do not reject Ho : The data is normally distributed

#all
library(ggplot2)
n = 1000
# Create list of distributions
distributions <- list(  
    Normal = rnorm(n, mean = 0, sd = 1),
    Uniform = runif(n, min = 0, max = 1),
    Binomial = rbinom(n, size = 10, prob = 0.5),
    Poisson = rpois(n, lambda = 4),
    Exponential = rexp(n, rate = 1),
    ChiSquare = rchisq(n, df = 5),
    t_Distribution = rt(n, df = 10),
    LogNormal = rlnorm(n, meanlog = 0, sdlog = 1)
  )
  
# Convert to data frame for ggplot
df <- do.call(rbind, lapply(names(distributions), function(name) {
    data.frame(Value = distributions[[name]], Distribution = name)
  }))
df  
# Plot
gD1 <- ggplot(df, aes(x = Value)) +
    geom_histogram(bins = 30, fill = "steelblue", color = "white") +
    facet_wrap(~ Distribution, scales = "free", ncol = 2) +
    theme_minimal(base_size = 14) +
    labs(title = "Simulated Distributions", x = "Value", y = "Frequency")
gD1


#2A. Hypothesis--------
set.seed(123)  # for reproducibility
scores <- rnorm(30, mean = 52, sd = 5)  # sample mean is ~52
scores
t.test(scores, mu = 50)
#t = 1.9 : t-statistic
#df = 29: degrees of freedom (n − 1)
#p-value = 0.0584 : >  0.05 → not statistically significant  
#Confidence Interval: The true mean is likely between 49.93 and 53.59. The 95% confidence interval includes 50
#Conclusion: There’s no evidence that the sample mean is different from 52
hist(scores, col = "lightgreen", main = "Histogram of Scores (Mean ≈ 50)", breaks = 10); abline(v = 52, col = "red", lwd = 2, lty = 2)

#2.B Regression Analysis--------
model <- lm(weight ~ height, data = women)
summary(model)
##Coefficients Table:
##Intercept = -87.52: The predicted weight when height = 0 (not meaningful here, but required mathematically)
#Slope (height) = 3.45: For each 1-inch increase in height, weight increases by ~3.45 pounds
#Statistical Significance:
#p-value < 0.001 for height → significant predictor
##Model Fit:
#R-squared = 0.991 → 99.1% of the variation in weight is explained by height
#F-statistic = 1433, p < 0.001 → overall model is highly significant
predict(model, newdata = data.frame(height = c(63, 66)))

plot(women$height, women$weight, main = "Height vs Weight", xlab = "Height (inches)", ylab = "Weight (lbs)", pch = 19, col = "blue"); abline(model, col = "red", lwd = 2) 
##Summary
#Linear regression shows a strong, positive linear relationship between height and weight.
#Height is a highly significant predictor of weight.
#The model fits the data very well (R² ≈ 99%).

#3. Sample Size-----------
#2sample t-test (Independent)
#Effect Size = 0.5 (Cohen's d (effect size). Here, 0.5 is a medium effect), Power = 0.8 (Desired power of the test: 80%. Means an 80% chance of detecting an effect if it exists.), a = 0.05 (5% chance of error); alternative = "two.sided" (Testing if the two group means are different, not just greater or less). type = "two.sample" (comparing two independent groups (e.g., treatment vs control).
library(pwr)
pwr.t.test(d = 0.5, sig.level = 0.05 , power = 0.80, alternative = "two.sided", type = "two.sample")

#n = 63.77: Need about 64 participants in each group.
#80% power to detect a medium effect size (d = 0.5) at the 0.05 sign level.
#Total sample size = 64 × 2 = 128 participants


#4. DataCleaning------------
library(VIM)
sleep
dim(sleep) #62 rows
sum(is.na(sleep))
colSums(is.na(sleep))
rowSums(is.na(sleep))
na.omit(sleep)
dim(na.omit(sleep)) #42 rows
colMeans(is.na(sleep))
head(sleep)
sleep %>% mutate(across(where(is.numeric),  ~ ifelse(is.na(.), mean(., na.rm = TRUE), .))) %>% head()


#5. Data Summarisation-----

#summmary Stats
library(psych)
t(describe(sleep))
#Freq Table
library(janitor)
tabyl(iris$Species)

#Corr
corrr::correlate(mtcars)

#vis summary
library(DataExplorer)
plot_intro(mtcars)
plot_histogram(mtcars)
create_report(mtcars) #web


#6. Data Visualization-----

#scatter plot with Regression line
head(mtcars)
(gS1 <- ggplot(mtcars, aes(x = wt, y = mpg, shape=factor(am), size=hp)) + geom_point(aes(color=factor(gear))) + geom_smooth(method = "lm", se = TRUE, color = "violet")  + labs(title = "MPG vs Weight with Regression Line", color='Gear', size='HP', shape='Tx(AM)'))
gS1 + ggrepel::geom_label_repel(aes(label=rownames(mtcars)), size=3)
gS1 + ggrepel::geom_label_repel(aes(label = paste0('Wt-',wt, ' mpg-', mpg, ' am-', am, ' gear-', gear, ' hp-', hp)), size=3)
gS1 + facet_wrap(cyl ~., scales = "free", labeller = label_both)
                                                                             