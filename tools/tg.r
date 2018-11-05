library(dplyr)

# Summarize ToothGrowth data
tg <- ToothGrowth %>%
  group_by(supp, dose) %>%
  summarise(length = mean(len)) %>%
  as.data.frame()

save(tg, file="../data/tg.rda")
