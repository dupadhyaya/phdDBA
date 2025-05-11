# gglikert

remotes::install_github("larmarange/gglikert")
pacman::p_load(tidyverse, ggstats, ggstatsplot, gestate)

#data
likertLevels <- c("Strongly disagree", "Disagree", "Neutral", "Agree", "Strongly agree")
likertData <- tibble ( q1 = sample(likertLevels, 100, replace = TRUE), q2 = sample(likertLevels, 100, replace = TRUE), q3 = sample(likertLevels, 100, replace = TRUE)) %>% mutate(across(everything(), ~ factor(.x, levels = likertLevels)))
head(likertData)
dim(likertData)

gglikert(likertData)

gglikert(likertData) + scale_fill_brewer(palette ="RdYlBu")

gglikert(likertData, sort='ascending')


head(diamonds)
diamonds %>% ggplot(., aes(x=clarity, y=cut)) +
  geom_count(aes(size=after_stat(n)), alpha=0.5) +
  scale_size_area(max_size = 10) +
  theme(legend.position = "none") +
  labs(title = "Count of diamonds by clarity and cut",
       subtitle = "Size of the points is proportional to the count of diamonds",
       x = "Clarity",
       y = "Cut") 

#connectedbars
diamonds %>% ggplot(., aes(x=clarity, fill=cut)) +   geom_bar(stat='count', width=.5) +  theme(legend.position = "bottom") + geom_bar_connector(width=.5, linewidth=.25) +   labs(title = "Count of diamonds by clarity and cut",  x = "Clarity",  y = "Cut - Type/Count") 


#cascade plot------
diamonds %>% ggcascade(all=T, big = carat > .5, bigIdeal = carat > .5 & cut =='Ideal', add_n=T)

?ggcascade
mtcars %>% mutate(am = factor(am, labels=c('Auto', 'Manual'))) %>% ggcascade(all=T, highMPG = mpg > 20, highMPGcyl4 = mpg > 20 & cyl == 4, .by=am) + theme(legend.position = "bottom", strip.text = element_text(size=rel(3))) + labs(title = "Count of mtcars by mpg and cyl", x = "mpg", y = "cyl - Type/Count")

mtcars %>% mutate(am = paste('Tx-', factor(am, labels=c('Auto', 'Manual'))), cyl = paste('Cyl-',cyl)) %>% ggcascade(all=T, highMPG = mpg > 20, highMPGcyl4 = mpg > 20 & cyl == 4, .by=pick(cyl,am)) + theme(legend.position = "bottom", strip.text = element_text(size=rel(1.2))) + labs(title = "Count of mtcars by mpg and cyl", x = "mpg", y = "cyl - Type/Count")


ggplot2::mpg |>  ggcascade(all = TRUE, recent = year > 2000, "recent & economic" = year > 2000 & displ < 3, .by = cyl,    .ncol = 3, .arrows = FALSE,.text_size = 3 )
