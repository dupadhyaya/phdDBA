# Coding in R



library(tidytext)
library(dplyr)
library(stringr)

responses <- data.frame( id = 1:3,  text = c(  "I prefer online learning because it gives me flexibility.",   "Blended learning works best because I get the structure and freedom.", "I like classroom learning since I can interact with peers.") )


# Tokenize words
tokens <- responses %>% unnest_tokens(word, text)
tokens
# Filter common words or match keywords
coded <- tokens %>% filter(word %in% c("flexibility", "structure", "freedom", "interact", "peers")) %>% group_by(id) %>%  summarise(theme_keywords = paste(word, collapse = ", "))

coded


