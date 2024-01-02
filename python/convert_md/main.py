import os
import sys

def setup_import_path():
    sys.path.append(os.path.expandvars('$DOT_FILES/python/.base/'))

setup_import_path()

from utils.convert_to_md import convert_to_md
from config_utils import ConfigUtils
from file_utils import FileUtils
from app_utils import ApplicationActivator

config_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'config.json')
config = ConfigUtils.load_config(config_path)

txt_files = FileUtils.get_files_with_extension(config['BASE_PATH'], '.txt')
for file_path in txt_files:
    txt_file = FileUtils.read_file_content(file_path)
    md_content = convert_to_md(txt_file)

    file_name = os.path.basename(file_path)
    new_md_file_name = os.path.splitext(file_name)[0] + '.md'
    new_md_file_path = os.path.join(config['KEMARI_DIR'], new_md_file_name)
    FileUtils.write_file_content(new_md_file_path, md_content)

activator = ApplicationActivator('Obsidian')
activator.activate()
