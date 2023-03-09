#!/bin/bash

# Set the filename and path to the JPEG file
file="corgo2.jpg" #**CHANGE THIS**

# Set the path to the password list file
wordlist="found.txt" #**CHANGE THIS**

# Loop through each password in the password list
while read password; do
  # Attempt to extract the file using the current password
  output=$(steghide extract -sf "$file" -p "$password" 2>&1)

  # Check if the output contains the word "could not extract", which indicates that the password was incorrect
  if [[ "$output" == *"could not extract"* ]]; then
    # If the password is incorrect, display a message and continue to the next password
    echo "Incorrect password: $password"
  else
    # If the password is correct, display a message and exit the loop
    echo "Password found: $password"
    break
  fi
done < "$wordlist"

# If the script reaches this point, it means that none of the passwords in the list were correct
echo "Password not found in list"
exit 1
