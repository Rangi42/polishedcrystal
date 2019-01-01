CianwoodPharmacy_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  3,  7, CIANWOOD_CITY, 4
	warp_event  4,  7, CIANWOOD_CITY, 4

	db 0 ; coord events

	db 3 ; bg events
	bg_event  5,  1, SIGNPOST_JUMPSTD, radio2
	bg_event  6,  1, SIGNPOST_JUMPSTD, difficultbookshelf
	bg_event  7,  1, SIGNPOST_JUMPSTD, difficultbookshelf

	db 1 ; object events
	object_event  4,  3, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, CianwoodPharmacist, -1

CianwoodPharmacist:
	checkevent EVENT_GOT_SECRETPOTION_FROM_PHARMACY
	iftrue .Mart
	checkevent EVENT_JASMINE_EXPLAINED_AMPHYS_SICKNESS
	iffalse .Mart
	faceplayer
	opentext
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
	turnobject LAST_TALKED, UP
	end

.Mart:
	scall .PokeMart
	turnobject LAST_TALKED, UP
	end

.PokeMart:
	pokemart MARTTYPE_PHARMACY, MART_CIANWOOD

PharmacistGiveSecretpotionText:
	text "Your #mon"
	line "appear to be fine."

	para "Is something"
	line "worrying you?"

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
