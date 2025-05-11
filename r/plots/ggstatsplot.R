# plots in ggplot2

pacman::p_load(ggstatsplot, tidyverse, patchwork)


ggdotplotstats(mtcars, x=am, y=mpg, test.value = 25)

ggscatterstats(mtcars, x=mpg, y=wt)

ggcorrmat(mtcars)
print('Hello World')

ggpiestats(mtcars, x=am, y=cyl, title='Pie chart of am and cyl in mtcars dataset', caption='Source: mtcars dataset from R datasets package. Data visualization by ggstatsplot', results.subtitle = F)

ggbarstats(mtcars, x=am, y=cyl, title='Bar chart of am and cyl in mtcars dataset', caption='Source: mtcars dataset from R datasets package. Data visualization by ggstatsplot', results.subtitle = F)

grouped_ggpiestats(mtcars, x=cyl, grouping.var = am, results.subtitle =F, subtitle='Pie Chart : % of Cars Cyl type for each am') + plot_annotation(title =' Cyl vs AM')

grouped_ggbarstats(mtcars, x=cyl, y=vs, grouping.var = am, results.subtitle =F, subtitle='Pie Chart : % of Cars Cyl type for each am') + plot_annotation(title =' Cyl vs AM')


ggbetweenstats(mtcars, x=cyl, y=mpg, ggtheme=ggthemes::theme_economist(), palette='Darjeeling2', package = 'wesanderson')

ggbetweenstats(iris, x=Species, y=Sepal.Length)

ggbetweenstats(iris, x=Species, y=Sepal.Length, centrality.plotting = TRUE, bf.message=F, pairwise.display='none', results.subtitle=F, centrality.plotting.type = 'boxplot', centrality.plotting.args = list(outlier.shape = NA))


(stats_expr <- ggpiestats(Titanic_full, Survived, Sex) %>% extract_subtitle())
ggiraphExtra::ggSpine(data= Titanic_full, aes(x=Sex, y=Survived)) + labs(subtitle = stats_expr)               

#------
ggbetweenstats(mtcars, x=cyl, y=wt, type='p')
ggscatterstats(mtcars, x=wt, y=mpg, type='p')
gghistostats(mtcars, x=wt, test.value=2, type='p')

#nonparametric------
ggbetweenstats(mtcars, x=cyl, y=wt, type='np')
ggscatterstats(mtcars, x=wt, y=mpg, type='np')
gghistostats(mtcars, x=wt, test.value=2, type='np')
