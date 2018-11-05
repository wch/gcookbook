
library(reshape2)
# GDP per capita in adjusted year 2011 USD
# Source: World Bank
gdp <- read.csv('data/gdp.csv')

gdp <- melt(gdp, id.vars=1:2, value.vars=3:ncol(gdp),
            variable.name = "Year", value.name="GDP")

gdp$Year <- sub("X", "", gdp$Year)

gdp$Year <- as.integer(gdp$Year)



# Health expenditures per capita in adjusted year 2000 USD
# Source: World Bank
healthexpenditure <- read.csv('data/healthexpenditure.csv')

healthexpenditure <- melt(healthexpenditure, id.vars=1:2, value.vars=3:ncol(healthexpenditure),
                          variable.name = "Year", value.name="healthexp")

healthexpenditure$Year <- sub("X", "", healthexpenditure$Year)

healthexpenditure$Year <- as.integer(healthexpenditure$Year)



# Infant mortality per 1000 live births
# Source: World Bank
infantmortality <- read.csv('data/infantmortality.csv')

infantmortality <- melt(infantmortality, id.vars=1:2, value.vars=3:ncol(infantmortality),
                          variable.name = "Year", value.name="infmortality")

infantmortality$Year <- sub("X", "", infantmortality$Year)

infantmortality$Year <- as.integer(infantmortality$Year)


# Labor rate (15+ years)
# Source: World Bank
laborrate <- read.csv('data/laborrate.csv')

laborrate <- melt(laborrate, id.vars=1:2, value.vars=3:ncol(laborrate),
                  variable.name = "Year", value.name="laborrate")

laborrate$Year <- sub("X", "", laborrate$Year)

laborrate$Year <- as.integer(laborrate$Year)



countries <- merge(gdp, laborrate, all=TRUE)

countries <- merge(countries, healthexpenditure, all=TRUE)

countries <- merge(countries, infantmortality, all=TRUE)

# Rename first two columns
names(countries)[1:2] <- c("Name", "Code")


if(F) {


gdp <- subset(gdp, Year >= 1995)

ggplot(gdp, aes(x=Year, y=GDP, group=Country)) + geom_line(alpha=.2) +
    scale_y_log10()


}
