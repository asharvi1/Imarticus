## Imarticus python second class

## Dictionaries

arabic2roman = {1:'I', 2:'II', 3:'IV', 4:'V', 5:'VI'}
arabic2roman[1]

test_dict = {'Name': 'Arun', 'Age': 25}

# To index a dictionary we call it with the key 
test_dict['Name']
test_dict['Age']

# When you print out the dictionary, no matter what order you create in, it finally gives out a alphabetical order or number sorted output
test_dict

#To add an extra key and value to the dictionary
test_dict['DOB'] = 'Jan3'

#Dictionaries are mutable
age = {'Alice': 25, 'Bob': 8}
saved = age
age['Alice'] = 29
age # Age will be updated
saved # Saved dictionary will also be updated too

# Shows the items in the dictionary
age.items()
age.keys() # Gives the keys in the dictionary
age.values() # Gives the values in the dictionary

#To update the dictionary, one of the way
age.update({'Tom': 23})
age

# To retrieve a value in the dictionary with the help of a key, one of the way
age.get('Tom')

# To remove a specific item in the dictionary with the help of a key
age.pop('Tom')
age

# To remove a random key value, but only one 
age.popitem()




















