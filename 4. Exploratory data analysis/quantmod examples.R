getSymbols("YHOO",src="google") # from google finance
getSymbols("GOOG",src="yahoo") # from yahoo finance 
getSymbols("DEXJPUS",src="FRED") # FX rates from FRED
t1 <- setSymbolLookup(YHOO='google',GOOG='yahoo')
 
 
 getSymbols("AAPL",src="yahoo") 
 barChart(AAPL) 
 candleChart(AAPL,multi.col=TRUE,theme="white") 
 
 getSymbols("XPT/USD",src="oanda") 
 chartSeries(XPTUSD,name="Platinum (.oz) in $USD")