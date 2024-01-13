import re

def delete_index(md_content):
    # 日本語版
    start_pattern = "目次"
    end_pattern = "附則\\n+(第一章\\s総則)"  # Use double backslashes
    md_content = re.sub(rf"{start_pattern}.*?{end_pattern}", '', md_content, flags=re.DOTALL)

    # 英語版
    start_pattern2 = r"(Contents:|Contents|Table of Contents)\n目次"
    end_pattern2 = r"(Supplementary Provisions\n附[\s　]則|Chapter I General Provisions\n第一章[\s　]総則)"
    md_content = re.sub(rf"{start_pattern2}.*?{end_pattern2}", '', md_content, flags=re.DOTALL)

    return md_content
