#probability

library(PASWR)
library(tidyverse)


Money_Spent <- c("High", "Low", "High", "High","Low", "Low", "High", "Low",  "Low", "High", "Low", "Low","High", "High", "High")
Frequency <- c("Less", "More", "More", "Less", "Less", "More", "More", "Less", "Less", "More", "More", "Less", "Less", "More", "Less")
Customer <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)

# Customer Data Frame
Customer_Data <- as.data.frame(cbind(Customer, Money_Spent, Frequency))
Customer_Data
Customer_Data %>%  count(Money_Spent, Frequency, sort=T)


Customer_Data < - probspace(Customer_Data)
Customer_Data