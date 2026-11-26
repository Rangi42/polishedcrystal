#!/bin/sh
# Run from the project root. Pass --vibe to also run the Game Boy reader.
set -eu
case "$#:${1-}" in
	0:|1:--vibe) ;;
	*) echo "Usage: $0 [--vibe]" >&2; exit 2 ;;
esac

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# Link the default objects twice, substituting only the map object on the
# second link. The extra symbols and corpus output must not change the ROM.
make crystal ROM_NAME="$tmp/reference"
{
	echo 'DEF PAIR_TEXT_CORPUS EQU 1'
	cat data/maps/map_data.asm
} > "$tmp/maps.asm"
make -s crystal ROM_NAME="$tmp/game" \
	"crystal_obj=\$(subst data/maps/map_data.o,$tmp/maps.o,\$(rom_obj))" > "$tmp/corpus"
cmp "$tmp/reference.gbc" "$tmp/game.gbc"

mode=${1-}
set -- "$tmp/game.gbc" "$tmp/game.sym" "$tmp/corpus"
python3 utils/verify_map_text.py "$@"
if [ "$mode" = --vibe ]; then
	cargo run --quiet --release --manifest-path utils/map_text_vibe/Cargo.toml -- "$@"
fi
