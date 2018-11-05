pkgdir <- rprojroot::find_package_root_file()

download.file(
  "http://berkeleyearth.lbl.gov/auto/Global/Complete_TAVG_complete.txt",
  file.path(pkgdir, "tools/data/climate.txt")
)

library(plyr)
# Load berkeley climate data
climateberk <- read.delim(file.path(pkgdir, "tools/data/climate.txt"), header=TRUE, sep="", comment.char="%")

# Collapse within each year
climateberk <- ddply(climateberk, "Year", summarise, Anomaly10y=mean(Anomaly10y), Unc10y=mean(Unc10y))

# Round to 3 digits
climateberk <- transform(climateberk, Anomaly10y=round(Anomaly10y, 3), Unc10y=round(Unc10y, 3))

# Remove NaN entries
climateberk <- climateberk[!is.nan(climateberk$Anomaly10y),]

climateberk$Source <- "Berkeley"




# Columbia/NASA GISS data
climatecolm <- read.delim("data/climate-columbia.txt", header=TRUE, sep="", comment.char="#")

# Get year and month
climatecolm$Year  <- floor(climatecolm$YearMonth)
climatecolm$Month <- round((climatecolm$YearMonth %% 1) * 12 + .5)

# Adjustment factor - we want to adjust relative to 1951-1980 mean
#col.adj <- mean(climatecolm$Anomaly[climatecolm$Year >= 1951 & climatecolm$Year <= 1980])
climatecolm$Anomaly <- climatecolm$Anomaly - col.adj

# Smooth data
ma <- function(x,n=5){filter(x, rep(1/n,n), sides=2)}
climatecolm$Anomaly1y  <- ma(climatecolm$Anomaly,12)
climatecolm$Anomaly5y  <- ma(climatecolm$Anomaly,60)
climatecolm$Anomaly10y <- ma(climatecolm$Anomaly,120)

# Weird way of getting month of June, with value .458. Seems to be some
# issue with comparison of floating point, so multiply by 1000
#climatecol <- subset(climatecolm, ((Year*1000)%%1000) == 458)

# Collapse within each year
climatecol <- ddply(climatecolm, "Year", summarise,
                     Anomaly1y  = mean(Anomaly1y),
                     Anomaly5y  = mean(Anomaly5y),
                     Anomaly10y = mean(Anomaly10y))
climatecol$Source <- "NASA"



# ==========================================================================
# CRUTEM3 data

climatecru.all <- read.delim("data/climate-crutem3.txt", header=FALSE, sep="", comment.char="#")

names(climatecru.all)[1] <- "Year"

climatecru.temp    <- climatecru.all[seq(1,nrow(climatecru.all), 2),]
climatecru.percent <- climatecru.all[seq(2,nrow(climatecru.all), 2),]

climatecru <- climatecru.temp[,c("Year","V14")]
names(climatecru)[2] <- "Anomaly1y"

# Adjustment factor - Data is normalized for 1961-1990 mean, and
# we want to adjust relative to 1951-1980 mean
cru.adj <- mean(climatecru$Anomaly1y[climatecru$Year >= 1951 & climatecru$Year <= 1980])
climatecru$Anomaly1y <- climatecru$Anomaly1y - cru.adj


# Smooth data
climatecru$Anomaly10y  <- ma(climatecru$Anomaly1y,10)

climatecru$Source <- "CRUTEM3"



# Combine the data
climate <- rbind.fill(climateberk, climatecol, climatecru)
climate <- climate[,c("Source","Year","Anomaly1y","Anomaly5y","Anomaly10y","Unc10y")]

# Save
save(climate, file = "../data/climate.rda")



#ppi = 96
#png('data/climate.png', width=10*ppi, height=4*ppi, res=ppi)
ggplot(climateberk, aes(x=Year, y=Anomaly10y)) +
    geom_ribbon(aes(ymin=Anomaly10y-Unc10y, ymax=Anomaly10y+Unc10y),
                alpha=.1) +
    geom_line() +
    geom_line(data=climatecol, colour="blue") +
    geom_line(data=climatecru,  colour="red") +
    ylim(-1, 1) +
    theme_bw()
#dev.off()


