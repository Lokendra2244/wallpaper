#!/bin/bash

# Configuration variables
WALLPAPER_DIR="."
README_FILE="README.md"
REPO_URL="https://github.com/Lokendra2244/wallpaper/raw/main"

# ---------------------------------------------------------
# Initialize README
# ---------------------------------------------------------
echo "# Wallpaper & Media Gallery" >"$README_FILE"
echo "An automated visual gallery of all media in this directory." >>"$README_FILE"
echo "" >>"$README_FILE"

# Enable nullglob to prevent errors if a specific file extension is missing
shopt -s nullglob

# ---------------------------------------------------------
# Image Section (3-Column Grid)
# ---------------------------------------------------------
echo "## Images" >>"$README_FILE"
echo "" >>"$README_FILE"

# Setup the Markdown table header
echo "| Column 1 | Column 2 | Column 3 |" >>"$README_FILE"
echo "| :---: | :---: | :---: |" >>"$README_FILE"

count=0
row=""

for image in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp,gif}; do
  filename=$(basename "$image")

  # Build the cell using the relative path
  cell="**$filename**<br><img src=\"$filename\" alt=\"$filename\" width=\"250\">"

  # Append cell to the current row
  row="${row}| ${cell} "
  count=$((count + 1))

  # If we hit 3 items, print the row and reset
  if [ $count -eq 3 ]; then
    echo "${row}|" >>"$README_FILE"
    row=""
    count=0
  fi
done

# Handle any leftovers that didn't make a full row of 3
if [ $count -gt 0 ]; then
  while [ $count -lt 3 ]; do
    row="${row}| "
    count=$((count + 1))
  done
  echo "${row}|" >>"$README_FILE"
fi

echo "" >>"$README_FILE"

# ---------------------------------------------------------
# Video Section (3-Column Grid with Raw URLs)
# ---------------------------------------------------------
echo "## Videos" >>"$README_FILE"
echo "Animated wallpapers and video loops." >>"$README_FILE"
echo "" >>"$README_FILE"

# Setup the Markdown table header
echo "| Column 1 | Column 2 | Column 3 |" >>"$README_FILE"
echo "| :---: | :---: | :---: |" >>"$README_FILE"

count=0
row=""

for video in "$WALLPAPER_DIR"/*.{mp4,webm,mkv,mov}; do
  filename=$(basename "$video")

  # Construct the absolute raw URL for GitHub
  raw_url="$REPO_URL/$filename"

  # Build the cell using the raw URL
  cell="**$filename**<br><video src=\"$raw_url\" controls width=\"250\"></video>"

  # Append cell to the current row
  row="${row}| ${cell} "
  count=$((count + 1))

  # If we hit 3 items, print the row and reset
  if [ $count -eq 3 ]; then
    echo "${row}|" >>"$README_FILE"
    row=""
    count=0
  fi
done

# Handle any leftovers that didn't make a full row of 3
if [ $count -gt 0 ]; then
  while [ $count -lt 3 ]; do
    row="${row}| "
    count=$((count + 1))
  done
  echo "${row}|" >>"$README_FILE"
fi

# Disable nullglob
shopt -u nullglob

echo "Success: 3-column gallery generated in $README_FILE!"
