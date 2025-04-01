# HHE Classes

pacman::p_load(tidyverse, googlesheets4, lubridate)
# HHE Classes
gsHC ='1-uy0H-mDDuTeQ5_412vK_i7pIiL0o9nOP_s2oDfjjE8'

gs4_auth(email = "dup1966@gmail.com")
sheet_names(gsHC)
cdone <- read_sheet(gsHC, sheet = "classportal",  skip=1, col_types = 'iDiDccccccccccccccc')
head(cdone)
s= parse_date_time(str_extract("8:00PM-10:00PM", "^[^-]+"), orders = "I:%M%p")
e= parse_date_time(str_extract("8:00PM-10:00PM", "(?<=-).+$"), orders = "I:%M%p")
(dmin = as.numeric(difftime(e, s, units = "mins")))

names(cdone)
(cdone2 <- cdone %>% mutate( start_time = parse_date_time(str_extract(classTiming, "^[^-]+"), orders = "I:%M%p"), end_time = parse_date_time(str_extract(classTiming, "(?<=-).+$"), orders = "I:%M%p"))  %>% mutate( dur_min = as.numeric(difftime(end_time, start_time, units = "mins")), pcount = as.integer(pcount)) %>% dplyr::select(cDate, cDay, batchID, batchSDate, course, classTiming, pcount, dur_min, claimed) %>% filter(is.na(claimed)))

#summarise------
cdoneS1 <- cdone2 %>% group_by(cDate) %>% summarise(batches=n(), batchIDs= paste(batchID, collapse = ", "), duration = max(dur_min, na.rm=T), students = sum(pcount, na.rm=T)) %>% arrange(desc(cDate)) %>% clipr::write_clip(.)
cdoneS1
hrs = sum(cdoneS1$duration)/60
cat("Total hours of classes:", hrs, "\n and amount " , hrs*1500 , " INR")
