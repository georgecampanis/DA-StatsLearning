
##################################################################################################################

#   REGRESSION + Cross-Fold Validation
#   Ref: https://towardsdatascience.com/create-predictive-models-in-r-with-caret-12baf9941236 (Simple Regress Example)
#   Ref: https://lgatto.github.io/IntroMachineLearningWithR/supervised-learning.html (More Advanced description of ML in R) e.g. Missing values
#   Ref: https://docs.microsoft.com/en-us/dotnet/machine-learning/resources/metrics  (Performance Metrics)
#   Ref: https://www.r-bloggers.com/2020/05/step-by-step-guide-on-how-to-build-linear-regression-in-r-with-code/ (Checking LR Assumptions)
#################################################################################################################


# NOTE:
# For regression, we will use the root mean squared error (RMSE), 
#           which is what linear regression (lm in R) seeks to minimise. 
# For classification, we will use model prediction accuracy.

install.packages("caret")
library(caret)


data(mtcars)    # Load the dataset
head(mtcars)

# Data Viz
install.packages("corrgram")
install.packages("gridExtra")
library(corrgram)

corrgram(mtcars, order=TRUE)

scatter.smooth(x=mtcars$wt, y=mtcars$mpg, main="Mpg ~ Wt")  # scatterplot
# calculate correlation between Wt and Mpg
cor(mtcars$wt, mtcars$mpg)  

# build linear regression model on full data
linearMod <- lm(mpg ~ wt, data=mtcars)  
print(linearMod)


# Notice that if wt=4 => 4(-5.344) + 37.285 = 15.904


###################################################
#Now lets build a LR Model based on all features
###################################################
# Model data using 80/20 split
index <- createDataPartition(mtcars$mpg, p=0.8, list=FALSE)
# Subset training set with index
mtcars.training <- mtcars[index,]
# Subset test set with index
mtcars.test <- mtcars[-index,]

# Taining model
lmModel <- lm(mpg ~ . , data = mtcars.training)
# Printing the model object
print(lmModel)



# Multiple linear regression model
model <- train(mpg ~ ., data = mtcars, method = "lm")

# Taining model
lmModel <- lm(Price ~ . , data = train)
# Printing the model object
print(lmModel)


# Checking model statistics
summary(lmModel)

# Pr(>|t|) represents the p-value, which can be compared against the alpha value of 0.05 
# to ensure if the corresponding beta coefficient is significant or not.


# MODEL Performance

# ###########################
# Multiple R-squared: 0.8761
# ###########################################################################################################################
# The R-squared value is formally called a coefficient of determination. 
# Here, 0.8761 indicates that the intercept, and all feature variables, 
# when put together, are able to explain 87.61% of the variance in the mpg variable. 
# The value of R-squared lies between 0 to 1.
# In practical applications, if the R2 value is higher than 0.70, we consider it a good model.
# ###########################################################################################################################

# ###########################
# Adjusted R-squared: 0.8032 
# ###########################################################################################################################
# The Adjusted R-squared value tells if the addition of new information ( variable ) brings significant improvement to the model
# So as of now, this value does not provide much information. However, the increase in the adjusted R-squared value with 
# the addition of a new variable will indicate that the variable is useful and brings significant improvement to the model.
# ###########################################################################################################################

# ##########################################
# p-value: 7.323e-06
# ###########################################################################################################################
# The null hypothesis is that the model is not significant, and the alternative is that the model is significant. 
# According to the p-values < 0.05, our model is significant.
# F-Statistic refers to the comparison of means between two populations we will cover ANOVA in the DataViz class.
# ###########################################################################################################################



##############################################
# Checking Assumptions of Linear Regression
##############################################

#--------------------------------------------
# Errors should follow normal distribution
#--------------------------------------------
install.packages("car")
library("car")
qqPlot(lmModel$residuals)

# A residual is the vertical distance between a data point and the regression line. Each data point has one residual.
# the residual is the error that isn't explained by the regression line
# example: https://images.app.goo.gl/bmLzqTeL2zPiKAeq9 

#--------------------------------------------
# There should be no heteroscedasticity
#--------------------------------------------
# This means that the variance of error terms should be constant. We shall not see any patterns when we draw a plot between residuals and fitted values. 
# And the mean line should be close to Zero.

# A straight red line closer to the zero value represents that we do not have heteroscedasticity problem in our data.
# use a box-cox transformation to fix heteroscedasticity => https://en.wikipedia.org/wiki/Power_transform#Box.E2.80.93Cox_transformation
plot(lmModel, which=1)# 1st Plot


####   => We will use the Root Mean Square Error(RMSE) in caret to evaluate the performance of regression

# Lets use 
## 10-fold CV
# possible values: boot", "boot632", "cv", "repeatedcv", "LOOCV", "LGOCV"
fitControl <- trainControl(method = "repeatedcv", 
                           number = 10,     # number of folds
                           repeats = 10)    # repeated ten times

# Simple linear regression model (lm means linear model)
modelLR.cv <- train(mpg ~ ., data = mtcars,method = "lm", trControl = fitControl)  

modelLR.cv

# Ridge regression model
modelLasso.cv <- train(mpg ~ .,data = mtcars, method = "ridge", trControl = fitControl) # Try using "lasso"

############################
# PreProcess
############################
# In this example we're going to use the following pre-processing:
#   center data (i.e. compute the mean for each column and subtracts it from each respective value);
# scale data (i.e. put all data on the same scale, e.g. a scale from 0 up to 1)
# However, there are more pre-processing possibilities such as 
# "BoxCox", "YeoJohnson", "expoTrans", "range", "knnImpute", "bagImpute", "medianImpute", "pca", "ica" and "spatialSign".



modelLasso.cv <- train(mpg ~ .,data = mtcars, method = "ridge", trControl = fitControl,
                       preProcess = c('scale', 'center')) # default: no pre-processing

modelLasso.cv 

modelLasso.cv <- train(mpg ~ .,data = mtcars, method = "ridge", trControl = fitControl,
                       preProcess = "BoxCox") # default: no pre-processing

modelLasso.cv 

########################################################
#Finding the model hyper-parameters
########################################################
# Here we generate a dataframe with a column named lambda with 100 values that goes from 10^10 to 10^-2
lambdaGrid <- expand.grid(lambda = 10^seq(10, -2, length=10))

modelLasso.cv <- train(mpg ~ .,data = mtcars, method = "ridge", trControl = fitControl,
                       preProcess = "BoxCox",tuneGrid = lambdaGrid,   # Test all the lambda values in the lambdaGrid dataframe
                       na.action = na.omit)   # Ignore NA values

modelLasso.cv

########################################################
# Feature Importance
########################################################
ggplot(varImp(modelLasso.cv))

########################################################
# Make Predictions
########################################################
# we should still use cv and test/train split for validation 80/20 validation
predictions <- predict(modelLasso.cv, mtcars)

predictions