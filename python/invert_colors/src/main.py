import json
import os
import subprocess
from file_management import select_and_move_directories, process_directory
from activate_obsidian import quit_and_activate_obsidian

config_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'config.json')
with open(config_path, 'r') as config_file:
    config = json.load(config_file)

def expand_env_variables(config_dict):
    for key, value in config_dict.items():
        config_dict[key] = os.path.expandvars(value)

expand_env_variables(config)

BASE_DIR = config['BASE_DIR']
DOWNLOAD_DIR = config['DOWNLOAD_DIR']
INPUTDIR = os.path.join(BASE_DIR, 'images_for_negaposi')
OUTPUTDIR = os.path.join(BASE_DIR, 'negaposi_images')

def call_shell_script(script_path):
    try:
        subprocess.run(script_path, check=True, shell=True)
        print(f"Shell script {script_path} executed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"An error occurred while executing the shell script: {e}")

def ensure_dir_exists(directory):
    if not os.path.isdir(directory):
        os.makedirs(directory)

if __name__ == "__main__":
    ensure_dir_exists(INPUTDIR)
    ensure_dir_exists(OUTPUTDIR)

    select_and_move_directories(DOWNLOAD_DIR, INPUTDIR)
    process_directory(os.path.join(BASE_DIR, 'images_for_negaposi'), INPUTDIR, OUTPUTDIR)

    call_shell_script(os.path.join(BASE_DIR, 'obsidian.sh'))
    quit_and_activate_obsidian()
