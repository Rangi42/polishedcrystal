import os
import re
import csv

BASE_DIR = "data/pokemon/base_stats"
OUTPUT_CSV = "pokemon_active_stats.csv"

# Matches a stat line (6 numbers)
STAT_LINE_RE = re.compile(
    r'^\s*db\s+(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)',
    re.MULTILINE
)

# Matches: if DEF(FAITHFUL) ... else <ACTIVE> endc
FAITHFUL_BLOCK_RE = re.compile(
    r'if\s+DEF\s*\(\s*FAITHFUL\s*\)\s*.*?'
    r'else\s*(.*?)\s*endc',
    re.IGNORECASE | re.DOTALL
)

def preprocess_asm(text: str) -> str:
    """
    Remove FAITHFUL branches, keep ELSE content only.
    Repeat until all FAITHFUL blocks are gone.
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

    # 🔑 emulate RGBDS preprocessing
    text = preprocess_asm(text)

    m = STAT_LINE_RE.search(text)
    if not m:
        errors.append(mon)
        continue

    hp, atk, df, spe, spa, spd = map(int, m.groups())
    bst = hp + atk + df + spe + spa + spd

    rows.append([mon, hp, atk, df, spe, spa, spd, bst])

with open(OUTPUT_CSV, "w", newline="", encoding="utf-8") as f:
    w = csv.writer(f)
    w.writerow(["Pokemon", "HP", "Atk", "Def", "Spe", "SpA", "SpD", "BST"])
    w.writerows(rows)

print(f"[OK] Extracted {len(rows)} Pokémon")
if errors:
    print("[WARN] Missing stats:", ", ".join(errors))
