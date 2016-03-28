#The web site http://ggplot2.org provides complete documentation.
# These components include aesthetics which are attributes such as colour, shape, and size, 
# and geometric objects or geoms such as points, lines, and bars.

qplot(displ,hwy,data=mpg)
qplot(displ,hwy,data=mpg,color=drv)
qplot(displ,hwy,data=mpg,color=drv,geom=c("point","smooth"))
##histogrom
qplot(y=hwy, data = mpg, color = drv)
##boxplot.
qplot(drv,hwy,data=mpg,geom="boxplot")
qplot(drv,hwy,data=mpg,geom="boxplot",color=manufacturer)
qplot(hwy,data=mpg,fill=drv)
    
qplot(displ, hwy, data = mpg, facets = . ~ drv)  
qplot(hwy, data = mpg, facets = drv ~ ., binwidth = 1)


qplot(displ, hwy, data = mpg, geom=c("point", "smooth"),facets=.~drv,method="loess")


g <- ggplot(mpg, aes(displ,hwy) )
g+geom_point()+geom_smooth()
g+geom_point()+geom_smooth(method="lm")+facet_grid(.~drv)+ggtitle("Swirl Rules!")

# theme_gray() which is the default theme (gray background with white grid lines)
# theme_bw() which is a plainer (black and white) color scheme.

g+geom_point(color="blue",size=2,alpha=0.9)
g + geom_point(aes(color = drv), size = 4, alpha = 1/2) 

g + geom_point(aes(color = drv)) + labs(title="Swirl Rules!") + labs(x="Displacement", y="Hwy Mileage")
g + geom_point(aes(color = drv),size=2,alpha=1/2) + geom_smooth(size=3,linetype=2,method="lm",se=TRUE) 
g + geom_point(aes(color = drv)) + theme_bw(base_family="Times")


plot(myx, myy, type = "l", ylim = c(-3,3)) 
#The type="l" tells plot you want to display the data as a line instead of as a scatterplot.
g <- ggplot(testdat, aes(x = myx, y = myy))
g + geom_line()
g + geom_line() + ylim(-3,3) #there will be a break in the line where the outliner is 
g + geom_line() + coord_cartesian(ylim=c(-3,3))


g <- ggplot(mpg,aes(x=displ,y=hwy,color=factor(year)))
g + geom_point()
g + geom_point() + facet_grid(drv~cyl,margins=TRUE)
g + geom_point() + facet_grid(drv~cyl,margins=TRUE)+geom_smooth(method="lm",size=2,se=FALSE,color="black")+labs(x="Displacement",y="Highway Mileage",title="Swirl Rules!")

##qqplot 3

qplot(price,data=diamonds)
qplot(price,data=diamonds,binwidth=18497/30)

qplot(price,data=diamonds,binwidth=18497/30,fill=cut)
qplot(price,data=diamonds,geom="density")
qplot(price,data=diamonds,geom="density",color=cut)

qplot(carat,price,data=diamonds,shape=cut)
qplot(carat,price,data=diamonds, color=cut)
qplot(carat,price,data=diamonds, color=cut,geom=c("point","smooth"),method="lm")
qplot(carat,price,data=diamonds, color=cut,geom=c("point","smooth"),method="lm",facets=.~cut) 


g <- ggplot(diamonds,aes(depth,price))
g+geom_point(alpha=1/3)
cutpoints <- quantile(diamonds$carat,seq(0,1,length=4),na.rm=TRUE)
diamonds$car2 <- cut(diamonds$carat,cutpoints)
g+geom_point(alpha=1/3)+facet_grid(cut~car2)
diamonds[myd,]

g+geom_point(alpha=1/3)+facet_grid(cut~car2)+geom_smooth(method="lm",size=3,color="pink")

ggplot(diamonds,aes(carat,price))+geom_boxplot()+facet_grid(.~cut)



