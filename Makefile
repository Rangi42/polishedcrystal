NAME := polishedcrystal
MODIFIERS :=
VERSION := 3.0.0-beta

ROM_NAME = $(NAME)$(MODIFIERS)-$(VERSION)
EXTENSION := gbc

TITLE := PKPCRYSTAL
MCODE := PKPC
ROMVERSION := 0x30

FILLER := 0xff

ifneq ($(wildcard rgbds/.*),)
RGBDS_DIR = rgbds/
else
RGBDS_DIR =
endif

Q :=

.SECONDEXPANSION:

RGBASM_FLAGS     = -EhL -Q8 -P includes.asm -Weverything -Wnumeric-string=2 -Wtruncation=1
RGBASM_VC_FLAGS  = $(RGBASM_FLAGS) -DVIRTUAL_CONSOLE
RGBLINK_FLAGS    = -M -n $(ROM_NAME).sym    -m $(ROM_NAME).map    -p $(FILLER)
RGBLINK_VC_FLAGS = -M -n $(ROM_NAME)_vc.sym -m $(ROM_NAME)_vc.map -p $(FILLER)
RGBFIX_FLAGS     = -csjv -t $(TITLE) -i $(MCODE) -n $(ROMVERSION) -p $(FILLER) -k 01 -l 0x33 -m 0x10 -r 3

ifeq ($(filter faithful,$(MAKECMDGOALS)),faithful)
MODIFIERS := $(MODIFIERS)-faithful
RGBASM_FLAGS += -DFAITHFUL
endif
ifeq ($(filter nortc,$(MAKECMDGOALS)),nortc)
MODIFIERS := $(MODIFIERS)-nortc
RGBASM_FLAGS += -DNO_RTC
endif
ifeq ($(filter monochrome,$(MAKECMDGOALS)),monochrome)
MODIFIERS := $(MODIFIERS)-monochrome
RGBASM_FLAGS += -DMONOCHROME
endif
ifeq ($(filter noir,$(MAKECMDGOALS)),noir)
MODIFIERS := $(MODIFIERS)-noir
RGBASM_FLAGS += -DNOIR
endif
ifeq ($(filter hgss,$(MAKECMDGOALS)),hgss)
MODIFIERS := $(MODIFIERS)-hgss
RGBASM_FLAGS += -DHGSS
endif
ifeq ($(filter debug,$(MAKECMDGOALS)),debug)
MODIFIERS := $(MODIFIERS)-debug
RGBASM_FLAGS += -DDEBUG
endif
ifeq ($(filter pocket,$(MAKECMDGOALS)),pocket)
MODIFIERS :=
NAME := pkpc
EXTENSION := pocket
RGBASM_FLAGS += -DANALOGUE_POCKET -DNO_RTC
RGBFIX_FLAGS = -csj -f hg -t $(TITLE) -i $(MCODE) -n $(ROMVERSION) -p $(FILLER) -k 01 -l 0x33 -m 0x1b -r 3
endif
ifeq ($(filter huffman,$(MAKECMDGOALS)),huffman)
Q := @
RGBASM_FLAGS += -DHUFFMAN
endif

rom_obj := \
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
	gfx/minis_icons.o \
	gfx/pokemon.o \
	gfx/sprites.o \
	gfx/trainers.o \
	gfx/items.o \
	gfx/misc.o

crystal_obj    := $(rom_obj:.o=.o)
crystal_vc_obj :=$(rom_obj:.o=_vc.o)

.SUFFIXES:
.PHONY: clean tidy crystal faithful nortc pocket debug monochrome freespace tools bsp huffman vc
.PRECIOUS: %.2bpp %.1bpp
.SECONDARY:
.DEFAULT_GOAL: crystal

crystal: $$(ROM_NAME).$$(EXTENSION)
faithful: crystal
nortc: crystal
monochrome: crystal
noir: crystal
hgss: crystal
debug: crystal
pocket: crystal
vc: $$(ROM_NAME).patch

tools:
	$(MAKE) -C tools/

clean: tidy
	find gfx maps data/tilesets -name '*.lz' -delete
	find gfx \( -name '*.[12]bpp' -o -name '*.2bpp.vram[012]' -o -name '*.2bpp.vram[012]p' \) -delete
	find gfx/pokemon -mindepth 1 \( -name 'bitmask.asm' -o -name 'frames.asm' \
		-o -name 'front.animated.tilemap' -o -name 'front.dimensions' \) -delete
	find data/tilesets -name '*_collision.bin' -delete
	$(MAKE) clean -C tools/

tidy:
	$(RM) $(crystal_obj) $(crystal_vc_obj) $(wildcard $(NAME)-*.gbc) $(wildcard $(NAME)-*.pocket) $(wildcard $(NAME)-*.bsp) \
		$(wildcard $(NAME)-*.map) $(wildcard $(NAME)-*.sym) $(wildcard $(NAME)-*.patch) rgbdscheck.o

freespace: crystal tools/bankends
	tools/bankends $(ROM_NAME).map > bank_ends.txt

bsp: $(ROM_NAME).bsp

huffman: crystal


rgbdscheck.o: rgbdscheck.asm
	$Q$(RGBDS_DIR)rgbasm -o $@ $<

preinclude_deps := includes.asm $(shell tools/scan_includes includes.asm)

define DEP
$1: $2 $$(shell tools/scan_includes $2) $(preinclude_deps) | rgbdscheck.o
	$Q$$(RGBDS_DIR)rgbasm $$(RGBASM_FLAGS) -L -o $$@ $$<
endef

define VCDEP
$1: $2 $$(shell tools/scan_includes $2) $(preinclude_deps) | rgbdscheck.o
	$Q$$(RGBDS_DIR)rgbasm $$(RGBASM_VC_FLAGS) -L -o $$@ $$<
endef

ifeq (,$(filter clean tidy tools,$(MAKECMDGOALS)))
$(info $(shell $(MAKE) -C tools))
$(foreach obj, $(crystal_obj), $(eval $(call DEP,$(obj),$(obj:.o=.asm))))
$(foreach obj, $(crystal_vc_obj), $(eval $(call VCDEP,$(obj),$(obj:_vc.o=.asm))))
endif

$(ROM_NAME).patch: $(ROM_NAME)_vc.gbc $(ROM_NAME).$(EXTENSION) vc.patch.template
	tools/make_patch $(ROM_NAME)_vc.sym $^ $@

.$(EXTENSION): tools/bankends
$(ROM_NAME).$(EXTENSION): $(crystal_obj) layout.link
	$Q$(RGBDS_DIR)rgblink $(RGBLINK_FLAGS) -l layout.link -o $@ $(filter %.o,$^)
	$Q$(RGBDS_DIR)rgbfix $(RGBFIX_FLAGS) $@
	$Qtools/bankends -q $(ROM_NAME).map >&2

$(ROM_NAME)_vc.gbc: $(crystal_vc_obj) layout.link
	$Q$(RGBDS_DIR)rgblink $(RGBLINK_VC_FLAGS) -l layout.link -o $@ $(filter %.o,$^)
	$Q$(RGBDS_DIR)rgbfix $(RGBFIX_FLAGS) $@
	$Qtools/bankends -q $(ROM_NAME)_vc.map >&2

.bsp: tools/bspcomp
%.bsp: $(wildcard bsp/*.txt)
	$Qcd bsp; ../tools/bspcomp patch.txt ../$@; cd ..


gfx/battle/lyra_back.2bpp: rgbgfx += -Z
gfx/battle/substitute-back.2bpp: rgbgfx += -Z
gfx/battle/substitute-front.2bpp: rgbgfx += -Z

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

gfx/font/%.1bpp: tools/gfx += --trim-whitespace
gfx/font/space.1bpp: tools/gfx =

gfx/mail/dragonite.1bpp: tools/gfx += --remove-whitespace
gfx/mail/flower_mail_border.1bpp: tools/gfx += --remove-whitespace
gfx/mail/large_note.1bpp: tools/gfx += --remove-whitespace
gfx/mail/litebluemail_border.1bpp: tools/gfx += --remove-whitespace
gfx/mail/surf_mail_border.1bpp: tools/gfx += --remove-whitespace

gfx/music_player/bg.2bpp: tools/gfx += --trim-whitespace
gfx/music_player/music_player.2bpp: gfx/music_player/bg.2bpp gfx/music_player/ob.2bpp ; $Qcat $^ > $@

gfx/new_game/shrink1.2bpp: rgbgfx += -Z
gfx/new_game/shrink2.2bpp: rgbgfx += -Z

gfx/overworld/overworld.2bpp: gfx/overworld/puddle_splash.2bpp gfx/overworld/cut_grass.2bpp gfx/overworld/cut_tree.2bpp gfx/overworld/heal_machine.2bpp gfx/overworld/fishing_rod.2bpp gfx/overworld/shadow.2bpp gfx/overworld/shaking_grass.2bpp gfx/overworld/boulder_dust.2bpp ; $Qcat $^ > $@

gfx/pack/pack_left.2bpp: tools/gfx += --trim-whitespace
gfx/pack/pack_top_left.2bpp: gfx/pack/pack_top.2bpp gfx/pack/pack_left.2bpp ; $Qcat $^ > $@

gfx/paintings/%.2bpp: rgbgfx += -Z

gfx/player/chris_back.2bpp: rgbgfx += -Z
gfx/player/kris_back.2bpp: rgbgfx += -Z
gfx/player/crys_back.2bpp: rgbgfx += -Z

gfx/pokedex/%.bin: gfx/pokedex/%.tilemap gfx/pokedex/%.attrmap ; $Qcat $^ > $@
gfx/pokedex/pokedex.2bpp: gfx/pokedex/pokedex0.2bpp gfx/pokedex/pokedex1.2bpp gfx/pokedex/area.2bpp ; $Qcat $^ > $@
gfx/pokedex/question_mark.2bpp: rgbgfx += -Z

gfx/pokegear/pokegear.2bpp: tools/gfx += --trim-whitespace
gfx/pokegear/pokegear_sprites.2bpp: tools/gfx += --trim-whitespace

gfx/pokemon/%/back.2bpp: rgbgfx += -Z

gfx/pc/obj.2bpp: gfx/pc/modes.2bpp gfx/pc/bags.2bpp ; $Qcat $^ > $@

gfx/slots/slots_1.2bpp: tools/gfx += --trim-whitespace
gfx/slots/slots_2.2bpp: tools/gfx += --interleave --png=$<
gfx/slots/slots_3.2bpp: tools/gfx += --interleave --png=$< --remove-duplicates --keep-whitespace --remove-xflip

gfx/stats/judge.2bpp: tools/gfx += --trim-whitespace
gfx/stats/stats_balls.2bpp: gfx/stats/stats.2bpp gfx/stats/balls.2bpp ; $Qcat $^ > $@

gfx/title/crystal.2bpp: tools/gfx += --interleave --png=$<
gfx/title/logo_version.2bpp: gfx/title/logo.2bpp gfx/title/version.2bpp ; $Qcat $^ > $@

gfx/town_map/town_map.2bpp: tools/gfx += --trim-whitespace

gfx/trade/ball.2bpp: tools/gfx += --remove-whitespace
gfx/trade/game_boy.2bpp: tools/gfx += --remove-duplicates
gfx/trade/link_cable.2bpp: tools/gfx += --remove-duplicates
gfx/trade/ball_poof_cable.2bpp: gfx/trade/ball.2bpp gfx/trade/poof.2bpp gfx/trade/cable.2bpp ; $Qcat $^ > $@
gfx/trade/game_boy_cable.2bpp: gfx/trade/game_boy.2bpp gfx/trade/link_cable.2bpp ; $Qcat $^ > $@
gfx/trade/trade_screen.2bpp: gfx/trade/border.2bpp gfx/trade/textbox.2bpp ; $Qcat $^ > $@

gfx/trainer_card/chris_card.2bpp: rgbgfx += -Z
gfx/trainer_card/kris_card.2bpp: rgbgfx += -Z
gfx/trainer_card/crys_card.2bpp: rgbgfx += -Z

gfx/trainers/%.2bpp: rgbgfx += -Z

gfx/type_chart/bg.2bpp: tools/gfx += --remove-duplicates --remove-xflip --remove-yflip
gfx/type_chart/bg0.2bpp: gfx/type_chart/bg.2bpp.vram1p gfx/type_chart/bg.2bpp.vram0p ; $Qcat $^ > $@
gfx/type_chart/ob.2bpp: tools/gfx += --interleave --png=$<


gfx/pokemon/%/front.animated.2bpp: gfx/pokemon/%/front.2bpp gfx/pokemon/%/front.dimensions
	$Qtools/pokemon_animation_graphics -o $@ $^
gfx/pokemon/%/front.animated.tilemap: gfx/pokemon/%/front.2bpp gfx/pokemon/%/front.dimensions
	$Qtools/pokemon_animation_graphics -t $@ $^
gfx/pokemon/%/bitmask.asm: gfx/pokemon/%/front.animated.tilemap gfx/pokemon/%/front.dimensions
	$Qtools/pokemon_animation -b $^ > $@
gfx/pokemon/%/frames.asm: gfx/pokemon/%/front.animated.tilemap gfx/pokemon/%/front.dimensions
	$Qtools/pokemon_animation -f $^ > $@


%.lz: %
	$Qtools/lzcomp -- $< $@

#%.4bpp: %.png
#	$Qsuperfamiconv tiles -R -i $@ -d $<

%.2bpp: %.png
	$Q$(RGBDS_DIR)rgbgfx $(rgbgfx) -o $@ $<
	$(if $(tools/gfx),\
		$Qtools/gfx $(tools/gfx) -o $@ $@)

%.1bpp: %.png
	$(RGBDS_DIR)rgbgfx $(rgbgfx) -d1 -o $@ $<
	$(if $(tools/gfx),\
		$Qtools/gfx $(tools/gfx) -d1 -o $@ $@)

%.2bpp.vram0: %.2bpp
	$Qtools/sub_2bpp.sh $< 128 > $@

%.2bpp.vram1: %.2bpp
	$Qtools/sub_2bpp.sh $< 128 128 > $@

%.2bpp.vram2: %.2bpp
	$Qtools/sub_2bpp.sh $< 256 128 > $@

%.2bpp.vram0p: %.2bpp
	$Qtools/sub_2bpp.sh $< 127 > $@

%.2bpp.vram1p: %.2bpp
	$Qtools/sub_2bpp.sh $< 127 128 > $@

%.2bpp.vram2p: %.2bpp
	$Qtools/sub_2bpp.sh $< 255 128 > $@

%.dimensions: %.png
	$Qtools/png_dimensions $< $@

data/tilesets/%_collision.bin: data/tilesets/%_collision.asm
	$QRGBDS_DIR=$(RGBDS_DIR) tools/collision_asm2bin.sh $< $@
