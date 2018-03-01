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

# Fitting the Linear Regression Model to the training set
regressor_lm_1 = lm(formula = Rating ~ ., data = training_set)
summary(regressor_lm_1)

# Removing the outliers
rstudent = rstudent(regressor_lm_1, infl = influence(regressor_lm_1, do.coef = TRUE))
rstudent_df = as.data.frame(rstudent)
outliers = subset(rstudent_df, rstudent_df$rstudent < (-1.5) | rstudent_df$rstudent > 1.5) 
outliers_row = rownames(outliers)
outliers_row = as.numeric(outliers_row)
dataset_outliers = dataset[outliers_row, ] 
dataset_nooutliers = dataset[-outliers_row, ]

# Splitting the no outliers dataset to training and test set
set.seed(123)
split_1 = sample.split(dataset_nooutliers$Rating, SplitRatio = 0.7)
training_set_1 = subset(dataset_nooutliers, split_1 == TRUE)
test_set_1 = subset(dataset_nooutliers, split_1 == FALSE)

# Fitting the Linear Regression model to the no outliers data
regressor_lm_2 = lm(formula = Rating ~ ., data = training_set_1)
summary(regressor_lm_2)

# Now checking the multicollinearity
library(car)
vif = vif(regressor_lm_2)
which(vif>10)
vif_data = training_set_1[-which(vif > 10)]

# Fitting the Linear Regression model to the vif data
regressor_lm_3 = lm(formula = Rating ~ ., data = vif_data)
summary(regressor_lm_3)

# Verifying the standardized betas
predictive = abs(lm.beta(regressor_lm_3))
predictive_df = as.data.frame(predictive)

category = ifelse(predictive_df$predictive < 0.02, 'No', ifelse(predictive_df$predictive < 0.1, 'weak', ifelse(predictive_df$predictive < 0.3 , 'Medium', 'High')))
predictive_df$Category = category  
predictivedata = vif_data[-c(5,8,9,12,15,19,24,25)]  

# Fitting the Final Linear Regression Model to the predictive data
regressor_lm_Final = lm(formula = Rating ~ ., data = predictivedata)
summary(regressor_lm_Final)  
train_fit = fitted(regressor_lm_Final)
test_fit = predict(regressor_lm_Final, test_set_1[-1])

train_model = cbind(train_fit, training_set_1$Rating)
test_model = cbind(test_fit, test_set_1$Rating)
write.csv(train_model, 'train_model.csv')
write.csv(test_model, 'test_model.csv')

plot(regressor_lm_Final)

# Calculating MAPE with MLmetrics package
MAPE(train_fit, predictivedata$Rating)
MAPE(test_fit, test_set_1$Rating)

# Calculating RMSE with hydroGOF package
RMSE(train_fit, predictivedata$Rating)
RMSE(test_fit, test_set_1$Rating)

# Calculating the Standard Error with plotrix package
std.error(residuals(regressor_lm_Final))






