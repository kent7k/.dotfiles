import cv2
import os
import shutil

def negaposi(image_path):
    img = cv2.imread(image_path)
    if img is None:
        print(f"Failed to load image: {image_path}")
        return None
    img_negaposi = cv2.bitwise_not(img)
    return img_negaposi

def process_image(image_path, base_output_path):
    # Process a single image and save the results
    img_negaposi = negaposi(image_path)

    src_output_path = os.path.join(base_output_path, "src", os.path.basename(image_path))
    modified_output_path = os.path.join(base_output_path, "modified", os.path.basename(image_path))

    os.makedirs(os.path.dirname(src_output_path), exist_ok=True)
    os.makedirs(os.path.dirname(modified_output_path), exist_ok=True)

    shutil.copy(image_path, src_output_path)
    cv2.imwrite(modified_output_path, img_negaposi)

    return os.path.basename(image_path)

def write_log_file(base_output_path, parent_directory_name, processed_files):
    log_file_name = f'book_{parent_directory_name}.md'
    log_file_path = os.path.join(base_output_path, log_file_name)
    os.makedirs(os.path.dirname(log_file_path), exist_ok=True)

    with open(log_file_path, 'w') as log_file:
        for file_name in processed_files:
            log_file.write(f"![]({file_name})\n\n")  # Markdown format
