#!/bin/bash

# Function to create folder structure and files
create_page() {
  local folder_path="$1"
  local page_name="${folder_path##*/}"
  local capitalized_page_name="$(tr '[:lower:]' '[:upper:]' <<< ${page_name:0:1})${page_name:1}"
  local tsx_file="${capitalized_page_name}Page.tsx"
  local page_path="src/app/${folder_path}"

  # Check if file exist
  if [ -e "$page_path" ]; then
    echo "Page already exists. Stopping execution"
    exit 1 
  fi

  # Create folder structure
  mkdir -p "src/app/$folder_path"

  # Create {argument}Page.tsx
  cat <<EOL > "$page_path/$tsx_file"
import React from 'react';

export default function ${capitalized_page_name}Page() {
  return <div>${capitalized_page_name}Page</div>;
}
EOL

  # Create page.ts
  echo "export { default } from './${capitalized_page_name}Page';" > "$page_path/page.ts";
  
  echo "Page structure created at $page_path/$tsx_file"
}

# Check if an argument is provided
if [ -z "$1" ]; then
  echo "Please provide a folder path."
  exit 1
fi

# Call the function with the provided argument
create_page "$1"
