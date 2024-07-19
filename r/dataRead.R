# data from different sources

folder1 ='./data/'
dir(folder1)
#csv-------
(dfcsv = read.csv(file = paste0(folder1,'fdata4CSV.csv')))

#excel-------
?readxl::read_xlsx
(dfxl1= readxl::read_excel(path = paste0(folder1,'phdXL.xlsx'),sheet='fdata4'))



#googlesheet------


#webPage->table-------


