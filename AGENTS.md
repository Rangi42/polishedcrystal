# AGENTS.md — Polished Crystal

## Project Overview

Pokémon Polished Crystal is a ROM hack of Pokémon Crystal built on the [pret/pokecrystal](https://github.com/pret/pokecrystal) disassembly. The entire codebase is **Game Boy assembly** (SM83), assembled with [RGBDS](https://rgbds.gbdev.io/). Supporting tools are written in **C** and **Python 3**. The target output is a `.gbc` ROM file.

Last Released version: **3.2.3**. RGBDS version required: **1.0.1**.

## Build Instructions

### Prerequisites

- **RGBDS** (`rgbasm`, `rgblink`, `rgbfix`, `rgbgfx`) — install system-wide or place binaries in a `rgbds/` directory at the repo root.
- **GCC**, **make**, **bison**, **git**, **libpng-dev** (for building C tools in `tools/`).
- **Python 3** (for utility scripts in `utils/`).

### Building

```bash
# Default build (polishedcrystal-3.2.3.gbc):
make -j$(nproc)

# Build variants (combine as needed):
make faithful          # Faithful variant (omits non-canon changes)
make debug             # Debug build with extra debug features
make faithful debug    # Faithful + debug
make hgss              # HGSS sprite style
make monochrome        # Monochrome palette
make noir              # Noir palette (cannot combine with monochrome or hgss)

# Virtual Console patch:
make vc

# Analogue Pocket build:
make pocket

# Build the C tools only:
make tools

# Clean intermediate objects (keep gfx assets):
make tidy

# Full clean (remove all generated files):
make clean
```

The Makefile auto-builds C tools in `tools/` before assembling.

### CI Workflow

The GitHub Actions CI (`.github/workflows/build.yml`) builds on Ubuntu and produces: default, faithful, vc, faithful-vc, debug, and faithful-debug variants. It installs RGBDS from source, runs `make -j$(nproc)` for each variant, and runs `make tidy` between builds.

## Project Layout

```
.
├── main.asm              # ROM bank layout — INCLUDEs all engine/data into ROMX sections
├── home.asm              # ROM0 home bank — INCLUDEs home/*.asm
├── ram.asm               # RAM definitions — INCLUDEs ram/*.asm (WRAM, SRAM, HRAM, OAM, VRAM)
├── audio.asm             # Audio engine and music/SFX INCLUDEs
├── includes.asm          # Global pre-include: charmap, macros, and all constants
├── layout.link           # Linker script defining ROM/RAM section layout
├── constants/            # All constant definitions (.asm): pokemon, moves, items, types, maps, etc.
├── macros/               # Assembler macros: code, data, gfx, scripts, assertions
├── home/                 # ROM0 routines (always-accessible): math, copy, text, map, menu, etc.
├── engine/               # ROMX engine code: battle, overworld, menus, Pokemon, items, events, etc.
├── data/                 # Data tables: Pokemon stats/moves/evolutions, items, maps, trainers, text, tilesets
├── ram/                  # RAM layout files: wram0.asm, wramx.asm, sram.asm, hram.asm, vram.asm, oam.asm
├── gfx/                  # Graphics source PNGs and generated .1bpp/.2bpp tile data
├── audio/                # Music and SFX data and engine
├── maps/                 # Map scripts, headers, and event data
├── tools/                # C build tools: gfx converter, LZ compressor, bank validator, etc.
├── utils/                # Python utility/analysis scripts (not part of the build)
├── patches/              # IPS patches for distribution
├── bsp/                  # Binary save patcher data
└── docs/                 # Documentation
```

### Key Files for Common Tasks

| Task | Key Files |
|------|-----------|
| Add/modify a Pokémon | `constants/pokemon_constants.asm`, `data/pokemon/` (base_stats, evos_attacks, dex_entries, egg_moves) |
| Add/modify a move | `constants/move_constants.asm`, `data/moves/` |
| Add/modify an item | `constants/item_constants.asm`, `data/items/` |
| Add/modify a map | `constants/map_constants.asm`, `data/maps/`, `maps/` |
| Modify battle engine | `engine/battle/` |
| Modify overworld | `engine/overworld/` |
| Add/modify abilities | `constants/ability_constants.asm`, `data/abilities/` |
| RAM variable layout | `ram/wram0.asm`, `ram/wramx.asm`, `ram/hram.asm`, `ram/sram.asm` |
| Build flags / variants | `includes.asm` (checks `FAITHFUL`, `DEBUG`, `MONOCHROME`, `NOIR`, `HGSS`, `ANALOGUE_POCKET`) |

## Assembly Conventions

### General Style

- The codebase uses **SM83 assembly** syntax for RGBDS (rgbasm).
- Use **tabs** for indentation, **spaces** for alignment. When tabs interfere with alignment, use spaces instead.
- **80-character soft line limit.** Not strictly enforced, but try to keep lines within it.
- Labels start at column 0; instructions are indented one tab.
- Global labels use `PascalCase` (e.g., `LoadMapPart`), local labels use `.camelCase` (e.g., `.loop`).
- RAM labels are prefixed: `w` for WRAM (e.g., `wPlayerName`), `h` for HRAM (e.g., `hROMBank`), `s` for SRAM, `v` for VRAM.
- Constants use `UPPER_SNAKE_CASE`. Hardware registers use an `r` prefix (e.g., `rBGP`).
- **Maximize use of constants — avoid magic numbers.** Always prefer existing definitions from `constants/hardware.inc` (e.g., `rLCDC`, `LCDCF_ON`, `SCREEN_WIDTH`, `SCRN_VX`, `OAMF_XFLIP`, `IEF_VBLANK`) rather than raw hex or decimal literals. Likewise, use project-defined constants from `constants/` for game-specific values (e.g., `NUM_POKEMON`, `PARTY_LENGTH`, `SCREEN_HEIGHT`).
- **Always use the `jmp` macro instead of raw `jp`** (except for `jp hl`). The `jmp` macro wraps `jp` and, in debug builds, emits a warning when the target is within `jr` range — helping catch cases where a shorter relative jump could be used.
- Don't define unused labels when a comment would suffice.

### Comments

- Comments use `;` followed by a space. They should explain *why*, not *what*, where the code isn't self-evident.
- Place comments **above** the code they describe, not inline. Avoid end-of-line comments on instructions.
- Separate comment paragraphs with a blank line (no `;` on blank lines).
- To comment out code, place `;` **before** the tab indent (e.g., `;	nop`), although it is preferred code to be deleted if no longer needed to avoid maintenance of commented out code.

### Directives & Macros

- Meta/high-level directives are **uppercase**: `SECTION`, `INCLUDE`, `INCBIN`, `MACRO`, `ENDM`, `DEF`, `PURGE`.
- Data directives are **lowercase**: `db`, `dw`, `dl`. (Exception: `RGB` is uppercase.)
- Code macros are **lowercase**: `farcall`, `farjp`, `predef`, `jmp`, etc.
- In macros, prefer using `\1, \2, ...` with `rept`/`shift` over deeply nested `shift` calls.

### Conditional Compilation

Build variants use assembler `if DEF(...)` guards:
- `FAITHFUL` — omits non-canon gameplay changes
- `DEBUG` — enables debug menus and tools
- `MONOCHROME` / `NOIR` — grayscale palette modes
- `HGSS` — HGSS-style sprites
- `ANALOGUE_POCKET` — Analogue Pocket target
- `VIRTUAL_CONSOLE` — VC compatibility mode
- `HUFFMAN` — Huffman text compression (internal)

### Code Quality — `utils/optimize.py`

**Always run `utils/optimize.py` on any changed `.asm` files before committing.** This is a static analysis tool that detects dozens of suboptimal Z80 assembly patterns and suggests improvements. Examples:

- Use `xor a` instead of `ld a, 0`
- Use `ldh` for HRAM accesses instead of `ld`
- Use `add a` instead of `sla a` for doubling
- Use `ld [hli]`/`ld [hld]` instead of separate `ld [hl]` + `inc hl`/`dec hl`
- Tail calls: replace `call Foo / ret` with `jp Foo`
- Farcalls: replace `farcall Foo / ret` with `farjp Foo`
- Replace `call Foo / ret / Foo:` patterns with direct fallthroughs
- Use `lb bc, P, Q` instead of separate `ld b, P / ld c, Q`
- Use conditional calls/returns instead of `jr cond, .skip / call|ret / .skip`

Run it targeting specific files or directories:

```bash
python3 utils/optimize.py engine/battle/core.asm
python3 utils/optimize.py home/
python3 utils/optimize.py .    # whole repo (slow)
```

To suppress a false positive on a specific line, add a comment:
```asm
ld c, a ; no-optimize a = N - a (c gets used in .load_loop)
```

The suppress format is `; no-optimize <pattern name>` where the pattern name matches one of the named patterns in the script (e.g., `a = N - a`, `Tail call`, `Redundant loads`, etc.).

## Tools Reference

### Build Tools (`tools/`)

Built automatically by `make`. Written in C (compiled with GCC):

| Tool | Purpose |
|------|---------|
| `bankends` | Reports free ROM space per bank (overflow detection is done by RGBDS) |
| `gfx` | Post-processes tile graphics (dedup, trim whitespace, remove flips) |
| `lzcomp` | LZ compression for graphics data |
| `scan_includes` | Dependency scanner for INCLUDE directives |
| `png_dimensions` | Extracts dimensions from PNG files for animation data |
| `pokemon_animation` / `pokemon_animation_graphics` | Generates animation frame/bitmask data |
| `make_patch` | Generates Virtual Console patches |
| `vwf` | Variable-width font processor |
| `bpp2png` | Converts .1bpp/.2bpp tile data back to PNG |

### Utility Scripts (`utils/`)

Python 3 scripts for analysis and development aid (not part of the build):

| Script | Purpose |
|--------|---------|
| `optimize.py` | **Assembly linter** — detects suboptimal code patterns (see above) |
| `free_space.py` | Analyzes free ROM space per bank |
| `farcheck.py` | Verifies far call correctness |
| `huffman.py` | Huffman text encoding utilities |
| `metatiles.py` | Metatile analysis |
| `treemap.py` | ROM usage treemap visualization |
| `used_space.py` | ROM usage analysis |

## Important Notes

- **ROM bank space is limited.** Each ROMX bank is 16 KB. RGBDS will produce a linker error if a bank overflows. Use `tools/bankends` (run automatically after linking) and `utils/free_space.py` to check remaining free space.
- **The `home/` (ROM0) bank is shared and always accessible** — only small, frequently-called routines belong here. Everything else goes in ROMX banks via `main.asm`.
- **Cross-bank calls require `farcall` — direct `call` only works within the same bank or to ROM0.
- **`hgss`, `monochrome`, and `noir` are mutually exclusive** build modifiers — they cannot be combined.
- **Graphics pipeline:** PNGs → `rgbgfx` → `.1bpp`/`.2bpp` → optional `tools/gfx` post-processing → optional `tools/lzcomp` → `.lzp`. The Makefile handles this automatically.
