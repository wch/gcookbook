simpledat <- read.table(header=TRUE, con <- textConnection('
   A1 A2 A3
B1 10  7 12
B2 9  11 6
'))
close(con); rm(con)

simpledat <- as.matrix(simpledat)


save(simpledat, file="data/simpledat.rda")


# Convert to long format
library(reshape2)
simpledat_long <- melt(simpledat)
names(simpledat_long)[1:2] <- c("Bval","Aval")
simpledat_long <- subset(simpledat_long, select = c(Aval, Bval, value))

save(simpledat_long, file="data/simpledat_long.rda")
