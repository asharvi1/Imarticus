# Decision Tree

data("BreastCancer")
dataset = BreastCancer

# Removing the NA values and the ID column
dataset = na.omit(dataset)
dataset$Id = NULL

# Splitting the dataset into training and test set
set.seed(123)
split = sample.split(dataset$Class, SplitRatio = 0.7)
train_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Fitting the Decision tree model to the training set
classifier = rpart(Class ~ ., data = train_set)
classifier
dev.new() # Clearly shows the plot without cutting anything
plot(classifier)
text(classifier)

# Predicting the class of the test data
test_pred_class = predict(classifier, newdata = test_set, type = 'class')

# Predicting the probabilities of the test data
test_pred_prob = predict(classifier, newdata = test_set, type = 'prob')

# Creating a model using conditional inference trees
train_set_ct = ctree(Class ~ ., data = train_set)
test_pred_ct = predict(train_set_ct, test_set)
test_pred_ct_prob = 1 - unlist(treeresponse(train_set_ct, test_set), use.names =  FALSE)[seq(1, nrow(test_set) * 2, 2)]
plot(train_set_ct)

# Plotting the ROC curve with the help of ROCR package
test_pred_ROC_prob = prediction(test_pred_prob[, 2], test_set$Class)
test_pred_ROC_perf = performance(test_pred_ROC_prob, 'tpr', 'fpr')
plot(test_pred_ROC_perf, col = 2, main = 'ROC Curve')

# Calcualting the auc
auc = auc(as.numeric(test_set$Class), as.numeric(test_pred_class))





