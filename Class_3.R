# Factors
x = c(1:5)

x = as.factor(x)# Creating a factor

class(x)


# Using a tapply function

ages = c(25, 26, 55, 37, 21, 42)
location = c('rural', 'urban', 'urban', 'rural', 'urban', 'rural')
tapply(ages, location, mean)


##Univariate -- 1) Mean, median, mode 2)var, std, range, quartiles, deciles, percentiles, median deviation, mode deviation
##              3)skewness, kurtosis, homoscadaticity, heteroscadasticity (1-measures of central tendency, 2-measures of dispersion, 3-measures of shape)

##Bivariate -- Hypothesis testing, coefficient of variation, correlation, crosstabs, parametric&non-parametric tests, ANOVA

##Multivariate -- 1)Regression(linear(simple linear, multiple linear), non-linear(binomial logistic, multinomial logistic)) 
##                2)SVM(support vector machine), 3)tree induction models(decision tree, random forest)

# Linear Models

## Regression -- 1) OLS(most commonly used technique) 2)GLS 3)WLS

#Performing a Linear Regression model on Longley Dataset

dataset = longley

summary(dataset)
str(dataset)#Gives the structure of the dataset

linear_model = lm(formula = Employed ~ GNP, data = dataset)#Fitting the model, Only performing the simple linear regression with the GNP variable




