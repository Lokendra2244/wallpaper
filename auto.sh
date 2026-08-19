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

shopt -s nullglob

# ---------------------------------------------------------
# Image Section (HTML 3-Column Grid)
# ---------------------------------------------------------
echo "## Images" >>"$README_FILE"
echo "" >>"$README_FILE"
echo "<table>" >>"$README_FILE"

count=0
row="<tr>"

for image in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp,gif}; do
  filename=$(basename "$image")

  # Build HTML table cell
  cell="<td align=\"center\"><b>$filename</b><br><br><img src=\"$filename\" alt=\"$filename\" width=\"250\"></td>"
  row="${row}${cell}"
  count=$((count + 1))

  if [ $count -eq 3 ]; then
    echo "${row}</tr>" >>"$README_FILE"
    row="<tr>"
    count=0
  fi
done

# Handle leftover image columns
if [ $count -gt 0 ]; then
  echo "${row}</tr>" >>"$README_FILE"
fi
echo "</table>" >>"$README_FILE"
echo "" >>"$README_FILE"

# ---------------------------------------------------------
# Video Section (HTML 3-Column Grid with Raw URLs)
# ---------------------------------------------------------
echo "## Videos" >>"$README_FILE"
echo "Animated wallpapers and video loops." >>"$README_FILE"
echo "" >>"$README_FILE"
echo "<table>" >>"$README_FILE"

count=0
row="<tr>"

for video in "$WALLPAPER_DIR"/*.{mp4,webm,mkv,mov}; do
  filename=$(basename "$video")
  raw_url="$REPO_URL/$filename"

  # Build HTML table cell with raw URL
  cell="<td align=\"center\"><b>$filename</b><br><br><video src=\"$raw_url\" controls width=\"250\"></video></td>"
  row="${row}${cell}"
  count=$((count + 1))

  if [ $count -eq 3 ]; then
    echo "${row}</tr>" >>"$README_FILE"
    row="<tr>"
    count=0
  fi
done

# Handle leftover video columns
if [ $count -gt 0 ]; then
  echo "${row}</tr>" >>"$README_FILE"
fi
echo "</table>" >>"$README_FILE"

shopt -u nullglob
echo "Success: HTML 3-column gallery generated!"
