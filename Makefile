NAME := polishedcrystal
VERSION := 3.0.0-beta

TITLE := PKPCRYSTAL
MCODE := PKPC
ROMVERSION := 0x30

FILLER = 0xff

ifneq ($(wildcard rgbds/.*),)
RGBDS_DIR = rgbds/
else
RGBDS_DIR =
endif

RGBASM_FLAGS = -E -Weverything -Wnumeric-string=2 -Wtruncation=1
RGBLINK_FLAGS = -n $(ROM_NAME).sym -m $(ROM_NAME).map -l layout.link -p $(FILLER)
RGBFIX_FLAGS = -csjv -t $(TITLE) -i $(MCODE) -n $(ROMVERSION) -p $(FILLER) -k 01 -l 0x33 -m 0x10 -r 3

ifeq ($(filter faithful,$(MAKECMDGOALS)),faithful)
RGBASM_FLAGS += -DFAITHFUL
endif
ifeq ($(filter nortc,$(MAKECMDGOALS)),nortc)
RGBASM_FLAGS += -DNO_RTC
endif
ifeq ($(filter monochrome,$(MAKECMDGOALS)),monochrome)
RGBASM_FLAGS += -DMONOCHROME
endif
ifeq ($(filter noir,$(MAKECMDGOALS)),noir)
RGBASM_FLAGS += -DNOIR
endif
ifeq ($(filter hgss,$(MAKECMDGOALS)),hgss)
RGBASM_FLAGS += -DHGSS
endif
ifeq ($(filter debug,$(MAKECMDGOALS)),debug)
RGBASM_FLAGS += -DDEBUG
endif

crystal_obj := \
main.o \
home.o \
ram.o \
audio.o \
audio/music_player.o \
data/pokemon/dex_entries.o \
data/pokemon/egg_moves.o \
data/pokemon/evos_attacks.o \
data/maps/map_data.o \
data/text/common.o \
data/tilesets.o \
engine/movie/credits.o \
engine/overworld/events.o \
gfx/pics.o \
gfx/icons.o \
gfx/sprites.o \
gfx/items.o \
gfx/misc.o


.SUFFIXES:
.PHONY: clean tidy crystal faithful nortc debug monochrome freespace tools bsp
.SECONDEXPANSION:
.PRECIOUS: %.2bpp %.1bpp
.SECONDARY:
.DEFAULT_GOAL: crystal

crystal: ROM_NAME = $(NAME)-$(VERSION)
crystal: $(NAME)-$(VERSION).gbc

faithful: crystal
nortc: crystal
monochrome: crystal
noir: crystal
hgss: crystal
debug: crystal

tools:
	$(MAKE) -C tools/

clean: tidy
	find gfx maps data/tilesets -name '*.lz' -delete
	find gfx \( -name '*.[12]bpp' -o -name '*.2bpp.vram[012]' -o -name '*.2bpp.vram[012]p' \) -delete
	find gfx/pokemon -mindepth 1 \( -name 'bitmask.asm' -o -name 'frames.asm' -o -name 'front.animated.tilemap' -o -name 'front.dimensions' \) -delete
	find data/tilesets -name '*_collision.bin' -delete
	$(MAKE) clean -C tools/

tidy:
	rm -f $(crystal_obj) $(wildcard $(NAME)-*.gbc) $(wildcard $(NAME)-*.map) $(wildcard $(NAME)-*.sym) $(wildcard $(NAME)-*.bsp) rgbdscheck.o

freespace: ROM_NAME = $(NAME)-$(VERSION)
freespace: crystal tools/bankends
	tools/bankends $(ROM_NAME).map > bank_ends.txt

bsp: $(NAME)-$(VERSION).bsp


rgbdscheck.o: rgbdscheck.asm
	$(RGBDS_DIR)rgbasm -o $@ $<

define DEP
$1: $2 $$(shell tools/scan_includes $2) | rgbdscheck.o
	$$(RGBDS_DIR)rgbasm $$(RGBASM_FLAGS) -L -o $$@ $$<
endef

ifeq (,$(filter clean tidy tools,$(MAKECMDGOALS)))
$(info $(shell $(MAKE) -C tools))
$(foreach obj, $(crystal_obj), $(eval $(call DEP,$(obj),$(obj:.o=.asm))))
endif


.gbc: tools/bankends
%.gbc: $(crystal_obj)
	$(RGBDS_DIR)rgblink $(RGBLINK_FLAGS) -o $@ $^
	$(RGBDS_DIR)rgbfix $(RGBFIX_FLAGS) $@
	tools/bankends -q $(ROM_NAME).map

.bsp: tools/bspcomp
%.bsp: $(wildcard bsp/*.txt)
	cd bsp; ../tools/bspcomp patch.txt ../$@; cd ..


gfx/battle/lyra_back.2bpp: rgbgfx += -h

gfx/battle_anims/angels.2bpp: tools/gfx += --trim-whitespace
gfx/battle_anims/beam.2bpp: tools/gfx += --remove-xflip --remove-yflip --remove-whitespace
gfx/battle_anims/bubble.2bpp: tools/gfx += --trim-whitespace
gfx/battle_anims/charge.2bpp: tools/gfx += --trim-whitespace
gfx/battle_anims/egg.2bpp: tools/gfx += --remove-whitespace
gfx/battle_anims/explosion.2bpp: tools/gfx += --remove-whitespace
gfx/battle_anims/hit.2bpp: tools/gfx += --remove-whitespace
gfx/battle_anims/horn.2bpp: tools/gfx += --remove-whitespace
gfx/battle_anims/lightning.2bpp: tools/gfx += --remove-whitespace
gfx/battle_anims/misc.2bpp: tools/gfx += --remove-duplicates --remove-xflip
gfx/battle_anims/noise.2bpp: tools/gfx += --remove-whitespace
gfx/battle_anims/objects.2bpp: tools/gfx += --remove-whitespace --remove-xflip
gfx/battle_anims/reflect.2bpp: tools/gfx += --remove-whitespace
gfx/battle_anims/rocks.2bpp: tools/gfx += --remove-whitespace
gfx/battle_anims/skyattack.2bpp: tools/gfx += --remove-whitespace
gfx/battle_anims/status.2bpp: tools/gfx += --remove-whitespace

gfx/card_flip/card_flip_1.2bpp: tools/gfx += --trim-whitespace
gfx/card_flip/card_flip_2.2bpp: tools/gfx += --remove-whitespace

gfx/mail/dragonite.1bpp: tools/gfx += --remove-whitespace
gfx/mail/flower_mail_border.1bpp: tools/gfx += --remove-whitespace
gfx/mail/large_note.1bpp: tools/gfx += --remove-whitespace
gfx/mail/litebluemail_border.1bpp: tools/gfx += --remove-whitespace
gfx/mail/surf_mail_border.1bpp: tools/gfx += --remove-whitespace

gfx/music_player/music_player.2bpp: tools/gfx += --trim-whitespace
gfx/music_player/note_lines.2bpp: tools/gfx += --interleave --png=$<

gfx/new_game/shrink1.2bpp: rgbgfx += -h
gfx/new_game/shrink2.2bpp: rgbgfx += -h

gfx/overworld/overworld.2bpp: gfx/overworld/puddle_splash.2bpp gfx/overworld/cut_grass.2bpp gfx/overworld/cut_tree.2bpp gfx/overworld/heal_machine.2bpp gfx/overworld/fishing_rod.2bpp gfx/overworld/shadow.2bpp gfx/overworld/shaking_grass.2bpp gfx/overworld/boulder_dust.2bpp ; cat $^ > $@

gfx/pack/pack_left.2bpp: tools/gfx += --trim-whitespace
gfx/pack/pack_top_left.2bpp: gfx/pack/pack_top.2bpp gfx/pack/pack_left.2bpp ; cat $^ > $@

gfx/paintings/%.2bpp: rgbgfx += -h

gfx/player/chris_back.2bpp: rgbgfx += -h
gfx/player/kris_back.2bpp: rgbgfx += -h

gfx/pokedex/pokedex.2bpp: tools/gfx += --trim-whitespace
gfx/pokedex/question_mark.2bpp: rgbgfx += -h
gfx/pokedex/slowpoke.2bpp: tools/gfx += --trim-whitespace

gfx/pokegear/pokegear.2bpp: tools/gfx += --trim-whitespace
gfx/pokegear/pokegear_sprites.2bpp: tools/gfx += --trim-whitespace

gfx/pokemon/%/back.2bpp: rgbgfx += -h

gfx/pc/obj.2bpp: gfx/pc/modes.2bpp gfx/pc/bags.2bpp ; cat $^ > $@

gfx/slots/slots_1.2bpp: tools/gfx += --trim-whitespace
gfx/slots/slots_2.2bpp: tools/gfx += --interleave --png=$<
gfx/slots/slots_3.2bpp: tools/gfx += --interleave --png=$< --remove-duplicates --keep-whitespace --remove-xflip

gfx/stats/stats_balls.2bpp: gfx/stats/stats.2bpp gfx/stats/balls.2bpp ; cat $^ > $@

gfx/title/crystal.2bpp: tools/gfx += --interleave --png=$<
gfx/title/logo_version.2bpp: gfx/title/logo.2bpp gfx/title/version.2bpp ; cat $^ > $@

gfx/trade/ball.2bpp: tools/gfx += --remove-whitespace
gfx/trade/game_boy.2bpp: tools/gfx += --remove-duplicates
gfx/trade/link_cable.2bpp: tools/gfx += --remove-duplicates
gfx/trade/ball_poof_cable.2bpp: gfx/trade/ball.2bpp gfx/trade/poof.2bpp gfx/trade/cable.2bpp ; cat $^ > $@
gfx/trade/game_boy_cable.2bpp: gfx/trade/game_boy.2bpp gfx/trade/link_cable.2bpp ; cat $^ > $@
gfx/trade/trade_screen.2bpp: gfx/trade/border.2bpp gfx/trade/textbox.2bpp ; cat $^ > $@

gfx/trainer_card/chris_card.2bpp: rgbgfx += -h
gfx/trainer_card/kris_card.2bpp: rgbgfx += -h

gfx/trainers/%.2bpp: rgbgfx += -h

gfx/type_chart/bg.2bpp: tools/gfx += --remove-duplicates --remove-xflip --remove-yflip
gfx/type_chart/bg0.2bpp: gfx/type_chart/bg.2bpp.vram1p gfx/type_chart/bg.2bpp.vram0p ; cat $^ > $@
gfx/type_chart/ob.2bpp: tools/gfx += --interleave --png=$<


gfx/pokemon/%/front.animated.2bpp: gfx/pokemon/%/front.2bpp gfx/pokemon/%/front.dimensions
	tools/pokemon_animation_graphics -o $@ $^
gfx/pokemon/%/front.animated.tilemap: gfx/pokemon/%/front.2bpp gfx/pokemon/%/front.dimensions
	tools/pokemon_animation_graphics -t $@ $^
gfx/pokemon/%/bitmask.asm: gfx/pokemon/%/front.animated.tilemap gfx/pokemon/%/front.dimensions
	tools/pokemon_animation -b $^ > $@
gfx/pokemon/%/frames.asm: gfx/pokemon/%/front.animated.tilemap gfx/pokemon/%/front.dimensions
	tools/pokemon_animation -f $^ > $@


%.lz: %
	tools/lzcomp -- $< $@

#%.4bpp: %.png
#	superfamiconv tiles -R -i $@ -d $<

%.2bpp: %.png
	$(RGBDS_DIR)rgbgfx $(rgbgfx) -o $@ $<
	$(if $(tools/gfx),\
		tools/gfx $(tools/gfx) -o $@ $@)

%.1bpp: %.png
	$(RGBDS_DIR)rgbgfx $(rgbgfx) -d1 -o $@ $<
	$(if $(tools/gfx),\
		tools/gfx $(tools/gfx) -d1 -o $@ $@)

%.2bpp.vram0: %.2bpp
	tools/sub_2bpp.sh $< 128 > $@

%.2bpp.vram1: %.2bpp
	tools/sub_2bpp.sh $< 128 128 > $@

%.2bpp.vram2: %.2bpp
	tools/sub_2bpp.sh $< 256 128 > $@

%.2bpp.vram0p: %.2bpp
	tools/sub_2bpp.sh $< 127 > $@

%.2bpp.vram1p: %.2bpp
	tools/sub_2bpp.sh $< 127 128 > $@

%.2bpp.vram2p: %.2bpp
	tools/sub_2bpp.sh $< 255 128 > $@

%.dimensions: %.png
	tools/png_dimensions $< $@

data/tilesets/%_collision.bin: data/tilesets/%_collision.asm
	RGBDS_DIR=$(RGBDS_DIR) tools/collision_asm2bin.sh $< $@
