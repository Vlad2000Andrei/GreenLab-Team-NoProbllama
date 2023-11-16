import sys

user_file = sys.argv[1]
search_text = sys.argv[2]
replace_text = sys.argv[3]

# Opening our text file in read only 
# mode using the open() function 
with open(user_file, 'r') as file: 
  
    # Reading the content of the file 
    # using the read() function and storing 
    # them in a new variable 
    data = file.read() 
  
    # Searching and replacing the text 
    # using the replace() function 
    data = data.replace(search_text, replace_text) 
  
# Opening our text file in write only 
# mode to write the replaced content 
with open('out.txt', 'w') as file: 
  
    # Writing the replaced data in our 
    # text file 
    file.write(data) 
  
# Printing Text replaced 
print("Text replaced") 