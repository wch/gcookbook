# 
# may need to add identifying variable
# 
# 86 house insulation in bristol
# 274 ramus heights
# 275 a soil experiment
# x 284 pneumonia risk in smokers with chickenpox
# x 372 Finger ridges of identical twins
# 
# putting data frames together (rbind, cbind, rbind.fill)

# 19 Plum root cuttings
plum_wide <- read.table('sds/plum.dat')
plum_wide[,3] <- NULL
names(plum_wide) <- c('dead', 'alive')
plum_wide$length <- c('long','long','short','short')
plum_wide$time  <- c('at_once','in_spring','at_once','in_spring')
plum_wide <- plum_wide[, c(3,4,1,2)]
plum <- melt(plum_wide, id.vars=c("length","time"), variable.name="survival", value.name="count")
save(plum_wide, file='sds/plum_wide.rda')
save(plum, file='sds/plum.rda')

# 55 cork deposits
cork <- read.table('sds/cork.dat')
names(cork) <- c("N", "E", "S", "W")
cork <- melt(cork, variable.name="direction", value.name="amount")
save(cork, file='sds/cork.rda')

# 94 wave energy device mooring
wavemooring <- read.table('sds/wave.dat')
names(wavemooring) <- c('seastate', 'method1', 'method2')
save(wavemooring, file='sds/wavemooring.rda')

# 100 homing in desert ants
anthoming_wide <- read.table('sds/ants.dat')
names(anthoming_wide) <- c('angle', 'expt', 'ctrl')
anthoming <- melt(anthoming_wide, id.vars="angle", variable.name="condition", value.name="count")
save(anthoming_wide, file='sds/anthoming_wide.rda')
save(anthoming, file='sds/anthoming.rda')

# 161 Corneal thickness
corneas <- read.table('sds/corneal.dat')
names(corneas) <- c('affected','notaffected')
save(corneas, file='sds/corneas.rda')

# 327 Convictions for drunkenness
drunk <- read.table('sds/drunk.dat')
names(drunk) <- c('0-29', '30-39', '40-49', '50-59', '60+')
drunk$sex <- c('male', 'female')
drunk <- drunk[, c(6,1:5)]
save(drunk, file='sds/drunk.rda')

# 371 viral lesions on tobacco leaves
tobacco <- read.table('sds/tobacco.dat')
names(tobacco) <- c('id', 'prep1', 'prep2')
save(tobacco, file='sds/tobacco.rda')

# 373 statures of brother and sister
stature <- read.table('sds/statures.dat')
names(stature) <- c('family', 'brother', 'sister')
save(stature, file='sds/stature.rda')

