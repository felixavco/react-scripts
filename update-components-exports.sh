#!/bin/bash

# Define the directory path
directory="src/components"

# Define the output file
output_file="${directory}/index.ts"

#Check if the output file exists and delete it if it does
if [ -e "$output_file" ]; then
  rm "$output_file"
fi


# Iterate through directories in the specified directory
for file in "$directory"/*; do
  # Check if the file is a directory and starts with an uppercase letter
  if [ -e "$file" ] && [[ "$(basename "$file")" =~ ^[A-Z] ]]; then
    # Extract the directory name without the path
    dir_name=$(basename "$file")

    # Add export statement for each directory
    echo "export * from './${dir_name%.*}';" >> "$output_file"
  fi
done

echo "Updated Component exports at ${output_file}"
