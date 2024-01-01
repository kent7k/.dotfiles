CONFIG_PATH="$DOT_FILES/python/invert_colors/config.json"

# Read configuration
BASE_DIR=$(jq -r '.BASE_DIR' "$CONFIG_PATH" | envsubst)
DOWNLOAD_DIR=$(jq -r '.DOWNLOAD_DIR' "$CONFIG_PATH" | envsubst)
KEMARI_DIR=$(jq -r '.KEMARI_DIR' "$CONFIG_PATH" | envsubst)

# Define other directories
BKP_DIR1="${DOWNLOAD_DIR}/____Done1" # nested 'src' dir
BKP_DIR2="${DOWNLOAD_DIR}/____Done2"
TMP_NEGAPOSI_BEFORE_PROCESS="${BASE_DIR}/images_for_negaposi/"
TMP_NEGAPOSI_AFTER_PROCESS="${BASE_DIR}/negaposi_images/"
TMP_IMPORT_TO_OBSIDIAN="${DOWNLOAD_DIR}/____Done_should_be_sent_into_Obsidian"
readonly OBSIDIAN_IMG_DIR="${KEMARI_DIR}/___images"

ensure_directory_exists() {
    local dir=$1
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo "Created directory $dir."
    fi
}

check_success() {
    if [ $? -ne 0 ]; then
        echo "Previous command failed. Exiting."
        exit 1
    fi
}

# Verify base directory existence
[ -d "$BASE_DIR" ] || { echo "Directory $BASE_DIR does not exist."; exit 1; }

ensure_directory_exists "$BKP_DIR1"
ensure_directory_exists "$BKP_DIR2"
ensure_directory_exists "$TMP_IMPORT_TO_OBSIDIAN"
ensure_directory_exists "$TMP_NEGAPOSI_BEFORE_PROCESS"
ensure_directory_exists "$TMP_NEGAPOSI_AFTER_PROCESS"
ensure_directory_exists "$TMP_IMPORT_TO_OBSIDIAN"
ensure_directory_exists "$KEMARI_DIR"

## 0. Move directories to designated locations
mv "${TMP_NEGAPOSI_BEFORE_PROCESS}"* "$BKP_DIR2/" &&
check_success

mv "${TMP_NEGAPOSI_AFTER_PROCESS}"* "$TMP_IMPORT_TO_OBSIDIAN/" &&
check_success

## Prompt for optimization confirmation
##while true; do
##    echo "Are you optimized?"
##    read -r response
##    if [ "$response" = "yes" ]; then
##        break
##    fi
##done

find "$TMP_IMPORT_TO_OBSIDIAN" -type f -name "*.md" -exec mv {} "$KEMARI_DIR/" \; &&
check_success

find "$TMP_IMPORT_TO_OBSIDIAN" -type f -path "*/modified/*.jpg" -exec mv {} "$OBSIDIAN_IMG_DIR/" \; &&
check_success

find "$TMP_IMPORT_TO_OBSIDIAN" -type d -name "modified" -empty -exec rmdir {} \; &&
check_success

mv "$TMP_IMPORT_TO_OBSIDIAN/"* "$BKP_DIR1/" &&
check_success

rm -rf "$TMP_IMPORT_TO_OBSIDIAN" &&
rm -rf "$TMP_NEGAPOSI_BEFORE_PROCESS" &&
rm -rf "$TMP_NEGAPOSI_AFTER_PROCESS" &&
rm -rf "$TMP_IMPORT_TO_OBSIDIAN" &&

echo "Finished."
