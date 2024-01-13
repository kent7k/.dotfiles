import re

kanji_numbers = '一二三四五六七八九十百千〇'

def replace_combined(match):
    eng_numeral, eng_title, eng_def, jp_numeral, jp_title, jp_def = match.groups()
    eng_full_title = f"{eng_title.strip()}"
    return f"\n\t- {eng_numeral} {eng_full_title} / {jp_title}\n\t\t- It means {eng_def};\n\t\t- {jp_def}"

def format_sections(md_content):
    # --- '章' (Chapters) ---
    # ┏━━━━━━━━━━━━ From ━━━━━━━━━━━━
    # ┃ 第一章　総則
    # ┃ Chapter I　General Provisions
    # ┃
    #
    # ┏━━━━━━━━━━━━ To ━━━━━━━━━━━━
    # ┃ I - General Provisions / 総則
    # ┃

    # 日本語版
    # md_content = re.sub(r"(\n|^)(第[\w]+章|Chapter\s+\w+)", r"\n# \2", md_content)
    # 英語版
    pattern = (
        r"^Chapter[\s　]([IVXLCDM]+)[\s　](.+?)\n"  # \1, \2
        r"第[一二三四五六七八九十百千〇]+章[\s　]+(.+)"  # \3
    )

    replacement = r"# \1 - \2 / \3"

    md_content = re.sub(pattern, replacement, md_content, flags=re.MULTILINE)


    # For '節' (Sections)
    # ┏━━━━━━━━━━━━ From ━━━━━━━━━━━━
    # ┃ Section 1 General Rules
    # ┃ 第一節　通則
    # ┃
    #
    # ┏━━━━━━━━━━━━ To ━━━━━━━━━━━━
    # ┃ ## 1 - General Rules / 通則
    # ┃

    # 日本語版
    # md_content = re.sub(r"(\n|^)(第[\w]+節)", r"\n## \2", md_content)
    # 英語版
    pattern = (
        r"^Section[\s　]([0-9]+)\s+(.+?)\n"  # \1, \2
        rf"第[{kanji_numbers}]+節[\s　]+(.+)"  # \3
    )

    replacement = r"## \1 - \2 / \3"

    md_content = re.sub(pattern, replacement, md_content, flags=re.MULTILINE)

    # For '条' (Articles)
    # ┏━━━━━━━━━━━━ From ━━━━━━━━━━━━
    # ┃ （目的）
    # ┃ (Purpose)
    # ┃ 第一条　この法律は、著作物並びに実演、レコード、放送及び有線放送に関し...
    # ┃ Article 1  The purpose of this Act is to provide for authors' rights...
    # ┃
    #
    # ┏━━━━━━━━━━━━ To ━━━━━━━━━━━━
    # ┃ ### Article 1: Purpose / 目的
    # ┃ - The purpose of this Act is to provide for authors' rights...

    # 日本語版?
    # md_content = re.sub(r"（(.*?)）\s*\n\n(第[\w\d之]+条(?:の[\w\d之]+)*)\s", r"\2 （\1）\n", md_content)

    # 英語版
    pattern_article = (
        r'\((.*?)\)\n'  # \1
        r'（(.*?)）\n'  # \2
        # 否定先読み (?!\(\d+\)) により、Article 19 (1) を除外する場合も考えられたが、期待するToのためには必要ない
        r'Article[\s　]([0-9]+(?:-\d+)?)[\s　](.+)\n'  # \3, \4
        rf'(第[{kanji_numbers}]+条(?:の[{kanji_numbers}]+)?)\s+(.+)'  # \5, \6
    )

    replacement_pattern = (
        r'### \3: \1 / \2\n'
        r'- \4\n'
        r'- \6'
    )

    md_content = re.sub(pattern_article, replacement_pattern, md_content)



    # FIXME: These expression of '項', '号', '目'
    # For '項' (Paragraphs) and '号' (Items) and '目' (Items)
    # ┏━━━━━━━━━━━━ From ━━━━━━━━━━━━
    # ┃ (i) a "work" means a creatively produced expression of...
    # ┃ 一　著作物　思想又は感情を創作的に表現したものであつて、...
    # ┃   〜〜〜〜〜〜〜〜〜〜
    # ┃ (vii)-2 making a "transmission to the public" means making a transmission of...
    # ┃ 七の二　公衆送信　公衆によつて直接受信されることを目的として...
    # ┃
    #
    # ┏━━━━━━━━━━━━ To ━━━━━━━━━━━━
    # ┃ 	- (i) a "work" / 著作物
    # ┃ 		- It means a creatively produced expression of...
    # ┃ 		- 思想又は感情を創作的に表現したものであつて、...
    # ┃   〜〜〜〜〜〜〜〜〜〜
    # ┃ 	- (vii)-2 making a "transmission to the public" means making a transmission of...
    # ┃ 		- 七の二　公衆送信　公衆によつて直接受信されることを目的として...
    # ┃
    #

    # 日本語版
    # md_content = re.sub(r"(\n|^)([一二三四五六七八九十]+(?:の[一二三四五六七八九十]+)?)\s(.*?)", r"\1- \2 \3\n\t- ", md_content)
    # 英語版
    combined_pattern = (
        r"(?P<eng_numeral>\([ivx]+\)(?:-\d+)?\s)"  # Matches English numeral in parentheses (e.g., (iv))
        r"(?P<eng_title>.*?\".*?\".*?) "  # Matches English title, particularly catching quoted phrases
        r"means "  # Literal string "means"
        r"(?P<eng_def>.*?)\n"  # Matches English definition
        r"(?P<jp_numeral>[一二三四五六七八九十]+(?:の[一二三四五六七八九十]+)?)\s"  # Matches Japanese numeral
        r"(?P<jp_title>.+?)　"  # Matches Japanese title
        r"(?P<jp_def>.+)"  # Matches Japanese definition
    )

    md_content = re.sub(combined_pattern, replace_combined, md_content, flags=re.MULTILINE)





    # For イロハ
    # ┏━━━━━━━━━━━━ From ━━━━━━━━━━━━
    # ┃ イ　放送番組の放送又は有線放送番組の有線放送が行われた日から一週間以内...
    # ┃ (a) the automatic public transmission is made within one week from the day...
    # ┃ ロ　放送番組又は有線放送番組の内容を変更しないで行われるもの
    # ┃ (b) the automatic public transmission is made without changing the content of...
    # ┃ ハ　当該自動公衆送信を受信して行う...
    # ┃ (c) the automatic public transmission is subject to...
    # ┃

    # ┏━━━━━━━━━━━━ To ━━━━━━━━━━━━
    # ┃ (a) the automatic public transmission is made within one week from the day...
    # ┃ - The purpose of this Act is to provide for authors' rights...

    pattern_iroha = (
        r"(\([a-z]\))[\s　]+(.+)\n"
        r"[イロハニホヘトチリヌルヲ][\s　]+(.+)"
    )

    replacement_pattern = (
        r"\t\t\t- <span style='font-size: small;'>\1</span>\n"
        r"\t\t\t\t- <span style='font-size: small;'>\2</span>\n"
        r"\t\t\t\t- <span style='font-size: small;'>\3</span>"
    )

    md_content = re.sub(pattern_iroha, replacement_pattern, md_content)


    # For 123
    # ┏━━━━━━━━━━━━ From ━━━━━━━━━━━━
    # ┃ (2) Unless the author has manifested a different intention...
    # ┃ ２　著作物を利用する者は、その著作者の別段の意思表示がない限り...
    # ┃

    # ┏━━━━━━━━━━━━ To ━━━━━━━━━━━━
    # ┃

    pattern_123 = (
        r"(\([0-9]+\))[\s　]+(.+)\n"
        r"[１２３４５６７８９０]+[\s　]+(.+)"
    )

    replacement_pattern = (
        r"\t\t\t- \1\n"
        r"\t\t\t\t- \2\n"
        r"\t\t\t\t- \3"
    )

    md_content = re.sub(pattern_123, replacement_pattern, md_content)



    # For 一二三
    # ┏━━━━━━━━━━━━ From ━━━━━━━━━━━━
    # ┃ (iii) the work is received via an automatic public transmission that infringes on a copyright (including an automatic public transmission that is transmitted abroad and that would constitute copyright infringement if it were transmitted in Japan), and the user records the sounds or visuals of the work in digital format (hereinafter referred to as "specified infringing sound or visual recording" in this item and the following paragraph), in knowledge of the fact that the relevant action constitutes the specified infringing sound or visual recording;
    # ┃ 三　著作権を侵害する自動公衆送信（国外で行われる自動公衆送信であつて、国内で行われたとしたならば著作権の侵害となるべきものを含む。）を受信して行うデジタル方式の録音又は録画（以下この号及び次項において「特定侵害録音録画」という。）を、特定侵害録音録画であることを知りながら行う場合
    # ┃

    # ┏━━━━━━━━━━━━ To ━━━━━━━━━━━━
    # ┃

    pattern_123 = (
        r"(\([ivx]+\))[\s　]+(.+)\n"
        rf"[{kanji_numbers}]+[\s　]+(.+)"
    )

    replacement_pattern = (
        r"\t- \1\n"
        r"\t\t- \2\n"
        r"\t\t- \3"
    )

    md_content = re.sub(pattern_123, replacement_pattern, md_content)


    # For 123-ja, (1)(2)(3)-en
    # ┏━━━━━━━━━━━━ From ━━━━━━━━━━━━
    # ┃ (3) The person that would own a right referred to in either of the preceding two paragraphs if the work were protected under this Act and a person authorized thereby to exploit the work are, respectively, deemed to be the person that owns that right and the person authorized thereby, and the provisions of those paragraphs apply.
    # ┃ ３　著作物がこの法律による保護を受けるとしたならば前二項の権利を有すべき者又はその者からその著作物の利用の承諾を得た者は、それぞれ前二項の権利を有する者又はその許諾を得た者とみなして、前二項の規定を適用する。
    # ┃
    # ┏━━━━━━━━━━━━ To ━━━━━━━━━━━━
    # ┃

    pattern_123 = (
        r"(\([0-9]+\))[\s　]+(.+)\n"
        rf"[１２３４５６７８９０]+[\s　]+(.+)"
    )

    replacement_pattern = (
        r"- \1\n"
        r"\t- \2\n"
        r"\t- \3"
    )

    md_content = re.sub(pattern_123, replacement_pattern, md_content)



    return md_content


