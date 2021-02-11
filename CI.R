#https://datasharkie.com/how-to-calculate-confidence-interval-in-r/

install.packages("Rmisc")
library(Rmisc)


mydata<-iris

CI(mydata$Sepal.Length, ci=0.95)



# get sample data 10%
index_s <- sample(1:nrow(mydata), 15)

mydata_ss <- mydata[index_s, ]

CI(mydata_ss$Sepal.Length, ci=0.95)


# larger sample 
index_l <- sample(1:nrow(mydata), 120)

mydata_ls <- mydata[index_l, ]

# see that the larger the sample sz the better the result
CI(mydata_ls$Sepal.Length, ci=0.95)