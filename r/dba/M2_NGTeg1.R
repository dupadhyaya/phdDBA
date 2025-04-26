#M2 Data Collection - NGT

# Load necessary libraries
pacman::p_load(tidyr, googlesheets4, tidyverse, tidytext)

# when u run this, it will ask for authentication
gsDC ='1UT9jwVx6XNCBz6bjC2Qf3MCYMpWmgKbPPklP255h56k'
sheet_names(gsDC)

#stage1-------------------
(ideas = read_sheet(gsDC, sheet = "data1A", skip=2, col_types = 'Dcccccccc'))

#Top 6 Ideas------
ideaLong <- ideas %>% pivot_longer(cols = idea1:idea6, names_to='ideaNo', values_to = 'idea')
ideaLong %>% group_by(idea) %>% summarise(n=n()) %>% arrange(desc(n))

#Stage2---------------------------
(ideaImp = read_sheet(gsDC, sheet = "data2A", skip=2, col_types = 'Dcciiiiii'))
head(ideaImp)
(ideaImpLong <- ideaImp %>% pivot_longer(cols = LoginFreq:PeerInteraction, names_to='idea', values_to = 'score'))

#Stage3-------------
#summarise statistically
ideaImpLong %>% group_by(idea) %>% summarise(votes = n(), totalscore = sum(score, na.rm=T)) %>% arrange(desc(totalscore))

#othersStats
ideaStats <- ideaImpLong %>% group_by(idea) %>% summarise(meanRating = mean(score, na.rm=T), medianRating = median(score, na.rm=T), sdRating = sd(score, na.rm=T), IQR = IQR(score, na.rm=T)) 
ideaStats

#Conclusion---------
#Best Idea / Ideas in order
ideaImpLong %>% group_by(idea) %>% summarise(votes = n(), totalscore = sum(score, na.rm=T)) %>% arrange(desc(totalscore))
ideaOrder <- ideaImpLong %>% group_by(idea) %>% summarise(votes = n(), totalscore = sum(score, na.rm=T)) %>% arrange(desc(totalscore)) %>% pull(idea)
paste(1:6, ideaOrder, collapse =' -> ') 

#stats
#IQR : smaller -> higher consensus (Login)
ideaStats %>% arrange(IQR)
#meanRating : higher -> more participants rated this higher (Login)
ideaStats %>% arrange(meanRating)
#sdRating------
ideaStats %>% arrange(sdRating)

#graphs------
ideaImpLong %>% ggplot(., aes(x=idea, y= score)) + geom_boxplot(aes(color=idea)) + geom_jitter() + coord_flip() + scale_y_continuous(breaks = scales::pretty_breaks(n = 6))

summary_stats <- ideaImpLong %>% group_by(idea) %>% summarise(  mean = mean(score), median = median(score), IQR = IQR(score), lower = quantile(score, 0.25), upper = quantile(score, 0.75) )
summary_stats

# Base boxplot
p <- ideaImpLong %>% ggplot(., aes(x = idea, y = score)) + geom_boxplot(fill = "lightblue", alpha = 0.7, outlier.shape = NA) + geom_jitter(width = 0.2, alpha = 0.5) + geom_point(data = summary_stats, aes(x = idea, y = mean), color = "red", size = 3, shape = 18) + geom_text(data = summary_stats, aes(x = idea, y = upper + 0.2, label = paste0("IQR = ", round(IQR, 2))), color = "darkgreen", size = 3.5) + geom_text(data = summary_stats,   aes(x = idea, y = mean - 0.2, label = paste0("Mean = ", round(mean, 2))), color = "red", size = 3.5) + labs(title = "Delphi Rating Summary",  y = "Score", x = "Predictor") + theme_minimal()
p + coord_flip() + scale_y_continuous(breaks = scales::pretty_breaks(n = 6))


