# http://www.statmethods.net/graphs/density.html

# Compare coverage distributions for samples
# install.packages("sm")   # install if not already installed
library(sm)
attach(mtcars)

# create value labels 
cyl.f <- factor(cyl, levels= c(4,6,8),
  labels = c("Sample A01", "Sample A02", "Sample A03")) 

# plot densities 
sm.density.compare(mpg, cyl, xlab="Panel: 168,361 Positions", ylab="Number of Reads")
title(main="Landscape of Sample Coverage")

# add legend via mouse click
colfill<-c(2:(2+length(levels(cyl.f)))) 
legend(locator(1), levels(cyl.f), fill=colfill)

