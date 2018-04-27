#This is the second class

z = c(6,5,-3,7)

z[z*z>9]#Subsetting the vector with respect to the logical sign

##Data type conversions
a = c('45', '55')

a = as.numeric(a)#Coverting a numeric string to a numeric entity

is.numeric(a)#To find the respective data type

mode(a)#To find the type of data type(Numeric or character) with out any previous knowledge on the data type

##Paste Function

a = 'hello'

b = '55'

paste(a, b, sep = ' ')#pasting the vectors or object with a delimeter

X = c('apple', 'potato', 'grape', '10', 'blue.flower')

grep('a',X)#To check the pattern of a particular character in the first argument setion,in this case its checking for 'a' character in X

grep('a', X, value = TRUE)#To print out the value with value = true argument

grep('[[:digit:]]', X, value = TRUE)#To check for the vectors with digit as a character in it


##Subsetting a character

word = 'apples'
substr(word,start = 1, stop = 3)#Subset from the length of the string

substr(word, start = 1, stop = 1) = 'b'#Replacing  a particular character in a string with the help of a subsetstr

word

word = 'Apple'

chartr(old = 'A', new = 'a', word)#Replacing a letter in a string

word = 'apple|lime|orange'

v = strsplit(word, split = '|', fixed = TRUE)#Splitting a string with respect to a seperator
v

v[[1]][1]#indexing a list


##Matrices

y = matrix(c(1,2,3,4), nrow = 2, ncol = 2)#Creating a matrix with the respective dimensions
y

y = matrix(c(1,2,3,4), nrow = 2, ncol = 2, byrow = TRUE)#Filling the matrix according to the rows
y

mode(y)#Mode only shows the numeric or character 
class(y)#Class helps to find out the type of the data type

t(y)#To transpose a matrix or any other forms of data(data frame, arrays, lists etc)

X = matrix(c(50, 70, 40, 90, 60, 80, 50, 90, 100, 50, 30, 70), nrow = 3)

rownames(X) = rownames(X, do.NULL = FALSE, prefix = 'Test.')#To change the row names of a matrix array or dataframe

X

subs = c('Test1', 'Test2', 'Test3', 'Test4')

colnames(X) = subs#To assign the column names of a matrix or a datadrame or an array
X

mean(X[,4])#To find the mean of 4th column

median(X[,4])#To find the median of 4th column

mean(X[2,])#To find the mean of 2nd row


rowSums(X)#To find the sums of all rows respectively

colSums(X)#To find the sums of all columns respectively

rowMeans(X)#To find the means of the rows respectively
X

apply(X, 1, mean)#Here the second argument represents the col(2) or row(1)


Xrow = apply(X, 1, mean)

Xcol = apply(X,2, mean)

X = rbind(X, Xcol) #Adding a row to the matrix
X

Xrow = apply(X, 1, mean)

X = cbind(X, Xrow)# Adding a column to the matrix
X


##Arrays

A = letters[1:18]

dim(A) = c(3,2,3)#Creating an array with the dimension
A
class(A)

array = 1:20

class(array)

dim(array) = c(5,4)#Creating a matrix with the dim function, but using a matrix function is much more flexible

array
class(array)

dim(array)


a = letters[1:24]
dim(a) = c(2,3,4)
is.array(a)
class(a)
a

class(a[1])
a[1]
a[,,1]

a[1,,, drop = F]#If you still want to keep it is as an array
a[1,,]#If you want to change it to a matrix

a = c(55, 'hello')#We cannot have different data types in a single vector
a

a = list(55, 'hello')#If we want to have different datatypes we use lists
a


a[[1]]#Indexing of a list


a[[3]] = 'hey there brown cow' #Adding a vector to a list 
a

a[[3]] = NULL #To remove a vector from the list
a


lapply(list(1:5, 20:22), median) #Gives the output as the respective format, in this case it is a list

sapply(list(1:5, 20:22), median) #Gives the output as a vector(simplified format)



##Data Frame


kids = c('John', 'Joe', 'Chloe')
ages = c(10, 8, 9)
data = data.frame(kids, ages, stringsAsFactors = FALSE)
data
data$kids
class(data)
data$kids[1]


#To access rows or columns in a dataframe, dataframe[m,n], m(rows), n(columns)
#To accesss multiple columns or rows we can use the concatanation "c()" or the series sign ":"
#To access the columns with respective to their column names we can write dataframe[, c(column names)]

dataset = mtcars

head(dataset)

dataset[1,1]

str(dataset)
names(dataset)#To show the variable names


data

data[data$ages > 8,]#Subsetting the data with the help of a logic


rbind(data, list('John', 25))#adding a row to the dataset







