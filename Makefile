PYTHON := python
MD5 := md5sum -c --quiet

VERSION = 2.2.0
NAME = polishedcrystal-$(VERSION)
FNAME = polishedcrystal-faithful-$(VERSION)
OPTIONS =

TITLE = PKPCRYSTAL
MCODE = PKPC
ROMVERSION = 0x30
FILLER = 0x00
ALTFILLER = 0xff

.SUFFIXES:
.PHONY: all clean crystal faithful bankfree debug
.SECONDEXPANSION:
.PRECIOUS: %.2bpp %.1bpp

gfx       := $(PYTHON) gfx.py
includes  := $(PYTHON) utils/scan_includes.py


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


roms := $(NAME).gbc $(FNAME).gbc $(NAME)-$(ALTFILLER).gbc

all: crystal faithful
crystal: $(NAME).gbc
faithful: OPTIONS += -DFAITHFUL
faithful: $(FNAME).gbc
bankfree: $(NAME)-$(ALTFILLER).gbc
debug: OPTIONS += -DDEBUG
debug: $(NAME).gbc

clean:
	rm -f $(roms) $(crystal_obj) $(roms:.gbc=.map) $(roms:.gbc=.sym)

%.asm: ;

%.o: dep = $(shell $(includes) $(@D)/$*.asm)
%.o: %.asm $$(dep)
	rgbasm $(OPTIONS) -o $@ $<

$(NAME).gbc: $(crystal_obj)
	rgblink -n $(NAME).sym -m $(NAME).map -p $(FILLER) -o $@ $^
	rgbfix -Cjv -t $(TITLE) -i $(MCODE) -n $(ROMVERSION) -p $(FILLER) -k 01 -l 0x33 -m 0x10 -r 3 $@

$(FNAME).gbc: $(crystal_obj)
	rgblink -n $(FNAME).sym -m $(FNAME).map -p $(FILLER) -o $@ $^
	rgbfix -Cjv -t $(TITLE) -i $(MCODE) -n $(ROMVERSION) -p $(FILLER) -k 01 -l 0x33 -m 0x10 -r 3 $@

$(NAME)-$(ALTFILLER).gbc: $(crystal_obj)
	rgblink -n $(NAME)-$(ALTFILLER).sym -m $(NAME)-$(ALTFILLER).map -p $(ALTFILLER) -o $@ $^
	rgbfix -Cjv -t $(TITLE) -i $(MCODE) -n $(ROMVERSION) -p $(FILLER) -k 01 -l 0x33 -m 0x10 -r 3 $@

%.png: ;
%.2bpp: %.png ; $(gfx) 2bpp $<
%.1bpp: %.png ; $(gfx) 1bpp $<
%.lz: % ; $(gfx) lz $<

%.pal: %.2bpp ;
gfx/pics/%/normal.pal gfx/pics/%/bitmask.asm gfx/pics/%/frames.asm: gfx/pics/%/front.2bpp ;
%.bin: ;
%.blk: ;
%.tilemap: ;
