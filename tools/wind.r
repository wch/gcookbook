
# http://www.glerl.noaa.gov/metdata/chi/
# Data from:
# http://www.glerl.noaa.gov/metdata/chi/2012/20120229.04t.txt

# Original columns
# 1:Station ID, Chicago=4
# 2:Year
# 3:Day of Year
# 4:Time, UTC
# 5:Average air temperature, Deg C
# 6:Wind Speed average m/s
# 7:Wind Speed maximum, m/s
# 8:Wind Direction, average, degrees from (0=north, 90=east)
wind <- read.table("data/wind20120229.04t.txt", header=TRUE, skip=1)
names(wind) <- c("ID", "Year", "Day", "TimeUTC", "Temp", "WindAvg", "WindMax", "WindDir")

wind <- subset(wind, Day == 60, select = 4:8)

wind$SpeedCat <- cut(wind$WindMax, breaks=c(0,5,10,15,20,Inf),
                     labels=c("<5", "5-10", "10-15", "15-20", ">20"))

wind$DirCat <- round(wind$WindDir/15) * 15
wind$DirCat[wind$DirCat ==360] <- 0

save(wind, file = "../data/wind.rda")
