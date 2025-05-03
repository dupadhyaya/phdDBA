#likert Data Examples

pacman::p_load(likert, tidyverse)
tidyverse_conflicts()

data(MathAnxietyGender)
head(MathAnxietyGender)
#A data frame of presummarized results of the Math Anxiety Scale Survey administered to 20 students in a statistics course grouped by gender.

data("pisaitems")
head(pisaitems)
#a data frame 66,690 ovservations of 81 variables from North America.

(items29 <- pisaitems[,substr(names(pisaitems), 1,5) == 'ST25Q']) #fewcols
names(items29) <- c("Magazines", "Comic books", "Fiction", "Non-fiction books", "Newspapers")
head(items29)
l29 <- likert::likert(items29)
head(l29)
l29

data(sasr)
head(sasr)
#a data frame with 860 obvservations of 63 variables

#mass------
data(mass)
head(mass)
#data frame with 14 rows and 6 columns.
str(mass)

#gap
data(gap)
head(gap)
#a data frame with 68 ovservations of 11 variables.
names(gap)




#manual Data------
# Create a data frame with Likert scale responses
#6 attributes, 5 levels, 10 respondents
(attributes = c("Attribute1", "Attribute2", "Attribute3", "Attribute4", "Attribute5", "Attribute6"))
(levels1 = c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"))
(levels2 = c("SD", "D", "N", "A", "SA"))
(respondents = paste0("R", str_pad(1:10, width=2, side='left', pad='0')))
# Create a data frame with Likert scale responses
set.seed(123)  # For reproducibility
(likert_data <- expand.grid(Attribute = attributes, Respondent = respondents))
likert_data$Response <- sample(levels2, nrow(likert_data), replace = TRUE)
head(likert_data)
# Convert the Response column to a factor with ordered levels
likert_data$Response <- factor(likert_data$Response, levels = levels2, ordered = TRUE)
# Check the structure of the data
str(likert_data)
head(likert_data)
likertDL1 <- likert_data %>% pivot_wider(names_from = Attribute, values_from = Response) 

likertDL2 <- likert_data %>% pivot_wider(names_from = Attribute, values_from = Response) %>% mutate_at(vars(starts_with('Attribute')), list( ~ case_when(
  . == "SD" ~ 1,
  . == "D" ~ 2,
  . == "N" ~ 3,
  . == "A" ~ 4,
  . == "SA" ~ 5
))) 
str(likertDL2)
likertDL2B <- likertDL2 %>% mutate_if(is.numeric, ~ as.factor(.))
str(likertDL2B)
head(likertDL2B)
#tolikert
HH::likert(likertDL2B %>% dplyr::select(-c(Respondent)))

# Create a Likert object
likert_obj <- HH::likert(Response ~ Attribute, data = likert_data)
likert_obj

clevels2 = c(1L:5L)
likertDL2C <- likertDL2B %>% column_to_rownames(var='Respondent')
likertDL2C[] <- lapply(likertDL2C, function(x) factor(x, levels = clevels2))

head(likertDL2C)
likert_obj2 <- likert::likert(likertDL2C)
likert_obj2
plot(likert_obj2, text.size = 3, plot.percent.low = TRUE, plot.percent.high = TRUE, wrap = 30)
