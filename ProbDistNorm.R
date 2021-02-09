

######################################################################

# Norm Dist
# Author: George Campanis
# Date: 4-Feb-2021
# Purpose: Teaching Summary Stats to DA Group 
###################################################################

fHtWt <- read.csv(file.choose())

head(fHtWt, 10)
View(fHtWt)

str(fHtWt)

hist(fHtWt$Height)
hist(fHtWt$Weight)
# ref: http://www.stat.umn.edu/geyer/old/5101/rlook.html
# https://www.datascienceblog.net/post/basic-statistics/distributions/
# https://www.statology.org/dnorm-pnorm-rnorm-qnorm-in-r/


# What is the probability that a randomly chosen female weighs more then 150 lbs?



mu=mean(fHtWt$Weight)
sdev=sd(fHtWt$Weight)


dist = dnorm(fHtWt$Weight, mean = mu, sd = sdev)
df = data.frame("Wt" = fHtWt$Weight, "Density" = dist)
library(ggplot2)
ggplot(df, aes(x = Wt, y = Density)) + geom_point()


#PDF
# what is the prob. a female's weight is 150 lbs exactly
dnorm(x=150, mean=mu, sd=sdev)



cdf = pnorm(fHtWt$Weight, mu, sdev)
df <- cbind(df, "CDF_LowerTail" = cdf)
ggplot(df, aes(x = fHtWt$Weight, y = CDF_LowerTail)) + geom_point()



# Put simply, pnorm returns the area to the left of a given value x in the normal distribution. 
# If you're interested in the area to the right of a given value q, you can simply add the argument lower.tail = FALSE

# CDF
# likelihood of weight being >=150 lbs?
pnorm(150, mean=mu, sd=sdev, lower.tail=FALSE)

# likelihood of weight being <150 lbs?
pnorm(150, mean=mu, sd=sdev)

# likelihood between 100-180 lbs
pnorm(180, mean=mu, sd=sdev) - pnorm(100, mean=mu, sd=sdev)

# likelihood between 60-100 lbs
pnorm(100, mean=mu, sd=sdev) - pnorm(60, mean=mu, sd=sdev)

# likelihood between 180-250 lbs
pnorm(250, mean=mu, sd=sdev) - pnorm(180, mean=mu, sd=sdev)

# 
# Z-Scores
# #----------------------------------------------------------

#****************************
# pnorm for z-score => Prob.
#****************************

# For above Mu examples use 1 - pnorm
# e.g. prob. of weight above 2.0 sd = 1-0.9772499
1-pnorm(2)

# for prob. to the left pnorm(2)
pnorm(2)


# for prob between sd -1.28 and 0.72
pnorm(0.72)-pnorm(-1.28)

#****************************
# qnorm for Prob.  => z-score
#****************************
qnorm(0.975) # 1.959964

#***********************
# z-score all the data
#***********************



fHtWt$WeightZ=as.vector(scale(fHtWt$Weight))
head(fHtWt[,c("Weight","WeightZ")])
# shows bottom of the data
tail(fHtWt[,c("Weight","WeightZ")],1000)

1-pnorm(3.489406)


hist(fHtWt$WeightZ)
d <- density(fHtWt$WeightZ)
plot(d)

#---------------------------
# Test normality
#---------------------------

#********************
# #Shapiro-Wilk test
# ******************
# The Shapiro-Wilk test for normality is available when using the Distribution platform to examine a continuous variable. 
# The null hypothesis for this test is that the data are normally distributed.
# If the p-value is greater than 0.05, then the null hypothesis is not rejected.

shapiro.test(fHtWt$Weight)


#********************
# #Shapiro-Wilk test
# ******************
qqnorm(fHtWt$Weight, pch = 1, frame = FALSE)
qqline(fHtWt$Weight, col = "steelblue", lwd = 2)

install.packages("car")
library(car)
qqPlot(fHtWt$Weight)
