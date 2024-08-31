# misc

fruits <- c('apple', 'banana', 'cherry', 'date','apple')
fruits
has_apple <- any(grep('^apple$', fruits, value=F))
grep('^apple$', fruits, value=T)
has_apple

?any
?grep
