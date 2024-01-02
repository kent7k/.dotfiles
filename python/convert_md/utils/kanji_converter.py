import re
from .convert_kanji_to_arabic import convert_kanji_to_arabic


def replace_kanji_numerals(md_content):
    kanji_numerals_pattern = r'(第[一二三四五六七八九十百千〇]+)(章|節|条|項|号)(の[一二三四五六七八九十百千〇]+)?'
    md_content = re.sub(kanji_numerals_pattern, replace_match, md_content)

    md_content = replace_specific_patterns(md_content)
    return md_content


def replace_match(match):
    chapter = convert_kanji_to_arabic(match.group(1))
    section = match.group(2)
    subsection = match.group(3)
    return f'{chapter}{section}{convert_kanji_numerals_with_prefix(subsection) if subsection else ""}'


def convert_kanji_numerals_with_prefix(kanji_numerals_with_prefix):
    prefix, kanji_numerals = kanji_numerals_with_prefix[0], kanji_numerals_with_prefix[1:]
    return f'{prefix}{convert_kanji_to_arabic(kanji_numerals)}'


def replace_specific_patterns(input_string):
    # Define regex patterns for different cases
    pattern_full = r'(\d+)条(\d+)項(\d+)号'
    pattern_article_section = r'(\d+)条(\d+)項'
    pattern_section_number = r'(\d+)項(\d+)号(から(\d+)号)?'
    pattern_section = r'(\d+)項'
    pattern_article = r'(\d+)条'
    pattern_item = r'(\d+)号'

    # Define a function to convert numerals to Roman numerals for "号"
    def to_roman(num):
        roman_numerals = {1: 'i', 2: 'ii', 3: 'iii', 4: 'iv', 5: 'v', 6: 'vi', 7: 'vii', 8: 'viii', 9: 'ix', 10: 'x'}
        return roman_numerals.get(int(num), num)

    # Replace section and number pattern (e.g., 4項5号)
    input_string = re.sub(pattern_section_number, lambda
        m: f'({m.group(1)})-({to_roman(m.group(2))}){"~(" + to_roman(m.group(4)) + ")" if m.group(4) else ""}',
                          input_string
                          )

    # Replace full pattern (e.g., 2条1項4号)
    input_string = re.sub(pattern_full, lambda m: f'{m.group(1)}-({m.group(2)})-({to_roman(m.group(3))})', input_string)

    # Replace article and section pattern (e.g., 24条1項)
    input_string = re.sub(pattern_article_section, r'\1-(\2)', input_string)



    # Replace section pattern (e.g., 3項)
    input_string = re.sub(pattern_section, r'(\1)', input_string)

    # Replace article pattern (e.g., 3条)
    input_string = re.sub(pattern_article, r'\1', input_string)

    # Replace item pattern (e.g., 3号)
    input_string = re.sub(pattern_item, r'\1', input_string)

    return input_string
