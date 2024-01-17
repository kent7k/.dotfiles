import html2text
import os

def convert_html_to_md(html_file_path):
    # Check if the file exists
    if not os.path.exists(html_file_path):
        print("The file does not exist.")
        return

    # Read HTML content
    with open(html_file_path, 'r', encoding='utf-8') as file:
        html_content = file.read()

    # Convert HTML to Markdown
    text_maker = html2text.HTML2Text()
    text_maker.body_width = 0
    markdown_content = text_maker.handle(html_content)

    # Define Markdown file path
    md_file_path = os.path.splitext(html_file_path)[0] + '.md'

    # Write Markdown content to a new file
    with open(md_file_path, 'w', encoding='utf-8') as file:
        file.write(markdown_content)
    print(f"Markdown file saved as: {md_file_path}")

# Example usage
html_file_path = '/Users/kent/Downloads/345AC0000000048_20230614_505AC0000000053.html'  # Replace with your HTML file path
convert_html_to_md(html_file_path)
