#M2 Data Generate for Data Collection NGT & Delphi - Practise Case

# Load necessary libraries# Sample structure
pacman::p_load(tidyr, googlesheets4, tidytext)

gsDC = '1MA6sNaJHKtpPo5wp1om7ta4L3EZp_oT6CGQLWWqr-00'
sheet_names(gsDC)

(ideas = read_sheet(gsDC, sheet = "data1A", skip=2, col_types = 'Dccccccc'))
ideaNames = c('LoginFreq', 'Duration', 'Assignment', 'Forum',	'Assessment',	'PeerInteraction', 'Feedback', 'Survey','Gamification')
pno = c('P1', 'P2', 'P3', 'P4', 'P5','P6')
ino = c('I1', 'I2', 'I3', 'I4', 'I5','I6')
sample(ideaNames, 6)
set.seed(123)
(dfIdeas <- data.frame(idea = ino, P1= sample(ideaNames,6), P2 = sample(ideaNames,6),  P3 = sample(ideaNames,6), P4= sample(ideaNames,6), P5 = sample(ideaNames,6), P6 = sample(ideaNames,6)))
dfIdeas
dfIdeas %>% pivot_longer(cols=P1:P6, names_to='PN') %>% pivot_wider(names_from='idea', values_from = 'value') %>% clipr::write_clip(.)
 
#same way select values between 1 to 6--------
imp = c(1:6)
(dfImp <- data.frame(idea = ino, P1= sample(imp,6), P2 = sample(imp,6),  P3 = sample(imp,6), P4= sample(imp,6), P5 = sample(imp,6), P6 = sample(imp,6)))

dfImp %>% pivot_longer(cols=P1:P6, names_to='PN') %>% pivot_wider(names_from='idea', values_from = 'value') %>% clipr::write_clip(.)
