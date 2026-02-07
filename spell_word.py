"""
Script to light any word defined in `words.py`.

Usage examples:
  python3 spell_word.py --word MENDELSOHN --mode individual --color "255,0,0" -d 0.4 -f 4 --cumulative
  python3 spell_word.py -w "MENDELSOHN" --mode all --color "#00FF00" -f 5

Options:
  --word / -w        Word key from `words.py` (case-insensitive)
  --mode             'all' (light whole word at once) or 'individual' (light each coord sequentially). Default 'all'
  --color / -c       Color as '#RRGGBB' or 'R,G,B' (applies to all letters)
  --start-color      Gradient start color (used with --end-color)
  --end-color        Gradient end color
  --letter-delay / -d  Delay between letters when in 'individual' mode (default 0.5)
  --final-hold / -f  Seconds to hold final state (default 5)
  --cumulative       When in 'individual' mode, keep previously lit letters lit

This script uses the `WORDS` mapping in `words.py` and the helpers in `display.py`.
"""

import sys
import time
from words import WORDS
import display


def _parse_color(s):
    if not s:
        return None
    s = s.strip()
    if s.startswith('#') and len(s) == 7:
        try:
            r = int(s[1:3], 16)
            g = int(s[3:5], 16)
            b = int(s[5:7], 16)
            return (r, g, b)
        except Exception:
            return None
    parts = s.split(',')
    if len(parts) == 3:
        try:
            return tuple(int(p) for p in parts)
        except Exception:
            return None
    return None


def _interpolate_colors(start, end, steps):
    if steps <= 1:
        return [start]
    colors = []
    for i in range(steps):
        t = i / float(steps - 1)
        r = round(start[0] + (end[0] - start[0]) * t)
        g = round(start[1] + (end[1] - start[1]) * t)
        b = round(start[2] + (end[2] - start[2]) * t)
        colors.append((r, g, b))
    return colors


def usage():
    print(__doc__)


def find_coords_for_word(word):
    if not word:
        return None

    def _normalize(s):
        return ''.join(ch for ch in s.upper() if ch.isalnum())

    key_raw = word.strip()
    # try common transformations first
    candidates = [
        key_raw,
        key_raw.upper(),
        key_raw.upper().replace(' ', '_'),
        key_raw.upper().replace(' ', ''),
        key_raw.upper().replace('-', '_'),
        key_raw.upper().replace('-', ''),
    ]

    for k in candidates:
        if k in WORDS:
            return WORDS[k]

    # fallback: normalized comparison (ignore underscores/spaces/non-alnum)
    target = _normalize(key_raw)
    for k in WORDS.keys():
        if _normalize(k) == target:
            return WORDS[k]

    # no match: print available keys for debugging
    try:
        available = ', '.join(sorted(WORDS.keys()))
    except Exception:
        available = '<unavailable>'
    print("Available words:\n{}".format(available))
    return None


def main(argv=None):
    if argv is None:
        argv = sys.argv[1:]

    # defaults
    word = None
    mode = 'all'
    color = None
    start_color = None
    end_color = None
    letter_delay = 0.5
    final_hold = 5
    cumulative = False

    i = 0
    while i < len(argv):
        a = argv[i]
        if a in ('--word', '-w') and i + 1 < len(argv):
            word = argv[i + 1]
            i += 2
        elif a == '--mode' and i + 1 < len(argv):
            mode = argv[i + 1]
            i += 2
        elif a in ('--color', '-c') and i + 1 < len(argv):
            color = _parse_color(argv[i + 1])
            i += 2
        elif a == '--start-color' and i + 1 < len(argv):
            start_color = _parse_color(argv[i + 1])
            i += 2
        elif a == '--end-color' and i + 1 < len(argv):
            end_color = _parse_color(argv[i + 1])
            i += 2
        elif a in ('--letter-delay', '-d') and i + 1 < len(argv):
            try:
                letter_delay = float(argv[i + 1])
            except Exception:
                pass
            i += 2
        elif a in ('--final-hold', '-f') and i + 1 < len(argv):
            try:
                final_hold = float(argv[i + 1])
            except Exception:
                pass
            i += 2
        elif a == '--cumulative':
            cumulative = True
            i += 1
        elif a in ('--help', '-h'):
            usage()
            return
        else:
            i += 1

    if not word:
        print('No --word provided')
        usage()
        return

    coords = find_coords_for_word(word)
    if not coords:
        print("Word '{}' not found in words.py".format(word))
        return

    n = len(coords)
    if start_color and end_color:
        colors = _interpolate_colors(start_color, end_color, n)
    elif color:
        colors = [color] * n
    else:
        colors = [(255, 255, 255)] * n

    # Ensure strip is cleared first
    display.clear()
    display.show()

    if mode == 'all':
        # light all coords at once (single color or per-letter colors applied in order)
        # If multiple colors provided, set each LED accordingly
        display.clear()
        for idx, (r, c) in enumerate(coords):
            display.strip.set_pixel(display.rc_to_index(r, c), colors[idx])
        display.show()
        try:
            time.sleep(final_hold)
        except KeyboardInterrupt:
            pass
    else:
        # individual mode: light each coord sequentially
        lit_coords = []
        for idx, (r, c) in enumerate(coords):
            if cumulative:
                # keep previously lit
                display.strip.set_pixel(display.rc_to_index(r, c), colors[idx])
            else:
                display.clear()
                display.strip.set_pixel(display.rc_to_index(r, c), colors[idx])

            display.show()
            try:
                time.sleep(letter_delay)
            except KeyboardInterrupt:
                break

        # final hold with all lit
        display.clear()
        for idx, (r, c) in enumerate(coords):
            display.strip.set_pixel(display.rc_to_index(r, c), colors[idx])
        display.show()
        try:
            time.sleep(final_hold)
        except KeyboardInterrupt:
            pass

    # clear at end
    display.clear()
    display.show()


if __name__ == '__main__':
    main()
