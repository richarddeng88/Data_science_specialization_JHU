hist(airquality$Ozone)
table(airquality$Month)
boxplot(Ozone~Month, airquality, xlab="Month", ylab="Ozone (ppb)",col.axis="blue",col.lab="red") 

with(airquality,plot(Ozone,Wind))
title(main="Ozone and Wind in New York City")

par()  #par("pin") Plot dimensions in inches
#par("fg") Background color
#par("pch") The plot character default is the open circle, but it "can either be a single character or an integer code for one of a set
#| of graphics symbols." by default is 1, 
#par("lty") line type
#These include las (the orientation of the axis labels on the plot), bg (background color), mar (margin size),
#| oma (outer margin size), mfrow and mfcol (number of plots per row, column)


plot(airquality$Wind, type="n",airquality$Ozone) 
#type set equal to "n". This tells R to set up the plot but not to put the data in| it.
title(main="Wind and Ozone in NYC")
may <- subset(airquality,Month==5)
points(may$Wind,may$Ozone,col="blue",pch=17)  # add points into the plot
points(notmay$Wind,notmay$Ozone,col="red",pch=8)
legend("topright",pch=c(17,8),col=c("blue","red"),legend=c("May","Other Months"))
abline(v=median(airquality$Wind),lty=2,lwd=2)


par(mfrow=c(1,2))#set up the plot window for two plots side by sid
plot(airquality$Wind, airquality$Ozone, main = "Ozone and Wind")
plot(airquality$Wind, airquality$Solar.R, main = "Ozone and Solar Radiation")

par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))#set up 3 plots
plot(airquality$Wind, airquality$Ozone, main = "Ozone and Wind")
plot(airquality$Solar.R, airquality$Ozone, main = "Ozone and Solar Radiation")
plot(airquality$Temp, airquality$Ozone, main = "Ozone and Temperature")
mtext("Ozone and Weather in New York City", outer = TRUE) #put a main title


#graphic devices system

with(faithful,plot(eruptions,waiting))
title(main= "Old Faithful Geyser data")
dev.cur()

#create a plot in pdf device and save the file in W/D
pdf(file="myplot.pdf")
with(faithful,plot(eruptions,waiting))
title(main= "Old Faithful Geyser data")
dev.off()

#Vector formats are good for line drawings and plots
#| with solid colors using a modest number of points, while bitmap formats are good for plots with
#| a large number of points, natural scenes or web-based plots.

with(faithful,plot(eruptions,waiting))
title(main= "Old Faithful Geyser data")
dev.copy(png, file = "geyserplot.png")
dev.off()


