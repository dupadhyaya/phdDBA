# graphs

pacman::p_load(tidyverse)

#basic---------
names(mtcars)
(df1 <- mtcars %>% select(mpg,cyl, hp, wt, am, gear, carb)) #subset
(df1b <- df1 %>% mutate(cyl = paste0('Cyl_', cyl), gear = paste0('Gear_', gear), carb = paste0('Carb_', carb)) %>% mutate(am = if_else(am==0,'Auto','Manual'))) # recode

hist(df1b$mpg)
barplot(table(df1b$gear), col=c('red','green','yellow'))
boxplot(df1b$mpg ~ df1b$gear, col=c('red','green','yellow'))
plot(df1b$wt ~ df1b$mpg)

#ggplot-----
#bar
df1b %>% group_by(gear) %>% tally() %>% ggplot(.,aes(x=gear, y=n)) + geom_bar(stat='identity', aes(fill=gear)) + geom_text(aes(label=n)) + labs(title='Gear Count')
#stacked
df1b %>% group_by(gear, am) %>% tally() %>% ggplot(.,aes(x=gear, y=n, fill=am)) + geom_bar(stat='identity', aes(fill=am), position = position_stack()) + geom_text(aes(label=n), position = position_stack(vjust=.5)) + labs(title='Gear-Tx Type Count')

#stacked-fill
df1b %>% group_by(gear, am) %>% tally() %>% ggplot(.,aes(x=gear, y=n, fill=am)) + geom_bar(stat='identity', aes(fill=am), position = position_fill()) + geom_text(aes(label=n), position = position_fill(vjust=.5)) + labs(title='Gear-Tx Type Count')


#Dodge
df1b %>% group_by(gear, am) %>% tally() %>% ggplot(.,aes(x=gear, y=n, fill=am)) + geom_bar(stat='identity', aes(fill=am), position = position_dodge2(width=.8)) + geom_text(aes(label=n), position = position_dodge2(width=.8)) + labs(title='Gear-Tx Type Count')

#pie
df1b %>% group_by(gear) %>% tally() %>% mutate(labels = paste0(gear, ':', n)) %>% ggpubr::ggpie(., x='n', label='labels', fill='gear')

#scatter
df1b %>% ggplot(., aes(x=wt, y=mpg)) + geom_point(aes(color=gear, shape=am, size=hp))  + geom_text(aes(label= paste0('(', wt,',', mpg,')')), size=3)
+ geom_text(aes(label=rownames(df1b)), size=3)


#boxplot-----
df1b %>% ggplot(., aes(x=mpg, y=gear, fill=gear)) + geom_boxplot(outliers=T) + facet_wrap(am ~. ,scale='free') + coord_flip()
#treemap
library(treemapify)
df1b %>% group_by(gear) %>% tally() %>% ggplot(., aes(area = n, fill = gear)) +  geom_treemap() + geom_treemap_text(aes(label=paste0(gear, ':', n)))
 
#venndiagram
library(ggVennDiagram)
(x <- list(A = 1:5, B = 2:7, C = 5:10) )
ggVennDiagram(x) +  scale_fill_gradient(low = "#F4FAFE", high = "#4981BF")                                                                                         
