# This is class 5
data() # shows all the sample datasets that come with R

write.csv(mtcars, '/Users/ravikiran/Desktop/Imarticus/Academics/class practice/R/mtcars.csv')

dataset = read.csv('mtcars.csv')
str(dataset) # Checking the structure of the dataset

# Creating a correlation matrix
cor(dataset[2:12])

corPlot(dataset[2:12])# Checking the correlation between the variables with the openair package

# Plotting desnity plot

plot(density(dataset$cyl), main = 'Desnity plot for the cyl')

# Creating a regression model
regressor = lm(mpg~cyl+wt+am+gear+carb, data = dataset)
summary(regressor)

fitted(regressor)
residuals(regressor)
mean(residuals(regressor))
plot(regressor)
