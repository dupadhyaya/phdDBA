# Machine Learning

#linear regression--------
names(mtcars)
(df1 <- mtcars %>% select(mpg,cyl, hp, wt, am, gear, carb)) 
head(df1)

lm1 <- lm(data=df1, mpg ~ wt + hp)
lm1
summary(lm1)

#logistic regression--------
logm1 <- glm(data=df1, am ~ mpg + hp, family='binomial')
logm1

#decision tree
library(rpart)
library(rpart.plot)
gearTree <- rpart(gear ~ mpg + hp + wt , data=df1b, method='class')
gearTree
rpart.plot(gearTree)
#prediction, confusionMatrix

#clustering--------
head(df1)
df2b <- df1 %>% dplyr::select(mpg, cyl, hp, wt)
df2b
km3 <- kmeans(x=df2b, centers=3)
km3
km3$cluster
summary(km3)
library(useful)
plot(km3, data=df2b)
df2b %>% mutate(cluster= km3$cluster) %>% ggplot(., aes(x=wt, y=mpg)) + geom_point(aes(color=factor(cluster)))


#time series------

