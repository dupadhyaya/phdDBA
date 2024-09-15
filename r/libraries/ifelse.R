#ifelse


if (condition) {
  code block
} else {
  code block
}

#-----
if (condition) {
  code block
} else if (condition2) {
  code block
} else {
  code block
}

#-------

#for loop
(matches <- list(c(2,1),c(5,2),c(3,6)))

for (match in matches){
  if (match[1] > match[2]){
    print("Win")
  } else {
    print ("Lose")
  }
}


#------
ifelse(test, if_yes, if_no)

marks = c(25, 55, 75)
ifelse(marks >= 40, "pass", "fail")

(x <- 1:10)
(y <- ifelse(x %% 2 == 0,5,12))

#dplyr - if_else-----
if_else(condition, true, false, missing = NULL, ..., ptype = NULL, size = NULL)
library(dplyr)
(x <- c(-5:5, NA))
if_else(x < 0, NA, x)

starwars %>% select(height)
starwars %>%  mutate(category = if_else(height < 100, "short", "tall"), .keep = "used")

library(data.table)

(dates <- as.POSIXct(Sys.Date() + 1:20))
(dates2 <- as.POSIXct(Sys.Date() + 21:40))

(tmp <- data.table(date = dates, date2 = dates2))
(tmp[runif(20)>.8, date2 := NA])
tmp
tmp[, date3 := (ifelse(is.na(date2), date, date2) %>% as.POSIXct(origin = "1970-01-01"))]
tmp

#https://rdatatable.gitlab.io/data.table/reference/fifelse.html

(x = c(1:4, 3:2, 1:4))
fifelse(x > 2L, x, x - 1L)
