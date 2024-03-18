# Survey1
#https://ladal.edu.au/surveys.html
#https://www.youtube.com/watch?v=gM3Tgw3W3rc
#https://www.youtube.com/watch?v=HR___cuH-Hs
pacman::p_load(tidyr, tidyverse, dplyr, ggplot2, likert, knitr, lattice, MASS, pysch, virdis, here, flextable, devtools, GPArotation, ufs, remotes, cowplot)
pacman::p_load_gh('rlesur/klippy')
options(stringsAsFactors = F)         # no automatic data transformation
options("scipen" = 100, "digits" = 4) # suppress math annotation

# define color vectors
clrs3 <- c("firebrick4",  "gray70", "darkblue")
clrs5 <- c("firebrick4", "firebrick1", "gray70", "blue", "darkblue")
# load data
ldat <- base::readRDS(url("https://slcladal.github.io/data/lid.rda", "rb"))
ldat

ldat %>%   ggplot(aes(x = Satisfaction, color = Course)) +  geom_step(aes(y = after_stat(y)), stat = "ecdf") +   labs(y = "Cumulative Density") +   scale_x_discrete(limits = c("1","2","3","4","5"),  breaks = c(1,2,3,4,5), labels=c("very dissatisfied", "dissatisfied", 
 "neutral", "satisfied", "very satisfied")) + scale_colour_manual(values = clrs3) + theme_bw() 



#------
sdat  <- base::readRDS(url("https://slcladal.github.io/data/sdd.rda", "rb"))
sdat

colnames(sdat)[3:ncol(sdat)] <- paste0("Q ", str_pad(1:10, 2, "left", "0"), ": ", colnames(sdat)[3:ncol(sdat)]) %>% stringr::str_replace_all("\\.", " ") %>%  stringr::str_squish() %>%  stringr::str_replace_all("$", "?")
# inspect column names
colnames(sdat)

lbs <- c("disagree", "somewhat disagree", "neither agree nor disagree", "somewhat agree", "agree")
survey <- sdat %>%  dplyr::mutate_if(is.character, factor) %>% dplyr::mutate_if(is.numeric, factor, levels = 1:5, labels = lbs) %>% drop_na() %>%  as.data.frame()
survey

plot(likert(survey[,3:12]), ordered = F, wrap= 60)


survey_p1 <- plot(likert(survey[,3:12]), ordered = F, wrap= 60)
# save plot
cowplot::save_plot(here("images", "stu_p1.png"), # save plot
    survey_p1,        # object to plot
    base_asp = 1.5,  # ratio of space fro questions vs space for plot
     base_height = 8) # size! higher for smaller font size


# create plot
plot(likert(survey[,3:8], grouping = survey[,1]))


#P3------
# load data
surveydata <- base::readRDS(url("https://slcladal.github.io/data/sud.rda", "rb"))

# calculate cronbach's alpha
Cronbach <- psych::alpha(surveydata[c("Q01_Outgoing",  "Q02_Outgoing",  "Q03_Outgoing",   "Q04_Outgoing",  "Q05_Outgoing")], check.keys=F)
# inspect results
Cronbach


# activate package
library(ufs)
# extract reliability measures
reliability <- ufs::scaleStructure(surveydata[c("Q01_Outgoing", 
                                                "Q02_Outgoing", 
                                                "Q03_Outgoing", 
                                                "Q04_Outgoing", 
                                                "Q05_Outgoing")])
# inspect results
print(reliability)


# remove respondent
surveydata <- surveydata %>% 
  dplyr::select(-Respondent)
factoranalysis <- factanal(surveydata, 3, rotation="varimax")
print(factoranalysis, digits=2, cutoff=.2, sort=TRUE)

# plot factor 1 by factor 2
load <- factoranalysis$loadings[,1:2]
# set up plot
plot(load, type="n", xlim = c(-1.5, 1.5)) 
# add variable names
text(load,
     # define labels
     labels=names(surveydata),
     # define font size 
     # (smaller than default = values smaller than 1)
     cex=.7)

