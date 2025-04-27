# Import/ Export into Excel

# comment
pacman::p_load(readxl, tidyverse, xlsx, openxlsx)

#genrate  Data

#rollno, name, gender, english, arabic, science, biology, chemistry

n=100

(rollno = 1:100)

(name = paste('student', 1:100))

(biology = round(rnorm(n=n, mean=70, sd=6)))

(chemistry = round(rnorm(n=n, mean=75, sd=6)))

data = data.frame(rollno, name, biology, chemistry)

head(data)

write.xlsx(data, 'C:/DBA/sample.xlsx')

#read from excel

df <- read.xlsx('C:/DBA/sample.xlsx', sheet=1)

df

