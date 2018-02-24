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



