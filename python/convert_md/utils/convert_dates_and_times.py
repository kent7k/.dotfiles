import re

from .convert_kanji_to_arabic import convert_kanji_to_arabic

def replace_dates_and_times(md_content):
    # Pattern for dates like '過去十年'
    date_pattern = r'(過去|未来)?([一二三四五六七八九十百千〇]+)年'
    md_content = re.sub(date_pattern, lambda match: f'{match.group(1) if match.group(1) else ""}{convert_kanji_to_arabic(match.group(2))}年', md_content)

    # Pattern for times like '午後六時'
    time_pattern = r'(午前|午後)([一二三四五六七八九十百千〇]+)時'
    md_content = re.sub(time_pattern, lambda match: f'{match.group(1)}{convert_kanji_to_arabic(match.group(2))}時', md_content)

    # Pattern for expressions like '五平方'
    square_pattern = r'([一二三四五六七八九十百千〇]+)(平方|日)'
    md_content = re.sub(square_pattern, lambda match: f'{convert_kanji_to_arabic(match.group(1))}{match.group(2)}', md_content)

    # Pattern for unit '平方メートル'
    unit_pattern = r'平方メートル'
    md_content = md_content.replace(unit_pattern, "㎡")

    return md_content


# Example usage
md_content = "過去十年と午後六時"
converted_content = replace_dates_and_times(md_content)
print(converted_content)  # Should print '過去10年と午後6時'
