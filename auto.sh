#!/bin/bash

# Configuration variables
WALLPAPER_DIR="."
README_FILE="README.md"

# ---------------------------------------------------------
# Initialize README
# ---------------------------------------------------------
echo "# Wallpaper & Media Gallery" >"$README_FILE"
echo "An automated visual gallery of all media in this directory." >>"$README_FILE"
echo "" >>"$README_FILE"

# Enable nullglob to prevent errors if a specific file extension is missing
shopt -s nullglob

# ---------------------------------------------------------
# Image Section (Scaled Thumbnails)
# ---------------------------------------------------------
echo "## Images" >>"$README_FILE"
echo "" >>"$README_FILE"

for image in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp,gif}; do
  filename=$(basename "$image")

  echo "### $filename" >>"$README_FILE"
  # Using HTML tags to scale the image down to a 400px wide thumbnail
  echo "<img src=\"$filename\" alt=\"$filename\" width=\"400\">" >>"$README_FILE"
  echo "<br>" >>"$README_FILE"
done

echo "" >>"$README_FILE"

# ---------------------------------------------------------
# Video Section (Playable Embeds)
# ---------------------------------------------------------
echo "## Videos" >>"$README_FILE"
echo "Animated wallpapers and video loops." >>"$README_FILE"
echo "" >>"$README_FILE"

for video in "$WALLPAPER_DIR"/*.{mp4,webm,mkv,mov}; do
  filename=$(basename "$video")

  echo "### $filename" >>"$README_FILE"
  # Using HTML tags for a playable video player, scaled to match image thumbnails
  echo "<video src=\"$filename\" controls=\"controls\" width=\"400\"></video>" >>"$README_FILE"
  echo "<br>" >>"$README_FILE"
done

# Disable nullglob
shopt -u nullglob

echo "Success: Thumbnail gallery linked to $README_FILE!"
