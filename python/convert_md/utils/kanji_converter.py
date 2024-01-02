def convert_kanji_to_arabic(kanji_number):
    kanji_to_arabic = {'一': 1, '二': 2, '三': 3, '四': 4, '五': 5, '六': 6, '七': 7, '八': 8, '九': 9, '十': 10, '百': 100, '千': 1000, '〇': 0}
    current_multiplier = 1
    total = 0
    for character in reversed(kanji_number):
        if character in kanji_to_arabic:
            num = kanji_to_arabic[character]
            if num >= 10:
                if current_multiplier > 1:
                    total += current_multiplier
                current_multiplier = num
            else:
                total += num * current_multiplier
                current_multiplier = 1
    if current_multiplier > 1:
        total += current_multiplier
    return total
