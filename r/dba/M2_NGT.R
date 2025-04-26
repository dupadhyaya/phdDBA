#M2 NGT Technique

# Load necessary libraries# Sample structure
pacman::p_load(tidyr, googlesheets4, tidytext)

#sampleData
df <- data.frame( participant = c('P1', 'P1', 'P1', 'P2', 'P2'),  idea = c('Login Frequency', 'Quiz Scores', 'Time Spent', 'Quiz Scores', 'Login Frequency'),  score = c(5, 4, 3, 5, 4))
df

summary_df <- df %>% group_by(idea) %>%  summarise(  total_score = sum(score, na.rm = TRUE), vote_count = n() ) %>% arrange(desc(total_score))
summary_df

#visualise-------
ggplot(summary_df, aes(x = reorder(idea, total_score), y = total_score)) + geom_col(fill = "skyblue") + coord_flip() +  labs(title = "NGT Prioritization Results", x = "Idea", y = "Total Score")


#qualitativeAnalysis------
# Create corpus of raw ideas and use word frequency or topic modeling
ideas_df <- data.frame(text = c("login frequency", "time on LMS", "discussion forum activity"))

ideas_df %>% unnest_tokens(word, text) %>% count(word, sort = TRUE)

#Technique, Purpose Tools
#Rank Aggregation, Combine ranks from multiple participants,RankAggreg or prefmod in R 
#Thematic Analysis, Cluster ideas into categories, Manual coding or NLP
#Sentiment Analysis, If ideas have detailed feedback; syuzhet, textdata
#Word Clouds; Visualize dominant words from open-text; wordcloud, ggwordcloud

library(RankAggreg)
rankings <- list( c("Quiz Scores", "Login Frequency", "Forum Posts", "Time Spent", "Assignments"), c("Login Frequency", "Time Spent", "Quiz Scores", "Assignments", "Forum Posts"), c("Forum Posts", "Assignments", "Quiz Scores", "Time Spent", "Login Frequency"), c("Time Spent", "Quiz Scores", "Forum Posts", "Login Frequency", "Assignments"), c("Quiz Scores", "Time Spent", "Login Frequency", "Forum Posts", "Assignments"))
rankings
ranking_matrix <- do.call(rbind, rankings)
unlist(rankings)
matrix(unlist(rankings), nrow = length(rankings), byrow = TRUE)
ranking_matrix
split(ranking_matrix, seq(nrow(ranking_matrix)))


result <- RankAggreg(ranking_matrix, k = 5, method = "GA", seed = 123)
#k = 5: Number of top items to extract
#method = "GA": Uses Genetic Algorithm (also "CE" = Cross-Entropy method)

print(result)


#prefmod---------
library(prefmod)
# Sample: 3 ideas ranked by 3 respondents
# Sample ranking data: 4 items ranked by 3 participants
ranks <- data.frame(  id = 1:3,
    A = c(1, 2, 4),
    B = c(2, 1, 3),
    C = c(3, 4, 2),
    D = c(4, 3, 1)
  )
ranks
# Drop ID column when passing to llbt.design
(rank_matrix <- ranks[, -1])

# Define number of items
(n_items <- ncol(rank_matrix))
# Now generate the design matrix with proper number of items
llbt_data <- llbt.design(data=ranks, X = rank_matrix, subject = ranks$id,  nitems = n_items)
# Check design matrix
head(llbt_data$y)
