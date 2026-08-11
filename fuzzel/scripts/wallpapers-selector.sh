WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

declare -A wallpaper_map
while IFS= read -r fullpath; do
	filename=$(basename "$fullpath")
	wallpaper_map["$filename"]="$fullpath"
done < <(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \))

names=$(printf "%s\n" "${!wallpaper_map[@]}" | sort)
selected=$(echo "$names" | fuzzel --dmenu)
if [ -n "$selected" ]; then
	pkill swaybg 2>/dev/null
	swaybg -i "${wallpaper_map[$selected]}" -m stretch &
fi
