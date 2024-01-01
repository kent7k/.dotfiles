import subprocess

def is_obsidian_running():
    script = 'tell application "System Events" to (name of processes) contains "Obsidian"'
    return subprocess.run(['osascript', '-e', script], capture_output=True, text=True).stdout.strip() == "true"

def quit_obsidian():
    script = 'tell application "Obsidian" to quit'
    subprocess.run(['osascript', '-e', script])

def activate_obsidian():
    script = 'tell application "Obsidian" to activate'
    subprocess.run(['osascript', '-e', script])

def quit_and_activate_obsidian():
    try:
        if is_obsidian_running():
            print("Obsidian is running. Quitting and reactivating...")
            quit_obsidian()
            # Wait briefly to ensure the application has time to quit
            subprocess.run(['sleep', '2'])
        else:
            print("Obsidian is not running. Activating...")
        activate_obsidian()
        print("Obsidian activated successfully.")
    except subprocess.SubprocessError as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    quit_and_activate_obsidian()
