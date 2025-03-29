#likert - HH Package

#https://cran.r-project.org/web/packages/HH/HH.pdf
#https://jakec007.github.io/2021-06-23-R-likert/
pacman::p_load(HH, tidyverse, googlesheets4,dplyr)
#HH package

gsid ='1ADzEu-1kh7f-8Z312YAnO_TgXg96nXqcKvmU-Cy3MLo'
gs4_auth(email = "dup1966@gmail.com")
sheet_names(gsid)

qc1 <- read_sheet(gsid, sheet = "qc1", skip=1)
scales <- read_sheet(gsid, sheet = "scales", skip=1)                   
head(qc1)
head(scales)



sfeedback = expand.grid(qc1$qno, sno)
names(sfeedback) = c("qno", "sno")
head(sfeedback)
(sfeedback <- sfeedback %>% mutate(rating = sample(x=c(1L:5L), size=nrow(.), replace=T)) )
head(sfeedback)

#mergeDF------
#ratings + scaleValue
(sfdbackValue <- merge(sfeedback, scales %>% dplyr::select(rValue, scaleValue), by.x="rating", by.y='rValue'))

(sData1 <- merge(qc1 %>% dplyr::select(-c(ratingScale)), sfdbackValue, by="qno"))
names(sData1)
head(sData1)
sData1 <- sData1 %>% mutate(scaleValue = fct_reorder(scaleValue, rating))
head(sData1)
?fct_reorder
sData1 %>% group_by(qno, question, category, scaleValue) %>% summarise(n=n()) %>% ggplot(., aes(x=scaleValue, y=qno, fill=n)) + geom_tile(color='black') + geom_text(aes(label=n)) + theme_minimal() + labs(title="Rating of Mr. Dhiraj's Students", x="Rating", y="Frequency")  + facet_wrap(category ~. , scales='free') + scale_fill_gradient2(high='yellow', midpoint = 20, low='green') + theme(axis.text.x = element_text(angle = 90, hjust = 1))

(sData2 <- sData1 %>% group_by(qno, question, category, scaleValue) %>% summarise(n=n()) %>% pivot_wider(names_from = scaleValue, values_from = n))

HH::likert(question ~., data=sData2 %>% dplyr::select(-category))

HH::likert(question ~., data=sData2 %>% dplyr::select(-category), as.percent=TRUE)

HH::likert(question ~., data=sData2 %>% dplyr::select(-category), as.percent=TRUE, positive.order = F, main= list('Survey on Teacher by Students', x=unit(.55,'npc')), sub=list('Teacher-Dhiraj, Students -100' ))

HH::likert(question ~.| category, data=sData2, as.percent=F, strip=T, layout=c(1,3), scales=list(y=list(relation="free")))

library(RColorBrewer)
plot(HH::likert(question ~.| category, data=sData2, as.percent=F, strip=F, strip.left=T , layout=c(1,3), scales=list(y=list(relation="free")), ReferenceZero = 0, between=list(y=1), ylab='Question', col = brewer.pal(n=5, name='Set1')), centere=F )




HH::likert(question ~.| category, data=sData2, as.percent=F, strip=T, layout=c(1,3), scales=list(y=list(relation="free")), ReferenceZero = 3, between=list(y=1), ylab='Question', col = brewer.pal(n=5, name='Set1'), auto.key = list(columns=5, reverse.rows=T, plot.percent.high=FALSE), center=3)   

#good------
plot(likert(summary = sData2))
#longData-----
(sData3 <- sData1 %>% group_by(qno, question, category, scaleValue) %>% summarise(n=n()))
head(sData3)
plot(likert(sData3[,c(1,2,4,5)], grouping = sData3[,3]))
HH::likert(question ~.| category, data=sData2, as.percent=F, strip=F, strip.left=T , layout=c(1,3), scales=list(y=list(relation="free")), ReferenceZero = 0, between=list(y=1), ylab='Question', col = brewer.pal(n=5, name='Set1'), plot.percent.neutral=T, plot.percent.low=T)

likert(question ~ scaleValue | category, value="n", data=sData3, ylab=NULL, scales=list(y=list(relation="free")), layout=c(1,3))

#percentNos----------
plot2 <- LikertPercentCountColumns(question ~.| category, data=sData2, layout=c(1,3), scales=list(y=list(relation="free")),  ylab=NULL, between=list(y=0), strip.left=strip.custom(bg="gray97"), strip=FALSE, par.strip.text=list(cex=.7), main="Is AI important in Education ?", col = brewer.pal(n=5, name='Set2'))
plot2
plot(plot2, value=T)


#https://jakec007.github.io/2021-06-23-R-likert/
#https://xang1234.github.io/likert/
#https://cran.r-project.org/web/packages/HH/HH.pdf


