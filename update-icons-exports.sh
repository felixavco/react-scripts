#!/bin/bash

# Define the directory path
directory="src/components/icons"

# Define the output file
output_file="${directory}/index.ts"

# Check if the output file exists and delete it if it does
if [ -e "$output_file" ]; then
  rm "$output_file"
fi

# Iterate through .tsx files in the specified directory
for file in "$directory"/*.tsx; do
  # Extract the file name without the path
  file_name=$(basename "$file")

  # Add export statement for each file
  echo "export * from './${file_name%.*}';" >> "$output_file"
done

echo "Updated Icons exports at ${output_file}"
