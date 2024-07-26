# data from different sources

folder1 ='./data/'
dir(folder1)

#csv-------
(dfcsv = read.csv(file = paste0(folder1,'fdata4CSV.csv')))
dfcsv
#excel-------
?readxl::read_xlsx
(dfxl1= readxl::read_excel(path = paste0(folder1,'phdXL.xlsx'), sheet='fdata4'))


#googlesheet------
library(googlesheets4)
gsID = '17y0II7DL8276SzCbnur6_Peib1N1SJAGaL_vxVg7DjM'
sheet_names(ss=gsID)
wdd = read_sheet(ss=gsID, sheet='wdd', col_types = 'iDcccc')
wdd
str(wdd)


#webPage->table-------
library(rvest)
url1 = "https://en.wikipedia.org/wiki/List_of_countries_by_GDP_(PPP)_per_capita"
webpage <- read_html(url1) 
# Select the table using CSS selector 
table_node <- html_nodes(webpage, "table") 
# Extract the table content 
table_content <- html_table(table_node)[[2]] 
head(table_content)


url2 <- "https://www.worldometers.info/world-population/population-by-country/"
html_code <- read_html(url2)
table_html <- html_code %>% html_nodes('table') %>% .[[1]] %>% html_table()
head(table_html)

#Data can be read from many other formats

#end of topic---------