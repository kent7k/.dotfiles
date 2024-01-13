def switch_even_odd_lines(input_text):
    # Splitting the input text into lines
    lines = input_text.strip().split('\n')

    # Check if the number of lines is odd
    if len(lines) % 2 != 0:
        # If it's odd, remove the last line and keep it for appending later
        last_line = lines.pop()
    else:
        last_line = None

    # Switching even and odd lines
    switched_lines = []
    for i in range(0, len(lines), 2):
        switched_lines.append(lines[i + 1])
        switched_lines.append(lines[i])

    # Append the last line if it was removed
    if last_line:
        switched_lines.append(last_line)

    # Joining the lines back into a string
    return '\n'.join(switched_lines)
