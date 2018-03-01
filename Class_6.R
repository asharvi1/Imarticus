# This is class 6

data(BreastCancer)
dataset = BreastCancer
dataset = dataset[, 2:11]
dataset_na = na.omit(dataset)

#Fitting the logistic regression model
classifier = glm(formula = Class ~ ., data = dataset_na, family = 'binomial')
summary(classifier)

