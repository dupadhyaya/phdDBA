#keyword extract
#https://www.iorad.com/player/1817333/Keyword-Analysis-using-R#trysteps-13
#https://bnosac.github.io/udpipe/docs/doc0.html
pacman::p_load(tidyverse, udpipe)

udmodel <- udpipe_download_model(language='english')

udmodel <- udpipe_load_model(file = udmodel$file_model)
text1="I am going to the office which is located at Amity University, Noida"
x <- udpipe_annotate(udmodel, x = text1)
x <- as.data.frame(x, detailed = TRUE)
x
table(x$upos)
table(x$dep_rel)
udpipe(x=text1, object='english')
