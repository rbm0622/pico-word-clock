"""
Sample demo wrapper that ensures project root is on sys.path
so `import spell_word` works even when running from the `samples/` directory.
"""
import sys
import time

# Avoid using os.path (not available on some MicroPython builds).
# Compute project root (parent of this samples/ dir) using simple string ops.
HERE = globals().get('__file__', '')
if not HERE:
    # fallback: script name from argv or current directory
    HERE = sys.argv[0] if len(sys.argv) > 0 else ''

if HERE:
    if '/' in HERE:
        samples_dir = HERE.rsplit('/', 1)[0]
    elif '\\' in HERE:
        samples_dir = HERE.rsplit('\\', 1)[0]
    else:
        samples_dir = '.'

    if '/' in samples_dir:
        ROOT = samples_dir.rsplit('/', 1)[0]
    elif '\\' in samples_dir:
        ROOT = samples_dir.rsplit('\\', 1)[0]
    else:
        ROOT = '..'
else:
    ROOT = '..'

if ROOT not in sys.path:
    sys.path.insert(0, ROOT)

import spell_word


def demo_cumulative():
#    print('Demo: cumulative green, 0.3s per letter, hold 3s')
    spell_word.main(['--word', 'MENDELSOHN', '--mode', 'individual', '--color', '0,0,255', '--cumulative', '--letter-delay', '0.5', '--final-hold', '3'])


if __name__ == '__main__':
    try:
        demo_cumulative()
    except KeyboardInterrupt:
        print('Interrupted')
