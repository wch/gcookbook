library(reshape2)
library(plyr)

rest_bills <- ddply(tips, .(day), summarise, mean_bill=mean(total_bill))
rest_bills$day <- relevel(rest_bills$day, "Thur")
rest_bills <- arrange(rest_bills, day)
rest_bills$mean_bill <- round(rest_bills$mean_bill, digits=2)
rest_bills

save(rest_bills, file = "../data/rest_bills.rda")
