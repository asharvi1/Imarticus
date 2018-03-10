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

# To calculate the pseudo R^2 we must use the nagelkekeR2 from the fmsb package
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
test_pred = predict(classifier_no_imp, test_set[ ,-21], type = 'response')
test_pred = as.data.frame(test_pred)
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
confusion_matrix = confusionMatrix(training_set_no_imp$Status, train_pred$train_pred, threshold = 0.5)

## Diagnosing the predicted test set values
# Creating a daatframe that contains the test_set Status variable and the predicted test set values
test_set_final = as.data.frame(cbind(as.numeric(levels(test_set$Status)[test_set$Status]), test_pred$test_pred))
ROCpred_test_set = prediction(test_pred$test_pred, test_set$Status)
ROCperf_test_set = performance(ROCpred_test_set, 'tpr', 'fpr')
plot(ROCperf_test_set, main = 'FPR vs TPR for test_set')

# Calculating the auc values for the test_pred
auc_test_set = auc(test_set$Status, test_pred$test_pred)

# Calculating Gini Coefficient for the test_pred
gini_test_set = Gini(as.numeric(test_set$Status), test_pred$test_pred)

# Calculating Concordat pairs and the discordant pairs for the test_pred
concordance_test_set = Concordance(actuals = test_set$Status, test_pred$test_pred)

# Calculating KS Statastic
kstest_test_set = ks.test(test_set$Status, test_pred$test_pred)

# Creating Confusion Matrix for the test_pred
confusion_matrix_test_set_0.1 = confusionMatrix(actuals = test_set$Status, predictedScores = test_pred$test_pred, threshold = 0.1)

# Creating a function to calculate the accuracy
accuracy_cm = function(confusionmatrix){
  accuracy = (confusionmatrix[1,1] + confusionmatrix[2,2]) / (sum(confusionmatrix))
}

accuracy_test_pred_0.1 = accuracy_cm(confusion_matrix_test_set_0.1)

# Creating a function to find the best treshold
best_treshold = function(actuals, preds){
  b_tresh = numeric()
  accuracy_v = numeric()
  for (i in seq(0.1, 0.9, by = 0.1)){
    confusion_matrix = confusionMatrix(actuals = actuals, predictedScores = preds, threshold = i)
    accuracy_confusion_matrix = accuracy_cm(confusion_matrix)
    b_tresh = c(b_tresh, i)
    accuracy_v = c(accuracy_v, accuracy_confusion_matrix)
  }
  best_treshold_df = as.data.frame(cbind(b_tresh, accuracy_v))
  assign('best_treshold_df', best_treshold_df, envir = .GlobalEnv)
}

# Finding the best tresholds
best_treshold_df = best_treshold(actuals = test_set_actuals, preds = test_pred$test_pred)
best_treshold_df[which.max(best_treshold_df$accuracy_v), ]
best_treshold_df$b_tresh[which.max(best_treshold_df$accuracy_v)]



