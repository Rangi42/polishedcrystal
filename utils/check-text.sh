#!/bin/sh
# Run from the project root. Pass --vibe with vibeEmu checked out at ../vibeEmu.
set -eu
case "$#:${1-}" in
	0:|1:--vibe) ;;
	*) echo "Usage: $0 [--vibe]" >&2; exit 2 ;;
esac

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
make crystal ROM_NAME="$tmp/reference"

# Reassemble every ROM object with corpus output and record labels. Keep this
# build separate so it can be compared byte for byte with the regular build.
cat > "$tmp/check.mk" <<'MAKE'
include Makefile
$(tmp)/%.o: %.asm
	@mkdir -p $(@D)
	$(RGBASM) $(RGBASMFLAGS) -DHUFFMAN -o $@ $< > $@.corpus
$(tmp)/checked.gbc: $(addprefix $(tmp)/,$(rom_obj))
	$(RGBLINK) $(RGBLINKFLAGS) -l layout.link -o $@ $^
	$(RGBFIX) $(RGBFIXFLAGS) $@
	cat $(addsuffix .corpus,$^) > $(tmp)/corpus
MAKE
make -f "$tmp/check.mk" tmp="$tmp" ROM_NAME="$tmp/game" "$tmp/checked.gbc"
cmp "$tmp/reference.gbc" "$tmp/checked.gbc"

mode=${1-}
set -- "$tmp/checked.gbc" "$tmp/game.sym" "$tmp/corpus"
python3 utils/verify_huffman.py "$@"
if [ "$mode" = --vibe ]; then
	cargo run --quiet --release --manifest-path utils/text_vibe/Cargo.toml -- "$@"
fi
