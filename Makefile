NAME = polishedcrystal
VERSION = 2.2.0

TITLE = PKPCRYSTAL
MCODE = PKPC
ROMVERSION = 0x30
FILLER = 0x00
ALTFILLER = 0xff

ROM_NORMAL = $(NAME)-$(VERSION)
ROM_FAITHFUL = $(NAME)-faithful-$(VERSION)
ROM_NORTC = $(NAME)-nortc-$(VERSION)
ROM_FAITHFUL_NORTC = $(NAME)-faithful-nortc-$(VERSION)
ROM_BANKFREE = $(ROM_NORMAL)-$(ALTFILLER)

RGBASM_OPTIONS =
RGBFIX_OPTIONS = -Cjv -t $(TITLE) -i $(MCODE) -n $(ROMVERSION) -k 01 -l 0x33 -m 0x10 -r 3

LINKERSCRIPT = linkerscript.link

.SUFFIXES:
.PHONY: all clean crystal faithful nortc faithful-nortc bankfree debug
.SECONDEXPANSION:
.PRECIOUS: %.2bpp %.1bpp

gfx      := python gfx.py
includes := python utils/scan_includes.py


crystal_obj := \
wram.o \
main.o \
home.o \
audio.o \
maps.o \
engine/events.o \
engine/credits.o \
data/egg_moves.o \
data/evos_attacks.o \
data/pokedex/entries.o \
text/common_text.o \
gfx/pics.o


roms := $(ROM_NORMAL).gbc $(ROM_FAITHFUL).gbc $(ROM_NORTC).gbc $(ROM_FAITHFUL_NORTC).gbc $(ROM_BANKFREE).gbc

all: crystal faithful
crystal: $(ROM_NORMAL).gbc
faithful: RGBASM_OPTIONS += -DFAITHFUL
faithful: $(ROM_FAITHFUL).gbc
nortc: RGBASM_OPTIONS += -DNO_RTC
nortc: $(ROM_NORTC).gbc
faithful-nortc: RGBASM_OPTIONS += -DFAITHFUL -DNO_RTC
faithful-nortc: $(ROM_FAITHFUL_NORTC).gbc
bankfree: $(ROM_BANKFREE).gbc
debug: RGBASM_OPTIONS += -DDEBUG
debug: $(ROM_NORMAL).gbc

clean:
	rm -f $(roms) $(crystal_obj) $(roms:.gbc=.map) $(roms:.gbc=.sym)

%.asm: ;

%.o: dep = $(shell $(includes) $(@D)/$*.asm)
%.o: %.asm $$(dep)
	rgbasm $(RGBASM_OPTIONS) -o $@ $<

$(ROM_NORMAL).gbc: $(crystal_obj)
	rgblink -n $(ROM_NORMAL).sym -m $(ROM_NORMAL).map -l $(LINKERSCRIPT) -p $(FILLER) -o $@ $^
	rgbfix $(RGBFIX_OPTIONS) -p $(FILLER) $@

$(ROM_FAITHFUL).gbc: $(crystal_obj)
	rgblink -n $(ROM_FAITHFUL).sym -m $(ROM_FAITHFUL).map -l $(LINKERSCRIPT) -p $(FILLER) -o $@ $^
	rgbfix $(RGBFIX_OPTIONS) -p $(FILLER) $@

$(ROM_NORTC).gbc: $(crystal_obj)
	rgblink -n $(ROM_NORTC).sym -m $(ROM_NORTC).map -l $(LINKERSCRIPT) -p $(FILLER) -o $@ $^
	rgbfix $(RGBFIX_OPTIONS) -p $(FILLER) $@

$(ROM_FAITHFUL_NORTC).gbc: $(crystal_obj)
	rgblink -n $(ROM_FAITHFUL_NORTC).sym -m $(ROM_FAITHFUL_NORTC).map -l $(LINKERSCRIPT) -p $(FILLER) -o $@ $^
	rgbfix $(RGBFIX_OPTIONS) -p $(FILLER) $@

$(ROM_BANKFREE).gbc: $(crystal_obj)
	rgblink -n $(ROM_BANKFREE).sym -m $(ROM_BANKFREE).map -l $(LINKERSCRIPT) -p $(ALTFILLER) -o $@ $^
	rgbfix $(RGBFIX_OPTIONS) -p $(ALTFILLER) $@

%.png: ;
%.2bpp: %.png ; $(gfx) 2bpp $<
%.1bpp: %.png ; $(gfx) 1bpp $<
%.lz: % ; $(gfx) lz $<

%.pal: %.2bpp ;
gfx/pics/%/normal.pal gfx/pics/%/bitmask.asm gfx/pics/%/frames.asm: gfx/pics/%/front.2bpp ;
%.bin: ;
%.blk: ;
%.tilemap: ;
