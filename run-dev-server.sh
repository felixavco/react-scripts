#!/bin/bash

# Source nvm if it's available
if [ -s "$HOME/.nvm/nvm.sh" ]; then
  # Load nvm
  . "$HOME/.nvm/nvm.sh"
fi

# Read the desired Node version from the .nvmrc file
desired_version=$(<.nvmrc)

#Check if the current Node version matches the desired version
if [ "$(node -v)" != "$desired_version" ]; then
  echo 'Invalid node version detected'
  echo  "Switching to node version $desired_version"
  
  # If not, use the desired version with nvm
  nvm use
fi

# Run the Next.js app in dev mode
npm run dev
