#!/bin/bash

# Configuration variables
WALLPAPER_DIR="."
THUMB_DIR="thumbnails"
README_FILE="README.md"
REPO_URL="https://github.com/Lokendra2244/wallpaper/raw/main"

# Create the thumbnails directory if it does not already exist
mkdir -p "$THUMB_DIR"

# ---------------------------------------------------------
# Initialize README
# ---------------------------------------------------------
echo "# Wallpaper & Media Gallery" >"$README_FILE"
echo "An automated visual gallery of all media in this directory." >>"$README_FILE"
echo "" >>"$README_FILE"

# Enable nullglob to prevent errors if a specific file extension is missing
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
# Video Section (HTML 3-Column Grid with Animated Thumbnails)
# ---------------------------------------------------------
echo "## Videos" >>"$README_FILE"
echo "Animated wallpapers and video loops. **Click any thumbnail to view or download the full video.**" >>"$README_FILE"
echo "" >>"$README_FILE"
echo "<table>" >>"$README_FILE"

count=0
row="<tr>"

for video in "$WALLPAPER_DIR"/*.{mp4,webm,mkv,mov}; do
  filename=$(basename "$video")
  raw_url="$REPO_URL/$filename"

  # Define the thumbnail path inside the thumbnails directory
  thumb_name="${filename%.*}.gif"
  thumb_path="$THUMB_DIR/$thumb_name"

  # Generate a 3-second animated GIF thumbnail if it doesn't already exist
  if [ ! -f "$thumb_path" ]; then
    echo "Generating thumbnail for $filename..."
    ffmpeg -v error -n -i "$video" -t 3 -vf "scale=250:-1" -r 10 "$thumb_path"
  fi

  # Build HTML table cell: Clickable GIF linking to raw video
  cell="<td align=\"center\"><b>$filename</b><br><br><a href=\"$raw_url\"><img src=\"$thumb_path\" width=\"250\"></a></td>"

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

# Disable nullglob
shopt -u nullglob

echo "Success: HTML 3-column gallery generated with animated thumbnails in $THUMB_DIR/!"
