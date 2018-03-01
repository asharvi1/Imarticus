# Analysis on the Fifa Dataset

dataset = read.csv('FullData.csv')

# Removing the date of birth of a player, as it is not be a useful variable to calculate the rating of a player
dataset = dataset[-3]

# Splitting the data to training and test set with "caTools" package
library(caTools)
# Setting the seed to '123' 
set.seed(123)
split = sample.split(dataset$Rating, SplitRatio = 0.7)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Fitting the Support Vector Regression model to the training set
library(e1071)
regressor_svr = svm(formula = Rating ~ ., data = training_set, type = 'eps-regression', 
                      kernel = 'radial')

# Predicting the test set
train_fit = fitted(regressor_svr)
test_fit = predict(regressor_svr, test_set[-1])
train_model = cbind(train_fit, training_set$Rating)
colnames(train_model) = c('train_fit', 'Actual')
test_model = cbind(test_fit, test_set$Rating)
colnames(test_model) = c('test_fit', 'Actual')
write.csv(train_model, 'train_model.csv')
write.csv(test_model, 'test_model.csv')

# Creating a function to calculate the r square
r_square = function(model, actualdata){
  r_sq = 1 - (sum((actualdata - fitted(model)) ^ 2) / sum((actualdata - mean(actualdata)) ^ 2))
  return(r_sq)
}

# Creating a function to calculate adjusted r square
adj_r_square = function(r_squared, no_pred, sample_size){
  adj = 1 - (((1 - r_squared) * (sample_size - 1)) / (sample_size - no_pred - 1))
  return(adj)
}

# Calculating the r-square for the SVR model
r_square(regressor_svr, training_set$Rating)

# Calculating the adjusted r-square fro the SVR model
adj_r_square(r_squared = r_square(regressor_svr, training_set$Rating), 
             no_pred = length(training_set), sample_size = nrow(training_set))

# Calculating MAPE for the SVR model
MAPE(test_fit, test_set$Rating)

# Calculating RMSE for the SVR model
RMSE(test_fit, test_set$Rating)

# Calculating Standard error for the SVR model
std.error(residuals(regressor_svr))






