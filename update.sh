#!/bin/bash

# Define the base path to Firefox profiles on macOS
PROFILE_BASE_DIR="$HOME/Library/Application Support/Firefox/Profiles"

# Find the default-release profile directory
PROFILE_DIR=$(find "$PROFILE_BASE_DIR" -type d -name "*.default-release" | head -n 1)

# Check if the profile directory was found
if [ -z "$PROFILE_DIR" ]; then
  echo "Firefox profile folder not found!"
  exit 1
fi

# Source directory
SOURCE_DIR=$(pwd)

# Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Source folder not found!"
  exit 1
fi

# Loop through each item in the source directory
echo "Copying files to $PROFILE_DIR ..."

# Use rsync to copy files
rsync -av --exclude="update.sh" --exclude="README.md" --exclude=".git/" "$SOURCE_DIR/" "$PROFILE_DIR/"

# Check if the rsync command was successful
if [ $? -eq 0 ]; then
  echo "Files updated. Restart Firefox"
else
  echo "An error occurred while copying the files."
  exit 2
fi
