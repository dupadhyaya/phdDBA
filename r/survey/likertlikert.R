#likert package - another way
pacman::p_load(likert, tidyverse)

# Example: assume sData2 contains Likert responses across multiple items grouped by category
# Make sure your items are factors with ordered levels

(sno = paste0("S", str_pad(1:150, width=3, side='left', pad='0')))
(questionsNos = paste('Q', str_pad(1:10, width=2, side='left', pad='0'), sep=''))
(svData1 <- expand.grid(questionsNos, sno))
names(svData1) = c("qno", "sno")
svData1$ratingNo = sample(x=c(1L:5L), size=nrow(svData1), replace=T)
head(svData1)

svData2 <- merge(svData1, scales %>% dplyr::select(rValue, scaleValue), by.x="ratingNo", by.y='rValue') 
head(svData2)

svData3 <- svData2 %>% mutate(scaleValue = fct_reorder(scaleValue, ratingNo)) %>% dplyr::select(-c(ratingNo)) %>%  pivot_wider(names_from = qno, values_from = scaleValue) 
head(svData3)
sapply(svData3[c(2:11)], levels)
# Apply to all Likert item columns
svData3[2:11] <- lapply(svData3[2:11], function(x) {
  factor(x, levels = likert_levels, ordered = TRUE)
})
lik_data <- likert::likert(items = svData3B[,-c('sno')])  # or add grouping if needed


likert_levels <- c("StronglyDisagree", "Disagree", "Neutral", "Agree", "StronglyAgree")
svData3$Q01 <- factor(svData3$Q01, levels = likert_levels, ordered = TRUE)
svData3$Q02 <- factor(svData3$Q02, levels = likert_levels, ordered = TRUE)
svData3$Q03 <- factor(svData3$Q03, levels = likert_levels, ordered = TRUE)

(svData3B <- svData3 %>% dplyr::select(c(sno, Q01, Q02, Q03)))

sapply(svData3[c(2:11)], levels)
lik_data <- likert::likert(items = svData3B[, c("Q01", "Q02", "Q03")],  grouping = svData3B$Group)

#example2----------
df <- data.frame(
  RespondentID = 1:4,
  Q1 = factor(c("Agree", "Neutral", "Strongly Agree", "Disagree"), levels = c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"), ordered = TRUE),
  Q2 = factor(c("Disagree", "Neutral", "Agree", "Strongly Agree"), levels = c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"), ordered = TRUE),
  Q3 = factor(c("Neutral", "Agree", "Agree", "Disagree"), levels = c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"), ordered = TRUE))
df1 <- data.frame(
  RespondentID = 1:4,
  Q1 = factor(c("Agree", "Neutral", "StronglyAgree", "Disagree"), levels = c("StronglyDisagree", "Disagree", "Neutral", "Agree", "StronglyAgree"), ordered = TRUE),
  Q2 = factor(c("Disagree", "Neutral", "Agree", "StronglyAgree"), levels = c("StronglyDisagree", "Disagree", "Neutral", "Agree", "StronglyAgree"), ordered = TRUE),
  Q3 = factor(c("Neutral", "Agree", "Agree", "Disagree"), levels = c("StronglyDisagree", "Disagree", "Neutral", "Agree", "StronglyAgree"), ordered = TRUE),
  Q4 = factor(c("Neutral", "Agree", "Agree", "Disagree"), levels = c("StronglyDisagree", "Disagree", "Neutral", "Agree", "StronglyAgree"), ordered = TRUE),
  Q5 = factor(c("Agree", "Agree", "Agree", "Agree"), levels = c("StronglyDisagree", "Disagree", "Neutral", "Agree", "StronglyAgree"), ordered = TRUE))

df1
str(df1)
library(likert)

# Create likert object (excluding ID and Group columns)
(lik_data <- likert::likert(items = df[, c("Q1", "Q2", "Q3")], grouping = df$Group))
str(lik_data)
(lik_data2 <- likert::likert(items = df1[, c("Q1", "Q2", "Q3", "Q4", "Q5")], grouping = df1$Group))
plot(lik_data2, text.size = 3, plot.percent.low = TRUE, plot.percent.high = TRUE, wrap = 30)

#--------

(df3 = svData3 %>% dplyr::select(-c(sno)))
(lik_data3 <- likert::likert(items = df3[, c("Q01", "Q02", "Q03", "Q04", "Q05")], grouping = df3$Group))


`# Plot with labels
plot(lik_data, text.size = 3, plot.percent.low = TRUE, plot.percent.high = TRUE, wrap = 30)

