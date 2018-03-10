# Analysis on German credit data and creating a logistic regression model

dataset = read.csv('German_Credit_Data.csv')

# Replacing the 2 with 0 in the status column
dataset$Status[dataset$Status == 2] = 0
str(dataset)
dataset$Status = as.factor(dataset$Status)
str(dataset)

# Splitting the dataset to train and test
set.seed(123)
split = sample.split(dataset$Status, SplitRatio = 0.7)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Fitting the logistic regression to the training set
classifier = glm(formula = Status ~ ., family = 'binomial', data = training_set)
summary(classifier)

# To calculate the pseudo R^2 we must use the nagelkekeR2
classifier_NKR2 = NagelkerkeR2(classifier)

# Identifying the outliers
rstudent = rstudent(classifier, infl = influence(classifier, do.coef = TRUE))
rstudentdf = as.data.frame(rstudent)
outliers = subset(rstudentdf, rstudentdf$rstudent < (-1.5) | rstudentdf$rstudent > 1.5)
outliers_rownames = rownames(outliers)
outliers_rownames = as.numeric(outliers_rownames)

# Creating a outliers dataset from the training set
training_set_o = training_set[outliers_rownames, ]

# Creating a no outliers dataset from the training set
training_set_no = training_set[-outliers_rownames, ]

# Fitting the Logistic Regression model with out the outliers in the training set
classifier_no = glm(formula = Status ~ ., data = training_set_no, family = 'binomial')
summary(classifier_no)

# Checking the pseudo R^2 value for the with out outlier data
classifier_no_NKR2 = NagelkerkeR2(classifier_no)

# Checking the multicollinearity between the variables
vif = vif(classifier_no)
vif = as.data.frame(vif)

# Creating a dataset that has multicollinearity less than or equal to 2, in this case there are no variables with that sepcs
# training_set_no_vifdf = training_set_no[-(which(vif$`GVIF^(1/(2*Df))` > 2))]

# Using Boruta package for informating value calculation
boruta = Boruta(Status ~ ., doTrace = 2, data = training_set_no)
boruta
boruta_decision = boruta$finalDecision

# Removing the unimportant variables
training_set_no_imp = training_set_no[, c(which(boruta_decision == 'Confirmed' | boruta_decision == 'Tentative'), 21)]

# Fitting the model again with the training set with no outliers and with only the important variables checked through boruta
classifier_no_imp = glm(formula = Status ~ ., family = 'binomial', data = training_set_no_imp)
summary(classifier_no_imp)
classifier_no_imp_NKR2 = NagelkerkeR2(classifier_no_imp)
classifier_no_imp_NKR2

# Predicting the test set values
# test_pred = predict(classifier_no_imp, newdata = test_set[-21])

# Creating the ROC curve with the ROCR package
train_pred = fitted(classifier_no_imp)
train_pred = as.data.frame(train_pred)
ROCpred = prediction(train_pred$train_pred, training_set_no_imp$Status)
ROCpref = performance(ROCpred, 'tpr', 'fpr')
plot(ROCpref)

# Calculating the AUC value for the classifier_no_imp model from pROC package
auc = auc(training_set_no_imp$Status, train_pred$train_pred)

# Calculating Loglikelihood 
loglik = logLik(classifier_no_imp)
loglik2 = -2 * loglik
loglik2

# Calculating Gini Coefficient from reldist package
gini = gini(as.numeric(training_set_no_imp$Status), train_pred$train_pred)
gini1 = (2 * auc) - 1

# Calculating Gini Coefficient with ineq package
ineq(training_set_no_imp$Status, type = 'Gini')
# ineq(training_set_no_imp$Status, train_pred$train_pred, type = 'Gini')

# Calculating Concordant and Discordant pairs from Informationvalue package
concordace = Concordance(training_set_no_imp$Status, train_pred$train_pred)
# The above function also calculates the discordance pairs too and is shown in the output as a list

# Calculating KS statastic
ks_tes = ks.test(training_set_no_imp$Status, train_pred$train_pred)

# Calculating RMSE with formula and metrics package
# RMSE = sqrt(mean((training_set_no_imp$Status - train_pred$train_pred) ^ 2))
RMSE = Metrics::rmse(as.numeric(training_set_no_imp$Status), train_pred$train_pred)

# Creating a confusion matrix
# confusion_matrix = table(train_pred$train_pred, training_set_no_imp$Status)# as there are probs in the predicted set, we cannot just use the table
# To tackle this issue we use confusionMatrix from the informationValue package
confusionMatrix(training_set_no_imp$Status, train_pred$train_pred, threshold = 0.5)








