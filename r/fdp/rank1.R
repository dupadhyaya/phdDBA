
pacman::p_load(googlesheets4, tidyverse, ggrepel)
gsid ='1MagYdOv3UgSiW5nRkvuidb90twOujxNeXNgtOdoeOt0'

df = read_sheet(gsid, sheet='rank') 
df

df$rankGp <- factor(df$rankGp, levels = c("50-100", "200-300", "300-400"))

df <- df %>%  mutate( year_num = as.numeric(as.character(year)),    rankGp_num = as.numeric(rankGp)  )
df
df %>% ggplot(., aes(y=factor(rankGp), x=factor(year))) + geom_point() + geom_line(aes(group=campus, color=campus)) + ggrepel::geom_text_repel(aes(label=campus, color=campus))

segment_labels <- df %>%  arrange(campus, year_num) %>%  group_by(campus) %>%  mutate(    year_num_next = lead(year_num),    rankGp_num_next = lead(rankGp_num)  ) %>%  filter(!is.na(year_num_next)) %>%  mutate(    x = (year_num + year_num_next)/2 + .1,    y = (rankGp_num + rankGp_num_next)/2 + .1  ) 
df
ggplot(df, aes(x = year, y = rankGp, group = campus, color = campus)) + geom_line(size = 1) +  geom_point(size = 3) +  ggrepel::geom_label_repel(aes(label = campus, color=campus), fill = "white", size = 4, fontface = "bold", show.legend = FALSE, label.size = 0.25) +    geom_label(    data = segment_labels, aes(x = x, y = y, label = campus, group = campus, color = campus),  fill = "gray95", color = "black", size = 3, fontface = "plain", show.legend = FALSE, label.size = 0.15, inherit.aes = FALSE
  )  +   labs(x = "Year", y = "Rank Group", color = "Campus",       title = "Campus Rank Groups Over Years (Segment Labels)") +
  theme(       legend.position = "right"  ) + guides(color='none')
?scale_x_discrete()
