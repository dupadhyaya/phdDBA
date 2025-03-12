# gantt chart

pacman::p_load(tidyverse, googlesheets4)

gsid = '17y0II7DL8276SzCbnur6_Peib1N1SJAGaL_vxVg7DjM'

rplan <- read_sheet(ss=gsid, sheet='gantt', skip=0, col_types = 'icDD')
rplan
endRow <- rplan %>% summarise(item = 0, activity='Project Work', startDate= min(startDate), endDate = max(endDate))
rplan1 <- rplan %>% add_row(endRow)
rplan1
gGC1 <- rplan1 %>% mutate(days = endDate - startDate + 1, xpos= round(days/2), item = sprintf("%02d", item)) %>% ggplot(., aes(xmin=startDate, xmax=endDate, y=paste(item,activity), color=activity, group=activity)) + geom_point(aes(x=startDate, group = activity), color='black', size=3)  + geom_linerange(size = 8, position = position_dodge(width = 0.5)) + geom_text(aes(label=days, x=startDate+xpos), color='black') + geom_text(aes(label=startDate, x=startDate), color='black', angle=0, size=3, vjust=-1.5) +  labs(title = "PHD on xxxxxx :  Research : Plan/Execution",    x = "Start and Finish Dates of Activities",   y = "Activity") +  scale_colour_discrete() + theme_minimal(base_size = 16) + scale_x_date(date_labels = "%d-%b-%y") + guides(color='none')  + scale_y_discrete(limits=rev) + theme(plot.title = element_text(hjust=.5), panel.grid.major = element_line(color = "red",  size = 0.2,  linetype = 2))
gGC1

#endhere----
