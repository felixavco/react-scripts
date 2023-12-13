#!/bin/bash

# Function to create folder structure and files
create_component() {
  local folder_path="$1"
  local component_name="${folder_path##*/}"
  local capitalized_component_name="$(tr '[:lower:]' '[:upper:]' <<< ${component_name:0:1})${component_name:1}"
  local tsx_file="${capitalized_component_name}.tsx"
  local component_path="src/components/$capitalized_component_name"

  # Check if file exist
  if [ -e "$component_path" ]; then
    echo "Component already exists. Stopping execution"
    exit 1 
  fi

  # Create folder structure
  mkdir -p $component_path

  # Create Component .tsx file
  cat <<EOL > "$component_path/$tsx_file"
import React from 'react';

interface ${capitalized_component_name}Props {};

export function ${capitalized_component_name}(props: ${capitalized_component_name}Props) {
  return <div>${capitalized_component_name} Component</div>;
}
EOL

  # Create page.ts
  echo "export * from './${capitalized_component_name}';" > "$component_path/index.ts";
  
  echo "Component structure created at $component_path"
   #Update index.ts file
  source ./scripts/update-components-exports.sh
}

# Check if an argument is provided
if [ -z "$1" ]; then
  echo "Please provide a folder path."
  exit 1
fi

# Call the function with the provided argument
create_component "$1"
