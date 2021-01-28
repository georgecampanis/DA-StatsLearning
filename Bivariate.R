# source: http://www.sthda.com/english/wiki/correlation-test-between-two-variables-in-r
# data source: https://www.kaggle.com/mustafaali96/weight-height?select=weight-height.csv

# get data from .csv file
mHtWt <- read.csv(file.choose())

head(mHtWt, 10)
View(mHtWt)

str(mHtWt)


# plot relationship
plot(mHtWt$Weight, mHtWt$Height, main="Male Weight and Heights ",
     xlab="Weight (lbs)", ylab="Height (in)", pch=19, cex = .2)

# Add fit lines
abline(lm(mHtWt$Height~mHtWt$Weight), col="red") # regression line (y~x)

?cor

(res <- cor.test(mHtWt$Weight, mHtWt$Height, 
                 method = "pearson"))

(res <- cor.test(mHtWt$Height, mHtWt$Weight, method = "pearson"))
