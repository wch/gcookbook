pkgdir <- rprojroot::find_package_root_file()

master <- read.csv(file.path(pkgdir, 'tools/data/BaseballMaster.txt'), header=FALSE)
master <- master[,c(2,17,18)]

# Load the table of name-id mapping
names(master) <- c(
  "id",
  "first",
  "last")

master$first <- as.character(master$first)
master$last  <- as.character(master$last)
master$name  <- paste(master$first, master$last)


# Load batting stats
batting <- read.csv(file.path(pkgdir, 'tools/data/Batting.txt'), header=FALSE)
names(batting) <- c(
  "id",
  "year",
  "stint",
  "team",
  "lg",
  "g",
  "g_batting",
  "ab",
  "r",
  "h",
  "2b",
  "3b",
  "hr",
  "rbi",
  "sb",
  "cs",
  "bb",
  "so",
  "ibb",
  "hbp",
  "sh",
  "sf",
  "gidp",
  "g_old")

# Merge the two tables
batting <- merge(master, batting, by="id")

# Don't save, since it's not used in the book (book uses tophitters2001)
#save(batting, file = "../data/batting.rda")



# Make the tophitters2001 data set --------------------------------------------

# Get only data for one year, drop those with <450 at-bats
tophitters2001 <- subset(batting, year==2001 & ab>=450)

# Drop unused factor levels
tophitters2001$id   <- factor(tophitters2001$id)
tophitters2001$team <- factor(tophitters2001$team)
tophitters2001$lg   <- factor(tophitters2001$lg)

# Drop some unused columns
tophitters2001$g_batting <- NULL
tophitters2001$g_old <- NULL

# Calculate batting averages
tophitters2001$avg <- tophitters2001$h / tophitters2001$ab

# Round
tophitters2001$avg <- round(tophitters2001$avg, 4)

# sort descending by average
library(plyr)
tophitters2001 <- arrange(tophitters2001, desc(avg))

save(tophitters2001, file = file.path(pkgdir, "data/tophitters2001.rda"))
