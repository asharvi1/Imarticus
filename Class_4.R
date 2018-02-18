#This is class 4, Playing with the longley dataset

dataset = longley

linear_model = lm(formula = Employed ~ GNP, data = dataset)

summary(linear_model)
fitted(linear_model)# Shows the predicted values (fitted function)
residuals(linear_model)# Gives the error in the predicted values (actual - predicted)


# Visualising the residual values in the graph to identify the outliers
qqnorm(resid(linear_model))
qqline(resid(linear_model))

# Density plot of the residuals

plot(density(resid(linear_model)))

# Multiple Linear Regression

multiple_linear_model = lm(Employed ~ ., data = dataset)

residuals(linear_model)
sum(residuals(linear_model))


#Visualising the Linear model
plot(dataset$GNP, dataset$Employed, main = 'Simple Linear', xlab = 'GNP', ylab = 'Employed', col = 'red', pch = 16)
abline(lm(Employed ~ GNP, data = dataset))


#Visualisng the Linear model with ggplot2

dataset = dataset[, c(2,7)]


ggplot(data = dataset, aes(x =  dataset$GNP, y = dataset$Employed)) +
  geom_point() +
  geom_smooth(method = lm)


