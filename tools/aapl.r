library(quantmod)

# Get the stock data from online data source - only need to do this once
tmp <- getSymbols("AAPL", from="1980-1-1", to="2018-05-01")
# Save to file
AAPL <- to.weekly(AAPL)
aapl <- data.frame(date=time(AAPL), adj_price=as.vector(AAPL$AAPL.Adjusted))

pkgdir <- rprojroot::find_package_root_file()
save(aapl, file = file.path(pkgdir, "data/aapl.rda"))
