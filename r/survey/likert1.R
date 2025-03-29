# Analysis of Likert Scale Feedback

pacman::p_load(tidyverse, scales, likert, LikertMakeR, ggplot2, ggthemes, cowplot, psych)
#Likert data—properly pronounced like “LICK-ert”—are ordered responses to questions or ratings.  Responses could be descriptive words, such as “agree”, “neutral”, or “disagree,” or numerical, such as “On a scale of 1 to 5, where 1 is ‘not interested’ and 5 is ‘very interested’…”  Likert data is commonly collected from surveys evaluating education programs, as well in a variety of opinion surveys and social science surveys.
#https://rcompanion.org/handbook/E_01.html
?LikertMakeR

#Case-1----------
# 1 Teacher, 10 Students, 1 numerical rating
df1 <- data.frame( teacher = "Mr. Dhiraj",  sname=paste0('student', str_pad(1:10, 2, pad = "0")),  rating = sample(x=c(1L:10L), size=10, replace=T))
df1
df1B <- df1 %>% mutate(oRating = factor(rating, ordered=T, levels=c(1:10)))
str(df1B)
head(df1B)

psych::headTail(df1B)
table(df1B$oRating)
(XT = xtabs( ~ oRating, data=df1B))
prop.table(XT)

df1B %>% group_by(oRating) %>% summarise(n=n()) %>% ggplot(., aes(x=oRating, y=n, fill=oRating)) + geom_bar(stat="identity") + geom_text(aes(label=n)) + theme_minimal() + labs(title="Rating of Mr. Dhiraj's Students", x="Rating", y="Frequency") + scale_fill_brewer(palette="Set1") + scale_y_continuous(breaks = scales::breaks_pretty())

df1B %>% ggplot(., aes(x='', y=rating)) + geom_boxplot() + geom_jitter( aes(color=oRating), size=2) + geom_text(aes(label=rating)) + labs(title="Rating Distribution of Mr. Dhiraj's Students", x="Rating", y="Frequency") + scale_fill_brewer(palette="Set1") + scale_y_continuous(breaks = scales::breaks_pretty())

#HH package
library(HH)
#https://cran.r-project.org/web/packages/HH/HH.pdf
head(df1B)
data(ProfChal)
head(ProfChal)
likert(Question ~ . , ProfChal[ProfChal$Subtable=="Employment sector",], main='Is your job professionally challenging?', ylab=NULL, sub="This plot looks better in a 9in x 4in window.")


## Percent plot calculated automatically from Count data
likert(Question ~ . , ProfChal[ProfChal$Subtable=="Employment sector",],
       as.percent=TRUE,
       main='Is your job professionally challenging?',
       ylab=NULL,
       sub="This plot looks better in a 9in x 4in window.")

## formula method
data(NZScienceTeaching)
head(NZScienceTeaching)
?likert(Question ~ . | Subtable, data=NZScienceTeaching, ylab=NULL, scales=list(y=list(relation="free")), layout=c(1,2))

?likert
## formula notation with expanded right-hand-side
likert(Question ~  "Strongly disagree" + Disagree + Neutral + Agree + "Strongly agree" | Subtable, data=NZScienceTeaching,   ylab=NULL,   scales=list(y=list(relation="free")), layout=c(1,2))

NZScienceTeachingLong <- reshape2::melt(NZScienceTeaching, id.vars=c("Question", "Subtable"))
names(NZScienceTeachingLong)[3] <- "Agreement"
head(NZScienceTeachingLong)
likert(Question ~ Agreement | Subtable, value="value", data=NZScienceTeachingLong, ylab=NULL, scales=list(y=list(relation="free")), layout=c(1,2))

## Examples with higher-dimensional arrays.
tmp3 <- array(1:24, dim=c(2,3,4), dimnames=list(A=letters[1:2], B=LETTERS[3:5], C=letters[6:9]))
tmp3
## positive.order=FALSE is the default. With arrays
## the rownames within each item of an array are identical.
## likert(tmp3)
likert(tmp3, layout=c(1,4))
likert(tmp3, layout=c(2,2), resize.height=c(2,1), resize.width=c(3,4))


Responses <- c(15, 13, 12, 25, 35)
names(Responses) <- c("Strongly Disagree", "Disagree", "No Opinion",
                      "Agree", "Strongly Agree")
likert(Responses, main="Retail-R-Us offers the best everyday prices.",
       sub="This plot looks better in a 9in x 2.6in window.")

likert(Responses, horizontal=FALSE,
       aspect=1.5,
       main="Retail-R-Us offers the best everyday prices.",
       auto.key=list(space="right", columns=1,
                     reverse=TRUE, padding.text=2),
       sub="This plot looks better in a 4in x 3in window.")

data(AudiencePercent)
likert(AudiencePercent,
       auto.key=list(between=1, between.columns=2),
       xlab=paste("Percentage of audience younger than 35 (left of zero)",
                  "and older than 35 (right of zero)"),
       main="Target Audience",
       col=rev(colorspace::sequential_hcl(4)),
       sub="This plot looks better in a 7in x 3.5in window.")

data(USAge.table)
USA79 <- USAge.table[75:1, 2:1, "1979"]/1000000
PL <- likert(USA79,
             main="Population of United States 1979 (ages 0-74)",
             xlab="Count in Millions",
             ylab="Age",
             scales=list(
               y=list(
                 limits=c(0,77),
                 at=seq(1,76,5),
                 labels=seq(0,75,5),
                 tck=.5))
)
PL
as.pyramidLikert(PL)
likert(USAge.table[75:1, 2:1, c("1939","1959","1979")]/1000000,
       main="Population of United States 1939,1959,1979 (ages 0-74)",
       sub="Look for the Baby Boom",
       xlab="Count in Millions",
       ylab="Age",
       scales=list(
         y=list(
           limits=c(0,77),
           at=seq(1,76,5),
           labels=seq(0,75,5),
           tck=.5)),
       strip.left=FALSE, strip=TRUE,
       layout=c(3,1), between=list(x=.5))

Pop <- rbind(a=c(3,2,4,9), b=c(6,10,12,10))
dimnames(Pop)[[2]] <- c("Very Low", "Low", "High", "Very High")
likert(as.listOfNamedMatrices(Pop),
       as.percent=TRUE,
       resize.height="rowSums",
       strip=FALSE,
       strip.left=FALSE,
       main=paste("Area and Height are proportional to 'Row Count Totals'.",
                  "Width is exactly 100%.", sep="\n"))

data(ProfChal)
likertMosaic(Question ~ . | Subtable, ProfChal, main="Is your job professionally challenging?")

LikertPercentCountColumns(Question ~ . | Subtable, ProfChal, layout=c(1,6), scales=list(y=list(relation="free")),  ylab=NULL, between=list(y=0), strip.left=strip.custom(bg="gray97"), strip=FALSE, par.strip.text=list(cex=.7), main="Is your job professionally challenging?")
