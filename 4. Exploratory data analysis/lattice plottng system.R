#| It's an add-on package so it has to be explicitly loaded with a call to the R function library.
#| We've done this for you. The R Documentation tells us that lattice "is an implementation of
#| Trellis graphics for R. It is a powerful and elegant high-level data visualization system with
#| an emphasis on multivariate data."

xyplot(Ozone ~ Wind, data = airquality, pch=8, col="red", main="Big Apple Data")
xyplot(Ozone ~ Wind | as.factor(Month), data = airquality, layout=c(5,1))

p <-xyplot(Ozone~Wind,data=airquality)
print(p)
names(p)


table(diamonds$color,diamonds$cut)
source(pathtofile("myLabels.R"),local = TRUE)
xyplot(price~carat|color*cut,data = diamonds,strip = FALSE,pch=20,xlab=myxlab,ylab=myylab,main=mymain)
xyplot(price~carat|color*cut,data = diamonds,pch=20,xlab=myxlab,ylab=myylab,main=mymain)



