BattleObjectPals:
INCLUDE "gfx/battle_anims/battle_anims.pal"

PartyMenuBGPals:
INCLUDE "gfx/stats/party_menu_bg.pal"
HPBarPals:
INCLUDE "gfx/stats/hp_bars.pal"

HPBarInteriorPals:
INCLUDE "gfx/battle/hp_bar.pal"

GenderAndExpBarPals:
INCLUDE "gfx/battle/exp_bar.pal"

PokerusAndShinyPals:
INCLUDE "gfx/pc/pokerus_shiny.pal"

StatsScreenPals:
INCLUDE "gfx/stats/pages.pal"

StatsScreenPagePals:
INCLUDE "gfx/stats/stats.pal"

StatusIconPals:
INCLUDE "gfx/battle/status.pal"

CategoryIconPals:
INCLUDE "gfx/battle/categories.pal"

TypeIconPals:
INCLUDE "gfx/battle/types.pal"

ItemIconPalettes:
CaughtBallPals:
INCLUDE "gfx/items/items.pal"

CancelPalette:
if !DEF(MONOCHROME)
; CANCEL
	RGB 31, 31, 31
	RGB 31, 31, 31
else
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
endc

WhitePalette:
if !DEF(MONOCHROME)
	RGB 31, 31, 31
else
	RGB_MONOCHROME_WHITE
endc

BlackPalette:
if !DEF(MONOCHROME)
	RGB 00, 00, 00
else
	RGB_MONOCHROME_BLACK
endc

KeyItemIconPalettes:
INCLUDE "gfx/items/key_items.pal"

TMHMTypeIconPals:
INCLUDE "gfx/items/tm_hm_types.pal"

ApricornIconPalettes:
INCLUDE "gfx/items/apricorns.pal"

PokegearPals:
INCLUDE "gfx/pokegear/pokegear.pal"

FemalePokegearInterfacePalette:
INCLUDE "gfx/pokegear/pokegear_f.pal"

JohtoBadgePalettes:
INCLUDE "gfx/trainer_card/johto_badges.pal"

KantoBadgePalettes:
INCLUDE "gfx/trainer_card/kanto_badges.pal"

SlotMachinePals:
INCLUDE "gfx/slots/slots.pal"

TrainerCardPals:
INCLUDE "gfx/trainer_card/trainer_card.pal"

DiplomaPals:
INCLUDE "gfx/diploma/diploma.pal"
PartyMenuOBPals:
PokegearOBPals:
INCLUDE "gfx/icons/icons.pal"

BodyColorPalsIncludingNull:
if !DEF(MONOCHROME)
	RGB 00, 00, 00
else
	RGB_MONOCHROME_BLACK
endc
BodyColorPals:
INCLUDE "gfx/pokedex/body_colors.pal"

MartMenuPals:
INCLUDE "gfx/mart/mart.pal"

BlueCardMartMenuPals:
INCLUDE "gfx/mart/blue_card.pal"

BTMartMenuPals:
INCLUDE "gfx/mart/battle_tower.pal"

MalePackPals:
INCLUDE "gfx/pack/pack.pal"

FemalePackPals:
INCLUDE "gfx/pack/pack_f.pal"

MailPals:
INCLUDE "gfx/mail/mail.pal"

DarkGrayPalette:
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 07, 07, 07
	RGB 02, 03, 03
	RGB 00, 00, 00
else
	MONOCHROME_RGB_FOUR
endc

PokedexPals:
INCLUDE "gfx/pokedex/pokedex.pal"

Pokedex_QuestionMarkPal:
INCLUDE "gfx/pokedex/question_mark.pal"

BillsPC_ThemePals:
INCLUDE "gfx/pc/themes.pal"
