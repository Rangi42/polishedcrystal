import os
import re

BASE_DIR = "data/pokemon/base_stats"

STAT_LINE_RE = re.compile(
    r'^\s*db\s+(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)',
    re.MULTILINE
)

FAITHFUL_BLOCK_RE = re.compile(
    r'if\s+DEF\s*\(\s*FAITHFUL\s*\)\s*.*?'
    r'else\s*(.*?)\s*endc',
    re.IGNORECASE | re.DOTALL
)

def preprocess_asm(text: str) -> str:
    """
    Emulate RGBDS behavior:
    - Remove FAITHFUL branches
    - Keep ELSE content
    """
    while True:
        m = FAITHFUL_BLOCK_RE.search(text)
        if not m:
            break
        text = text[:m.start()] + m.group(1) + text[m.end():]
    return text

rows = []
errors = []

for fname in sorted(os.listdir(BASE_DIR)):
    if not fname.endswith(".asm"):
        continue

    mon = fname[:-4]

    with open(os.path.join(BASE_DIR, fname), encoding="utf-8") as f:
        text = f.read()

    text = preprocess_asm(text)

    m = STAT_LINE_RE.search(text)
    if not m:
        errors.append(mon)
        continue

    hp, atk, df, spe, spa, spd = map(int, m.groups())
    bst = hp + atk + df + spe + spa + spd

    rows.append((mon, hp, atk, df, spe, spa, spd, bst))

# ---- terminal output ----

print(f"{'Pokemon':20} {'HP':>3} {'Atk':>3} {'Def':>3} {'Spe':>3} {'SpA':>3} {'SpD':>3} {'BST':>4}")
print("-" * 60)

for r in rows:
    print(f"{r[0]:20} {r[1]:3} {r[2]:3} {r[3]:3} {r[4]:3} {r[5]:3} {r[6]:3} {r[7]:4}")

print(f"\n[OK] Printed {len(rows)} Pokémon")

if errors:
    print("[WARN] Missing stat blocks for:")
    for e in errors:
        print(" -", e)
