# Freq Table, Prop Table, Group By Summaries


#data = mtcars
#subset data and convert & recode values
names(mtcars)
(df1 <- mtcars %>% select(mpg,cyl, hp, wt, am, gear, carb)) #subset
(df1b <- df1 %>% mutate(cyl = paste0('Cyl_', cyl), gear = paste0('Gear_', gear), carb = paste0('Carb_', carb)) %>% mutate(am = if_else(am==0,'Auto','Manual'))) # recode
head(df1b)



table(df1b$gear)
(T2=table(df1b$gear, df1b$am))
prop.table(T2) #table
round(prop.table(T2, 1),2) #rows
round(prop.table(T2, 2),2) #cols
margin.table(T2) #table
margin.table(T2,1) #row
margin.table(T2,2) #cols

#cut-----
df1b$mpgInterval = cut(mtcars$mpg, breaks=4)
head(df1b)
hist(df1b$mpg, breaks=4)
hist(df1b$mpg, breaks=c(0,10,20,30,40))

table(df1b$mpgInterval, df1b$gear)

df1b %>% group_by(mpgInterval) %>% summarise(meanHP = mean(hp, na.rm=T))
df1b %>% group_by(gear, cyl) %>% summarise(meanMPG = mean(mpg, na.rm=T), maxWt = max(wt, na.rm=t))


#endhere-------