library(plyr)
pg_mean <- ddply(PlantGrowth, "group", summarise, weight = mean(weight))

save(pg_mean, file="data/pg_mean.rda")
