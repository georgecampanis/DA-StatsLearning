

#https://www.datacamp.com/community/tutorials/machine-learning-in-r
################################################################
iris <- read.csv(url("http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"), 
                 header = FALSE) 

# Print first lines
head(iris)

# Add column names
names(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

# Check the result
iris

#explore your data => look for correlation
#Load in `ggvis`
library(ggvis)

# Iris scatter plot
iris %>% ggvis(~Sepal.Length, ~Sepal.Width, fill = ~Species) %>% layer_points()

iris %>% ggvis(~Petal.Length, ~Petal.Width, fill = ~Species) %>% layer_points()

####################################################################
# Return all `iris` data
iris
# Return first 5 lines of `iris`
head(iris)
# Return structure of `iris`
str(iris)

# Division of `Species`
table(iris$Species) 

# Percentual division of `Species`
round(prop.table(table(iris$Species)) * 100, digits = 1)

# Summary overview of `iris`
summary(iris) 

# Refined summary overview
summary(iris[c("Petal.Width", "Sepal.Width")])



#############################################
# NORMALIZE data
# Build your own `normalize()` function
normalize <- function(x) {
  num <- x - min(x)
  denom <- max(x) - min(x)
  return (num/denom)
}

# # Normalize the `iris` data
# iris_norm <- as.data.frame(lapply(iris[1:4], normalize))
# 
# # Summarize `iris_norm`
# summary(iris_norm)

# ##Generate a random number that is 90% of the total number of rows in dataset.
ran <- sample(1:nrow(iris), 0.8 * nrow(iris)) 
# 
# ##the normalization function is created
nor <-function(x) { (x -min(x))/(max(x)-min(x))   }
# 
# ##Run nomalization on first 4 coulumns of dataset because they are the predictors
iris_norm <- as.data.frame(lapply(iris[,c(1,2,3,4)], nor))

iris.training <- iris_norm[ran,] 
# ##extract testing set
iris.test <- iris_norm[-ran,] 

head(iris.test)

# ##extract 5th column of train dataset because it will be used as 'cl' argument in knn function.
iris.trainLabels <- iris[ran,5]
# ##extract 5th column if test dataset to measure the accuracy
iris.testLabels <- iris[-ran,5]

print(iris.trainLabels)

# Build the model
iris_pred <- knn(train = iris.training, test = iris.test, cl = iris.trainLabels, k=3)

# Inspect `iris_pred`
iris_pred

# Put `iris.testLabels` in a data frame
irisTestLabels <- data.frame(iris.testLabels)

# Merge `iris_pred` and `iris.testLabels` 
merge <- data.frame(iris_pred, iris.testLabels)

# Specify column names for `merge`
names(merge) <- c("Predicted Species", "Observed Species")

# Inspect `merge` 
merge


# view results
library(gmodels)
CrossTable(x = iris.testLabels, y = iris_pred, prop.chisq=FALSE)


library(caret)
library(e1071)
# CARET TRAINING
# Create index to split based on labels  
index <- createDataPartition(iris$Species, p=0.75, list=FALSE)

# Subset training set with index
iris.training <- iris[index,]

# Subset test set with index
iris.test <- iris[-index,]


# Overview of algos supported by caret
names(getModelInfo())

# Train a model
model_knn <- train(iris.training[, 1:4], iris.training[, 5], method='knn')
model_cart <- train(iris.training[, 1:4], iris.training[, 5], method='rpart2')
model_xgb <- train(iris.training[, 1:4], iris.training[, 5], method='xgb')
model_rf <- train(iris.training[, 1:4], iris.training[, 5], method='rf')


summary(iris.test)

# Predict the labels of the test set
predictions<-predict.train(object=model_knn,iris.test[,1:4], type="raw")
predictions_cart<-predict.train(object=model_cart,iris.test[,1:4], type="raw")
predictions_xgb<-predict.train(object=model_xgb,iris.test[,1:4], type="raw")
predictions_rf<-predict.train(object=model_rf,iris.test[,1:4], type="raw")


# Evaluate the predictions
table(predictions)
levels(predictions)
levels(iris.test[,5])
predictions


# Confusion matrix 
confusionMatrix(predictions_rf, factor(iris.test[,5]))
confusionMatrix(predictions_xgb, factor(iris.test[,5]))
confusionMatrix(predictions, factor(iris.test[,5]))
confusionMatrix(predictions_cart, factor(iris.test[,5]))