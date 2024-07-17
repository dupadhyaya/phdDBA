#thematic analysis
#other- Nvivo : R(RQDA-not avl)
#https://guides.library.illinois.edu/qualitative/rforqda
#https://bookdown.org/daniel_dauber_io/r4np_book/mixed-methods-research.html
pacman::p_load(tidyverse, tidytext)

(sentence <- "This car, is my car.")
# Convert text object into a data frame
(df_text <- tibble(text = sentence))

#Tokenisation
(df_text <- df_text %>% unnest_tokens(output = word,  input = text))
#all words to lowercase

df_text %>% count(word)

df_text %>%  count(word) %>%   ggplot(aes(x = word,   y = n)) + geom_col()

#remove noise-----
stop_words
#are words that we want to exclude from our analysis, because they carry no particular meaning. The tidytext package comes with a data frame that contains common stop words in English.
