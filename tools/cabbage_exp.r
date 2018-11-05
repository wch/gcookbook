library(plyr)
library(MASS)
cabbage_exp <-  ddply(cabbages, .(Cult,Date), summarise,
                      Weight=mean(HeadWt), sd=sd(HeadWt), n=length(HeadWt),
                      se=sd(HeadWt)/sqrt(length(HeadWt)))
cabbage_exp <- rename(cabbage_exp, c(Cult="Cultivar"))


pkgdir <- rprojroot::find_package_root_file()
save(cabbage_exp, file = file.path(pkgdir, "data/cabbage_exp.rda"))
