import json
import os
import sys


class ConfigUtils:
    @staticmethod
    def load_config(config_path):
        try:
            with open(config_path, 'r') as config_file:
                config = json.load(config_file)
                # Expand environment variables in config
                for key, value in config.items():
                    config[key] = os.path.expandvars(value)
                return config
        except FileNotFoundError:
            sys.exit(f"Config file not found: {config_path}")
        except json.JSONDecodeError as e:
            sys.exit(f"Error parsing JSON file: {e}")
