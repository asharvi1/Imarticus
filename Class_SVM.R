# Practising the Support Vector Machine Algorithm
data("BreastCancer")
dataset = BreastCancer

# Removing the rows that have NA values and also the Id column
dataset = na.omit(dataset)
dataset = dataset[-1]

# Convert the factor levels benign and malignant to 0 and 1
# dataset$Class = factor(dataset$Class, levels = c(1, 0))

# Splitting the dataset to train and test set
set.seed(123)
split = sample.split(dataset$Class, SplitRatio = 0.7)
train_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Fitting the SVM model from the e1071 package to the training set
classifier = svm(formula = Class ~ ., data = train_set, cost = 4, gamma = 0.5, probability = TRUE)
test_pred = predict(classifier, type = 'prob', newdata = test_set[-10], probability = TRUE)
tune_classifier = tune(svm, Class ~ ., data = train_set, ranges = list(gamma = 1.5 ^ (-1:1), cost = 1.5 ^ (2:4)))

classifier_best = svm(formula = Class ~ ., data = train_set, cost = 1.5 ^ 2, gamma = 1.5 ^ -1, probability = TRUE)

train_pred = fitted(classifier_best)
test_pred = predict(classifier_best, type = 'prob', newdata = test_set, probability = TRUE)
test_pred_set = cbind(test_set, test_pred)

# Creating the Confusion matrix

cm_train = table(train_set$Class, train_pred)
cm_test = table(test_set$Class, test_pred)
cm_test_df = as.data.frame(cm_test)
cm_train_df = as.data.frame(cm_train)

# Calculating the training set ROCR performance with the help of ROCR package 
# ROCRpred = prediction(train_pred, train_set$Class)

# Creating a function to calculate the accuracy with the confusion matrix
accuracy_cm = function(confusionmatrix){
  accuracy = (confusionmatrix[1,1] + confusionmatrix[2,2]) / (sum(confusionmatrix))
}

# Calculating the accuracy for the test set confusion matrix
accuracy_cm_test = accuracy_cm(cm_test)
accuracy_cm_train = accuracy_cm(cm_train)




