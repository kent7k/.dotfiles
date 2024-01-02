from .markdown_modification import format_sections
from .switch_even_odd_lines import switch_even_odd_lines
from .delete_index import delete_index
from .replace_with_uwatsuki import replace_pattern_uwatsuki, replace_half_width_pattern_exclude_short
from .replace_terms import replace_terms
from .kanji_converter import replace_kanji_numerals
from .convert_era_to_gregorian import convert_era_to_gregorian
from .convert_dates_and_times import replace_dates_and_times


def convert_to_md(md_content):

    # 前処理
    md_content = switch_even_odd_lines(md_content)
    md_content = delete_index(md_content)

    # 後処理
    md_content = format_sections(md_content)


    # 上付き処理
    md_content = replace_pattern_uwatsuki(md_content)
    md_content = replace_half_width_pattern_exclude_short(md_content)

    # 特殊見出し
    #     special_headings = ['制定文', '目次', '本則', '附則']
    #     for heading in special_headings:
    #         md_content = re.sub(rf"^\s*#{heading}", rf"# **{heading}**", md_content, flags=re.MULTILINE)
    #

    # 漢数字
    md_content = replace_kanji_numerals(md_content)
    md_content = convert_era_to_gregorian(md_content)
    md_content = replace_dates_and_times(md_content)

    # Applying the replace_terms function
    md_content = replace_terms(md_content)

    return md_content



