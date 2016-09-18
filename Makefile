PYTHON := python
MD5 := md5sum -c --quiet

NAME = polishedcrystal-2.1.0
FNAME = polishedcrystal-faithful-2.1.0
FAITHFUL =


.SUFFIXES:
.PHONY: all clean crystal
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


roms := $(NAME).gbc $(FNAME).gbc

all: crystal
crystal: $(NAME).gbc
faithful: FAITHFUL += -DFAITHFUL
faithful: $(FNAME).gbc

clean:
	rm -f $(roms) $(crystal_obj) $(roms:.gbc=.map) $(roms:.gbc=.sym)

%.asm: ;

%.o: dep = $(shell $(includes) $(@D)/$*.asm)
%.o: %.asm $$(dep)
	rgbasm $(FAITHFUL) -o $@ $<

$(NAME).gbc: $(crystal_obj)
	rgblink -n $(NAME).sym -m $(NAME).map -o $@ $^
	rgbfix -Cjv -t PKPCRYSTAL -i PKPC -k 01 -l 0x33 -m 0x10 -n 1 -p 0 -r 3 $@

$(FNAME).gbc: $(crystal_obj)
	rgblink -n $(FNAME).sym -m $(FNAME).map -o $@ $^
	rgbfix -Cjv -t PKPCRYSTAL -i PKPC -k 01 -l 0x33 -m 0x10 -n 1 -p 0 -r 3 $@

%.png: ;
%.2bpp: %.png ; $(gfx) 2bpp $<
%.1bpp: %.png ; $(gfx) 1bpp $<
%.lz: % ; $(gfx) lz $<

%.pal: %.2bpp ;
gfx/pics/%/normal.pal gfx/pics/%/bitmask.asm gfx/pics/%/frames.asm: gfx/pics/%/front.2bpp ;
%.bin: ;
%.blk: ;
%.tilemap: ;
