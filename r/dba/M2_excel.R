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

colSums(df[,4])
colSums(df[, 3:4], na.rm = TRUE)


df = read.csv('students1.csv')




#---------------
library(openxlsx)

n = 50
rollno = 1:n

chemistry = round(runif(n, min = 0, max = 80)) 

biology = round(runif(n, min = 0, max = 80))  

chemistry = round(runif(n, min = 0, max = 80))  

english = round(runif(n, min = 0, max = 60))

(arabic = round(runif(n, min = 0, max = 60)))  

(french = round(runif(n, min = 0, max = 30)))  

data = data.frame(rollno, biology, chemistry, english, arabic, french)

head(data)
colSums(data[, 2:6], na.rm = TRUE)
colMeans(data[, 2:6], na.rm = TRUE)
(mean_biology = mean(data$biology))
hist(data$french)
cat("Biology mean:", mean_biology, "\n")

(mean_chemistry <- mean(data$chemistry))

cat("Chemistry mean:", mean_chemistry, "\n")

(mean_english = mean(data$english))

cat("English mean:", mean_english, "\n")

(mean_arabic = mean(data$arabic))

cat("Arabic mean:", mean_arabic, "\n")

mean_french = mean(data$french)

cat("French mean:", mean_french, "\n\n")

cat("Biology median:", median(data$biology), "\n")

cat("Chemistry median:", median(data$chemistry), "\n")

cat("English median:", median(data$english), "\n")

cat("Arabic median:", median(data$arabic), "\n")

cat("French median:", median(data$french), "\n\n")

get_mode <- function(v) {
  
  uniqv <- unique(v)
  
  uniqv[which.max(tabulate(match(v, uniqv)))]
  
}

cat("Biology mode:", get_mode(data$biology), "\n")

cat("Chemistry mode:", get_mode(data$chemistry), "\n")

cat("English mode:", get_mode(data$english), "\n")

cat("Arabic mode:", get_mode(data$arabic), "\n")

cat("French mode:", get_mode(data$french), "\n\n")

cat("Biology standard deviation:", sd(data$biology), "\n")

cat("Chemistry standard deviation:", sd(data$chemistry), "\n")

cat("English standard deviation:", sd(data$english), "\n")

cat("Arabic standard deviation:", sd(data$arabic), "\n")

cat("French standard deviation:", sd(data$french), "\n")

iqr_biology <- IQR(data$biology)

cat("IQR for Biology:", iqr_biology, "\n")

iqr_chemistry <- IQR(data$chemistry)

cat("IQR for Chemistry:", iqr_chemistry, "\n")

iqr_english <- IQR(data$english)

cat("IQR for English:", iqr_english, "\n")

iqr_arabic <- IQR(data$arabic)

cat("IQR for Arabic:", iqr_arabic, "\n")

iqr_french <- IQR(data$french)

cat("IQR for French:", iqr_french, "\n")

library(openxlsx)

write.xlsx(data, file = "C:/dba/rayan.xlsx")      

