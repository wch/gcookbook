uspopchange <- read.csv("orig/data/uspopchange.csv", comment.char = "#", stringsAsFactors=FALSE)

uspopchange <- uspopchange[,c(1,12)]

# Change in percent, from  2000 to 2010
names(uspopchange)[2] <- "Change"


# Drop "District of Columbia"
uspopchange <- subset(uspopchange, State!="District of Columbia")

# Add in State abbreviations
uspopchange$Abb <- state.abb

# Add region
uspopchange$Region <-state.region
# Reorder cols
uspopchange <- uspopchange[,c(1,3,4,2)]


save(uspopchange, file="data/uspopchange.rda")
