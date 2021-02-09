
######################################################################
# source => 
# https://r4ds.had.co.nz/introduction.html
# Hadley Wickham R for Data Science
# https://statsandr.com/blog/descriptive-statistics-in-r/
# https://statsandr.com/blog/data-types-in-r/
#
# Author: George Campanis
# Date: 25-Jan-2021
# Purpose: Teaching Summary Stats to DA Group 
###################################################################


#*----------------------------------------------------------------
# Notes: 
# Execute script block -      then Ctrl + Enter
# ctrl l clears screen
# ctrl shift C will comment all selected code
#-----------------------------------------------------------------


install.packages("tidyverse")
install.packages("pastecs")# more stats


library(tidyverse)

# install some data packages 
install.packages(c("nycflights13", "gapminder", "Lahman")) # used 

#--------------------
# coding basics
#--------------------
# Math
1 / 200 * 30
(59 + 73 + 2) / 3
sin(pi / 2)

# var assignment
x <- 3 * 4
x = 3 * 4

# display var
x

# calling functions
# e.g seq()  makes regular sequences of number
seq(1, 10)

# enclose in parentheses to display automatically after assignment
(y <- seq(1, 10, length.out = 5))

?seq()
?sd()

# press  Alt + Shift + K and see what happens

library(nycflights13)
library(tidyverse)

?dplyr::filter() 
?stats::filter()

?filter() 





# show flights data
flights # data type is a tibble ---more on this later

# view flights and Iris dataset in RStudio Viewer
View(flights)
View(iris)

# R var types
#  int stands for integers.
#  dbl stands for doubles, or real numbers.
#  chr stands for character vectors, or strings.
#  dttm stands for date-times (a date + a time).
#  lgl stands for logical, vectors that contain only TRUE or FALSE.
#  fctr stands for factors, which R uses to represent categorical variables with fixed possible values.
#  date stands for dates.




# https://statsandr.com/blog/data-types-in-r/
# c is used in R to concatenate 
num_data <- c(3, 7, 2)# numeric series without decimals
# Combine Values Into A Vector Or List
# Try run it....https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/c


class(num_data) # identifies class of data

typeof(num_data) # to get data type

num_data_dec <- c(3.4, 7.1, 2.9)
class(num_data_dec)
# also possible to check the class thanks to str()
str(num_data_dec)

int_nums = as.integer(num_data_dec)# convert data types

###################################
# Chars
#################################
char <- "some text" # strings
char
class(char)

numAsChar= as.character(int_nums)

# case and space sensitivity 
char_space <- "text "
char_nospace <- "text"
# is char_space equal to char_nospace?
char_space == char_nospace


char_space <- "Text"
char_nospace <- "text"
# is char_space equal to char_nospace?
char_space == char_nospace


##############################################
# Factors
# factors are categorical
#############################################
gender <- factor(c("female", "female", "male", "female", "male"))
gender

levels(gender)


fruit = factor(c("apple", "pear", "banana", "apple", "grape"))
levels(fruit)

#By default, the levels are sorted alphabetically
text <- c("test1", "test2", "test1", "test1") # create a character vector
class(text) # to know the class

text_factor <- as.factor(text) # transform to factor
class(text_factor) # recheck the class

##############################################
# Logical
# are boolean true or false
#############################################
value1 <- 7
value2 <- 9

# is value1 greater than value2?
(greater <- value1 > value2)

class(greater)

# is value1 less than or equal to value2?
less <- value1 <= value2
less


greater_num <- as.numeric(greater)# FALSE values equal to 0 and TRUE values equal to 1:
greater_num

# also we can take an int and get a logical
x <- 0
typeof(x)
as.logical(x)








# => https://statsandr.com/blog/descriptive-statistics-in-r/
# stats summary 

dat <- iris # load the iris dataset and renamed it dat

View(iris)

head(dat,25) # first 6 observations
str(dat) # structure of dataset

levels(iris$Species) # note $ refers to col


#############
# min, max
#############
min(dat$Sepal.Length)
max(dat$Sepal.Length)

#================================= START HERE!!!!!
#############
# RANGE
#############
range(dat$Sepal.Length)

# note: we can get array num starting  @ 1,2,...n
arr=range(dat$Sepal.Length)
arr[1]
# or like this
range(dat$Sepal.Length)[2]


# The range is the difference between the maximum and the minimum value
rng= max(dat$Sepal.Length) - min(dat$Sepal.Length)
rng

# create a func
fnRange = function(x) {
  range <- max(x) - min(x)
  return(range)
}

fnRange(dat$Sepal.Length)
fnRange(dat$Petal.Length)

#############
# MEAN
#############
mean(dat$Sepal.Length)

# Remove nulls (na) using na.rm = TRUE 
mean(dat$Sepal.Length, na.rm = TRUE)

# truncated/trimmed mean => Trims top and bottom %
# trim the fraction (0 to 0.5) of observations to be trimmed 
# from each end of x before the mean is computed.
# eg (8 12 12 16) 32 39 39 45 47 50 51 59 61 74 75 87 (87 87 92 93) =>  (0.2 * 20) = 4  is a 0.2 trim
mean(dat$Sepal.Length, trim = 0.10)

#############
# MEDIAN
#############
median(dat$Sepal.Length)
# or
quantile(dat$Sepal.Length, 0.5)

#######################
# 1st and 3rd quartile
######################
quantile(dat$Sepal.Length, 0.25) # first quartile
quantile(dat$Sepal.Length, 0.75) # third quartile

#other quantiles
quantile(dat$Sepal.Length, 0.4) # 4th decile
quantile(dat$Sepal.Length, 0.98) # 98th percentile


#######################
#  Interquartile range
######################
IQR(dat$Sepal.Length)
#OR
quantile(dat$Sepal.Length, 0.75) - quantile(dat$Sepal.Length, 0.25)

##################################
#  Standard deviation and variance
##################################
sd(dat$Sepal.Length) # standard deviation
var(dat$Sepal.Length) # variance

variance= (sd(dat$Sepal.Length))^2
stdDev = sqrt(variance)
# computed using sample formulae i.e. n-1

o=lapply(dat[, 1:4], sd)
o[4]



head(dat)
# selecting individual cols dat[, 1:4]
# lapply vs sapply ?

summary(dat)

# NOTE: if you need these descriptive statistics by group use the by() function:
by(dat, dat$Species, summary)

# for more stats use 
library(pastecs)
stat.desc(dat)



