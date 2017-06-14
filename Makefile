NAME := polishedcrystal
VERSION := 2.2.0

TITLE := PKPCRYSTAL
MCODE := PKPC
ROMVERSION := 0x30

FILLER = 0x00

RGBASM_FLAGS =
RGBLINK_FLAGS = -n $(ROM_NAME).sym -m $(ROM_NAME).map -l linkerscript.link -p $(FILLER)
RGBFIX_FLAGS = -Cjv -t $(TITLE) -i $(MCODE) -n $(ROMVERSION) -p $(FILLER) -k 01 -l 0x33 -m 0x10 -r 3


.SUFFIXES:
.PHONY: all clean crystal faithful nortc faithful-nortc bankfree debug
.SECONDEXPANSION:
.PRECIOUS: %.2bpp %.1bpp


PYTHON = python
RM = rm -f

gfx       := $(PYTHON) gfx.py
includes  := $(PYTHON) utils/scan_includes.py
bank_ends := $(PYTHON) contents/bank_ends.py


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


all: crystal bankfree

crystal: FILLER = 0x00
crystal: ROM_NAME = $(NAME)-$(VERSION)
crystal: $(NAME)-$(VERSION).gbc

faithful: RGBASM_FLAGS += -DFAITHFUL
faithful: ROM_NAME = $(NAME)-faithful-$(VERSION)
faithful: $(NAME)-faithful-$(VERSION).gbc

nortc: RGBASM_FLAGS += -DNO_RTC
nortc: ROM_NAME = $(NAME)-nortc-$(VERSION)
nortc: $(NAME)-nortc-$(VERSION).gbc

faithful-nortc: RGBASM_FLAGS += -DFAITHFUL -DNO_RTC
faithful-nortc: ROM_NAME = $(NAME)-faithful-nortc-$(VERSION)
faithful-nortc: $(NAME)-faithful-nortc-$(VERSION).gbc

bankfree: FILLER = 0xff
bankfree: ROM_NAME = $(NAME)-$(VERSION)-0xff
bankfree: $(NAME)-$(VERSION)-0xff.gbc

debug: RGBASM_FLAGS += -DDEBUG
debug: ROM_NAME = $(NAME)-$(VERSION)
debug: $(NAME)-$(VERSION).gbc

clean:
	$(RM) $(crystal_obj) $(wildcard $(NAME)-*.gbc) $(wildcard $(NAME)-*.map) $(wildcard $(NAME)-*.sym)


%.asm: ;

%.o: dep = $(shell $(includes) $(@D)/$*.asm)
%.o: %.asm $$(dep)
	rgbasm $(RGBASM_FLAGS) -o $@ $<

.gbc:
%.gbc: $(crystal_obj)
	rgblink $(RGBLINK_FLAGS) -o $@ $^
	rgbfix $(RGBFIX_FLAGS) $@

%.png: ;
%.2bpp: %.png ; $(gfx) 2bpp $<
%.1bpp: %.png ; $(gfx) 1bpp $<
%.lz: % ; $(gfx) lz $<
contents/bank_ends.txt: crystal bankfree ; $(bank_ends) > $@ ; rm $(NAME)-$(VERSION)-0xff.gbc

%.pal: %.2bpp ;
gfx/pics/%/normal.pal gfx/pics/%/bitmask.asm gfx/pics/%/frames.asm: gfx/pics/%/front.2bpp ;
%.bin: ;
%.blk: ;
%.tilemap: ;
