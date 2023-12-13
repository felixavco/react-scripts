#!/bin/bash

# Function to create folder structure and files
create_type() {
  local folder_path="$1"
  local type_name="${folder_path##*/}"
  local capitalized_type_name="$(tr '[:lower:]' '[:upper:]' <<< ${type_name:0:1})${type_name:1}"
  local ts_file="${capitalized_type_name}.ts"
  local type_path="src/types/${ts_file}"

    # Check if file exist
  if [ -e "$type_path" ]; then
    echo "Type file already exists. Stopping execution"
    exit 1 
  fi

  # Create folder structure
  touch $type_path

  # Create {argument}.ts
  cat <<EOL > $type_path
export interface ${capitalized_type_name} {

}
EOL

  source ./scripts/update-types-exports.sh
}

# Check if an argument is provided
if [ -z "$1" ]; then
  echo "Please provide a folder path."
  exit 1
fi

# Call the function with the provided argument
create_type "$1"
