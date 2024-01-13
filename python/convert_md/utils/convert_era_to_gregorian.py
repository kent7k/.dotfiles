import re
from .convert_kanji_to_arabic import convert_kanji_to_arabic


def convert_era_to_gregorian(md_content):
    era_to_start_year = {
        '明治': 1868,
        '大正': 1912,
        '昭和': 1926,
        '平成': 1989,
        '令和': 2019,
    }

    era_year_pattern = r'(明治|大正|昭和|平成|令和)([一二三四五六七八九十百千〇]+)年'

    return re.sub(era_year_pattern, lambda match: f'{era_to_start_year[match.group(1)] + convert_kanji_to_arabic(match.group(2)) - 1}年', md_content)
