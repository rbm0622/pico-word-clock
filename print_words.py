"""
Print available word keys from `words.py`.

Run this on the Pico (or host) to verify which word keys are present.
"""
from words import WORDS

def main():
    try:
        keys = sorted(WORDS.keys())
    except Exception:
        print('Unable to read WORDS from words.py')
        return

    print('Available words:')
    for k in keys:
        print(' -', k)


if __name__ == '__main__':
    main()
