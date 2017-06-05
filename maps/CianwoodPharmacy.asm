const_value set 2
	const CIANWOODPHARMACY_PHARMACIST

CianwoodPharmacy_MapScriptHeader:
.MapTriggers:
	db 1

	; triggers
	dw CianwoodPharmacyTrigger, 0

.MapCallbacks:
	db 0

CianwoodPharmacyTrigger:
	end

CianwoodPharmacist:
	faceplayer
	opentext
	checkevent EVENT_GOT_SECRETPOTION_FROM_PHARMACY
	iftrue .Mart
	checkevent EVENT_JASMINE_EXPLAINED_AMPHYS_SICKNESS
	iffalse .Mart
	writetext PharmacistGiveSecretpotionText
	buttonsound
	giveitem SECRETPOTION
	writetext ReceivedSecretpotionText
	playsound SFX_KEY_ITEM
	waitsfx
	itemnotify
	setevent EVENT_GOT_SECRETPOTION_FROM_PHARMACY
	writetext PharmacistDescribeSecretpotionText
	waitbutton
	closetext
	spriteface CIANWOODPHARMACY_PHARMACIST, UP
	end

.Mart:
	pokemart MARTTYPE_PHARMACY, MART_CIANWOOD
	closetext
	spriteface CIANWOODPHARMACY_PHARMACIST, UP
	end

CianwoodPharmacyRadio:
	jumpstd radio2

CianwoodPharmacyBookshelf:
	jumpstd difficultbookshelf

PharmacistGiveSecretpotionText:
	text "Your #mon ap-"
	line "pear to be fine."

	para "Is something wor- "
	line "rying you?"

	para "…"

	para "The Lighthouse"
	line "#mon is in"
	cont "trouble?"

	para "I got it!"

	para "This ought to do"
	line "the trick."
	done

ReceivedSecretpotionText:
	text "<PLAYER> received"
	line "SecretPotion."
	done

PharmacistDescribeSecretpotionText:
	text "My SecretPotion is"
	line "a tad too strong."

	para "I only offer it in"
	line "an emergency."
	done

CianwoodPharmacy_MapEventHeader:
.Warps:
	db 2
	warp_def $7, $3, 4, CIANWOOD_CITY
	warp_def $7, $4, 4, CIANWOOD_CITY

.XYTriggers:
	db 0

.Signposts:
	db 3
	signpost 1, 5, SIGNPOST_READ, CianwoodPharmacyRadio
	signpost 1, 6, SIGNPOST_READ, CianwoodPharmacyBookshelf
	signpost 1, 7, SIGNPOST_READ, CianwoodPharmacyBookshelf

.PersonEvents:
	db 1
	person_event SPRITE_PHARMACIST, 3, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CianwoodPharmacist, -1
