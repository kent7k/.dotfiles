import subprocess


class ApplicationActivator:
    def __init__(self, app_name):
        self.app_name = app_name

    def activate(self):
        if self.app_name == "Obsidian":
            script = 'tell application "Obsidian" to activate'
            subprocess.run(["osascript", "-e", script])
        else:
            print(f"Activation script for {self.app_name} is not defined.")
