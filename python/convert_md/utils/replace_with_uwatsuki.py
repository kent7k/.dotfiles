import re


def replace_pattern_uwatsuki(text):
    # This regex pattern finds all occurrences of text within （ and ）, including nested ones
    pattern = r'（[^（）]*（[^（）]*）[^（）]*）|（[^（）]*）'
    # Replace the found pattern with <sup> tag
    # \u00A0 is a non-breaking space
    replaced_text = re.sub(pattern, lambda m: f"<sup>{m.group()}</sup>", text)
    return replaced_text


def replace_half_width_pattern_exclude_short(text):
    # (xviii) などをパターンから除外するために必要
    # This regex pattern finds all occurrences of text within ( and ), including nested ones,
    # but excludes patterns with less than 3 characters inside the parentheses
    pattern = r'\([^()]{6,}\([^()]*\)[^()]{6,}\)|\([^()]{6,}\)'
    # Replace the found pattern with <sup> tag
    replaced_text = re.sub(pattern, lambda m: f"<sup>{m.group()}</sup>\u00A0", text)
    return replaced_text
