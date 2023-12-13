#!/bin/bash

# Function to create folder structure and files
create_icon() {
  local folder_path="$1"
  local icon_name="${folder_path##*/}"
  local capitalized_icon_name="$(tr '[:lower:]' '[:upper:]' <<< ${icon_name:0:1})${icon_name:1}"
  local tsx_file="${capitalized_icon_name}Icon.tsx"
  local icon_path="src/components/icons/$tsx_file"

  # Check if file exist
  if [ -e "$icon_path" ]; then
    echo "Icon already exists. Stopping execution"
    exit 1 
  fi

  # Create folder structure
  touch $icon_path

  # Create Component .tsx file
  cat <<EOL > "$icon_path"
import React from 'react';
import { BaseIconProps } from '../../types';
import styles from './icons.module.scss';
import clsx from 'clsx';

export function ${capitalized_icon_name}Icon({ className }: BaseIconProps) {
  return (
    <svg
      className={clsx(className ? className : styles.baseIconStyles)}
    >
      {/* replace with icon svg */}
    </svg>
  );
}
EOL

  
  echo "icon structure created at $icon_path"
   #Update index.ts file
  source ./scripts/update-icons-exports.sh
}

# Check if an argument is provided
if [ -z "$1" ]; then
  echo "Please provide a folder path."
  exit 1
fi

# Call the function with the provided argument
create_icon "$1"
