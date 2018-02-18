# This is the first class

getwd() #to get the path of the working directory

install.packages('car') #To install a package


?median #To get the documentation of a function


example("median") #To get the example code of a function

?apropos()#Helps us to find the similar packages with a similar keyword

# "~"(Tilde) is used to seperate the dependant and the independant variable

runif(5)#To get random numbers from a uniform distribution

#Vector takes only a single type of class(integer, string, logical)


a = 1:5

length(a)#to know the length of a vector

ab = c('Hyderabad')

nchar(ab)#To know the length of a character


max(a)#To find the max value of a vector

##Dealing with the missing values
a = c(1:5,NA)

is.na(a)#To find the position of the missing value thru TRUE and FALSE

mean(a)#mean cannot be calculated with a vector that consists of NA values

mean(a, na.rm = TRUE)#Inorder to find the mean with missing values

which(is.na(a))#To find the position of the null values in a vector

ifelse(is.na(a), 0, a)#To replace with zeroes

#Playing with sequence values

seq1 = function(x, y){
  seq(min(a), max(a), y)
}

a = 1:5
seq1(a, 0.5)
a

rep(a, 2)#To repeat a value different number of times, in this case "2"


x = c(6, 1:3, NA, 12)

subset(x, x>5)# Subset the values that are greater than 5

x[x<5]#Similar 

set.seed(2)

sample(1:100, 25)

sample(1:100, 25)
runif(5)
runif(5)


set.seed(5) 
rnorm(5)

set.seed(5)
rnorm(5)

set.seed(5)
sample(1:100, 5)


