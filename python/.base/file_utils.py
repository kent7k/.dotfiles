import os
from urllib.parse import urljoin


class FileUtils:
    @staticmethod
    def read_file_content(file_path):
        print(f"Processing file: {file_path}")
        if not os.path.exists(file_path):
            print("The file does not exist.")
            return None

        with open(file_path, "r", encoding="utf-8") as file:
            return file.read()

    @staticmethod
    def write_file_content(file_path, content, mode="w"):
        try:
            with open(file_path, mode, encoding="utf-8") as file:
                file.write(content)
            print(f"File successfully written: {file_path}")
        except Exception as e:
            print(f"Error writing file {file_path}: {e}")

    @staticmethod
    def get_files_with_extension(base_path, expected_extension):
        files_with_extension = []
        found_extensions = set()

        for file in os.listdir(base_path):
            _, extension = os.path.splitext(file)
            found_extensions.add(extension)

            if file.endswith(expected_extension):
                file_path = os.path.join(base_path, file)
                files_with_extension.append(file_path)

        if not files_with_extension:
            found_ext_str = ", ".join(found_extensions)
            print(
                f"Found: {found_ext_str}. But no files with extension {expected_extension} were found."
            )

        return files_with_extension

    @staticmethod
    def read_history_log(filename):
        try:
            with open(filename, "r") as file:
                return file.read().splitlines()
        except FileNotFoundError:
            return []

    @staticmethod
    def append_link_to_history(filename, link):
        try:
            with open(filename, "a") as file:
                file.write("\n" + link)
        except Exception as e:
            print(f"An error occurred while writing to the file: {e}")

    @staticmethod
    def construct_absolute_url(base_url, relative_url):
        """
        Constructs an absolute URL by combining a base URL with a relative URL.

        Parameters:
        base_url (str): The base URL.
        relative_url (str): The relative URL to be combined with the base.

        Returns:
        str: The absolute URL formed by combining the base and relative URLs.

        Note: If either the base_url or relative_url is invalid or empty,
        the method returns None.
        """

        if not base_url or not relative_url:
            return None

        try:
            return urljoin(base_url, relative_url)
        except Exception as e:
            print(f"Error in URL construction: {e}")
            return None
