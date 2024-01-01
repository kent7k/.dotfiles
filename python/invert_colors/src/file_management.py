import glob
import os
import shutil
import subprocess
from utils import natural_keys
from image_processing import process_image, write_log_file

RENAME_PREFIX = "book_"

def select_and_move_directories(DOWNLOAD_DIR, INPUTDIR):
    command = f"find '{DOWNLOAD_DIR}' -maxdepth 1 -type d | fzf --multi"
    selected_dirs = subprocess.check_output(command, shell=True).decode().strip().split('\n')

    for dir_path in selected_dirs:
        if dir_path:  # Check if the directory path is not empty
            shutil.move(dir_path, INPUTDIR)
            print(f"Moved directory: {dir_path}")

def rename_files(directory):
    parent_directory_name = os.path.basename(directory)
    file_paths = glob.glob(os.path.join(directory, '*.jp*g'))
    file_paths.sort(key=lambda x: natural_keys(os.path.basename(x)))

    sequence_number = 1
    for file_path in file_paths:
        new_filename = f"{RENAME_PREFIX}{parent_directory_name}_{sequence_number}.jpg"
        new_file_path = os.path.join(directory, new_filename)
        os.rename(file_path, new_file_path)
        sequence_number += 1

def process_directory(directory, INPUTDIR, OUTPUTDIR):
    print(f"Processing directory: {directory}")

    # Create base_output_path
    relative_path = os.path.relpath(directory, INPUTDIR)
    base_output_path = os.path.join(OUTPUTDIR, relative_path)
    os.makedirs(base_output_path, exist_ok=True)

    parent_directory_name = os.path.basename(directory)
    rename_files(directory)
    processed_files = []

    for image_path in glob.glob(os.path.join(directory, RENAME_PREFIX + '*.jpg')):
        processed_file_name = process_image(image_path, base_output_path)
        processed_files.append(processed_file_name)

    processed_files.sort(key=lambda x: natural_keys(x))
    write_log_file(base_output_path, parent_directory_name, processed_files)

    # Recursively process each subdirectory
    for subdirectory in [d for d in os.listdir(directory) if os.path.isdir(os.path.join(directory, d))]:
        process_directory(os.path.join(directory, subdirectory), INPUTDIR, OUTPUTDIR)

    print(f"Finished processing directory: {directory}")
