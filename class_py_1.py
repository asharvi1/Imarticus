## Imarticus Python first class


mystring = 'This is a test.'

for i in range(len(mystring)):
    print (mystring[i])

mystring_list = [mystring[x] for x in range(len(mystring))]

# Indexing a string object
mystring[0]

# Subsetting the string
mystring[0:4]

# Subsetting with negetive indexing, "-1" gives the last
mystring[-2]

# To know the length of a string
len(mystring)

# Even if the object is out of range, it prints till the end of the string object
mystring[0:18]

## Traversals with loops
# While loop
def traversal(string_object, search_letter):
    i = 0
    while (i < len(string_object)):
        if string_object[i] == search_letter:
            print ('Found', search_letter, 'at position', i)
        i = i + 1

traversal(string_object = mystring, search_letter = 'a')

# For loop
for i in mystring:
    if i == 's':
        print ('found s')
        
## Tuples
# Can take differet types of inputs in a single object

tuple_1 = (1, 'Hyderabad', 13.5, True)
tuple_2 = (11, 22, 33)

# We can only add a tuple to the tuple but not an integer to the tuple
tuple_2 = tuple_2 + (44,)

tuple_2

# Sorting a tuple gives a list
sorted(tuple_2)    

# We can also use it in a list comprehension
a = [i for i in tuple_2] 

# Checking the type of a
type(a)

# To check a specific object present in a tuple, gives a logical output
44 in tuple_2

# Converting a string to a tuple
mystring_tuple = tuple(mystring)
mystring_tuple

# The bottom approach is also a tuple
x = 1,2 

# Tuples used in a function
def area_vol_cube(side_length):
    area = 6 * side_length * side_length
    volume = side_length * side_length * side_length
    return area, volume

# Can also divide the tuple output
cube_5_area, cube_5_volume = area_vol_cube(5)












        
        

