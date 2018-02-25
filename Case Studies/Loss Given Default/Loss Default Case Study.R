# Loss Given Default Case Study

dataset = read.csv('R_Module_Day_5.2_Data_Case_Study_Loss_Given_Default(1).csv')

head(dataset)


dataset = dataset[2:7]

str(dataset)
dataset$Number.of.Vehicles = as.factor(dataset$Number.of.Vehicles)
str(dataset)


# Creating the linear regression model
## Splitting the dataset to training set and test set

set.seed(123)
train_rec = sample(1:nrow(dataset), 0.7*nrow(dataset))

train_set = dataset[train_rec, ]
nrow(train_set)


test_set = dataset[-train_rec,]


## Now fitting the linear regression model

regressor = lm(formula = Losses.in.Thousands~., data = train_set)

summary(regressor)

rstudent = rstudent(regressor, infl = influence(regressor, do.coef = TRUE))
rstudent_frame = as.data.frame(rstudent)

outliers = subset(rstudent_frame, rstudent_frame$rstudent < -1.5 | rstudent_frame$rstudent > 1.5)

outliers_rownames = rownames(outliers)
outliers_rownames = as.numeric(outliers_rownames)# Changing the character format to the numeric format

train_set_o = train_set[outliers_rownames, ]
sum(is.na(train_set_no))

write.csv(train_set_no, file = 'no_outlier_data.csv')

train_set_no = train_set[-outliers_rownames,]
sum(is.na(train_set_no))

write.csv(train_set_o, file = 'outlier_data.csv')

# Fitting the regression model with out the outliers in the train_set

regressor_1 = lm(formula = Losses.in.Thousands~., data = train_set_no)
summary(regressor_1)  

## with the randomforest package, we can automatically impute the missing values according to the data
### na.roughfix()

vif = vif(regressor_1)
vif

cor(train_set_no$Age, train_set_no$Years.of.Experience)

train_set_no_age = train_set_no[, 2:6]  

# Fitting the model again with train data without outliers and removing the age column

regressor_2 = lm(formula = Losses.in.Thousands~., data = train_set_no_age)
summary(regressor_2)

vif = vif(regressor_2)
vif

# Standardising the betas

abs(lm.beta(regressor_2))

# If the betas are standardised remove the variable do the fit, in this case we are doing it again just for knowing the final fit model

regressor_final = lm(formula = Losses.in.Thousands~., data = train_set_no_age)
summary(regressor_final)

# Fitting the model without the number of vehicles

regressor_final_1 = lm(formula = Losses.in.Thousands~Years.of.Experience+Gender+Married, data = train_set_no_age)
summary(regressor_final_1)

train_pred = fitted(regressor_final_1)
write.csv(train_pred, 'train_pred.csv')

train_pred_full = cbind(train_set_no_age, train_pred)
write.csv(train_pred_full, 'train_pred_full.csv')

test_pred = predict(regressor_final_1, newdata = test_set)
test_pred_full = cbind(test_set, test_pred)
write.csv(test_pred_full, 'test_pred_full.csv')

# Calculating MAPE
MAPE = mean(abs(residuals(regressor_final_1)))*100

# Calculating RMSE with hydroGOF package
RMSE = rmse(train_pred_full$train_pred, train_pred_full$Losses.in.Thousands)
RMSE

# Calculating the std.error with plotrix package
std.error(residuals(regressor_final_1))


# Plotting the model

ggplot() +
  geom_point(aes(train_pred_full$Years.of.Experience, train_pred_full$Number.of.Vehicles)) +
  geom_line(aes(x = train_pred_full$Years.of.Experience, train_pred_full$train_pred))








