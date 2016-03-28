d1 <- Sys.Date();d1
class(d1)
unclass(d1)
d2 <- as.Date("1970-01-01")
unclass(d2)

t1 <- Sys.time();t1
class(t1)
unclass(t1)

t2 <- as.POSIXlt(Sys.time())
class(t2)
unclass(t2)
str(unclass(t2))
t2$min

weekdays(d1);months(t1);quarters(t2)
strptime()

t3 <- "October 17, 1986 08:24"
t4 <- strptime(t3, "%B %d, %Y %H:%M")
class(t4)

Sys.time() > t1
Sys.time() - t1
difftime(Sys.time(), t1, units="days")
