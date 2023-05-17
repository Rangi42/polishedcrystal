CeladonMansion1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  6,  9, CELADON_CITY, 2
	warp_event  7,  9, CELADON_CITY, 2
	warp_event  3,  0, CELADON_CITY, 3
	warp_event  0,  0, CELADON_MANSION_2F, 1
	warp_event  7,  0, CELADON_MANSION_2F, 4

	def_coord_events

	def_bg_events
	bg_event  5,  8, BGEVENT_UP, CeladonMansionManagersSuiteSign
	bg_event  0,  3, BGEVENT_JUMPSTD, picturebookshelf
	bg_event  2,  3, BGEVENT_JUMPSTD, picturebookshelf

	def_object_events
	object_event  1,  5, SPRITE_GRANNY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonMansionManagerScript, -1
	pokemon_event  2,  6, MEOWTH, SPRITEMOVEDATA_POKEMON, -1, -1, PAL_NPC_BROWN, CeladonMansion1FMeowthText, -1
	pokemon_event  3,  4, CLEFAIRY, SPRITEMOVEDATA_POKEMON, -1, -1, PAL_NPC_PINK, CeladonMansion1FClefairyText, -1
	pokemon_event  4,  4, NIDORAN_F, SPRITEMOVEDATA_POKEMON, -1, -1, PAL_NPC_TEAL, CeladonMansion1FNidoranFText, -1

CeladonMansionManagersSuiteSign:
	jumpthistext

	text "Celadon Condo"
	line "Manager's Suite"
	done

CeladonMansionManagerScript:
	checkitem MINT_LEAF
	iffalse_jumptextfaceplayer .NoMintLeafText
	faceplayer
	opentext
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .AcceptedText
	promptbutton
	special Special_MintTeaPickMon
	iffalse_jumpopenedtext .RefusedText
	ifequalfwd $1, .Egg
	writetext .LikedFlavorText
	loadmenu .MenuDataHeader
	verticalmenu
	closewindow
	iffalse_jumpopenedtext .RefusedText
	writemem wMintTeaLikedFlavor
	writetext .DislikedFlavorText
	loadmenu .MenuDataHeader
	verticalmenu
	closewindow
	iffalse_jumpopenedtext .RefusedText
	writemem wMintTeaDislikedFlavor
	special Special_MintTeaChangeNature
	iffalsefwd .Neutral
	writetext .TeaIsReadyText
	sjumpfwd .Done
.Neutral
	writetext .NeutralTeaText
.Done
	waitbutton
	closetext
	takeitem MINT_LEAF
	readmem wCurPartySpecies
	pokepic 0
	cry 0
	waitsfx
	closepokepic
	opentext
	writetext .MonLooksDifferentText
	special PlayCurMonCry
	waitbutton
	jumpthisopenedtext

	text "There's nothing"
	line "like hot mint tea."

	para "It can change a"
	line "#mon's very"
	cont "nature!"
	done

.Egg:
	jumpthisopenedtext

	text "Do you expect me"
	line "to make that into"
	cont "a tea egg?"
	done

.NoMintLeafText:
	text "Oh, hello,"
	line "dearie."

	para "I'm having tea with"
	line "my dear #mon."

	para "If you had a"
	line "Mint Leaf,"

	para "I'd invite you"
	line "to join me."

	para "#mon love mint"
	line "in their tea."

	para "It has a lasting"
	line "effect on their"
	cont "very nature!"
	done

.QuestionText:
	text "Oh, hello,"
	line "dearie."

	para "I see you have a"
	line "Mint Leaf."

	para "Would you like"
	line "me to steep it"

	para "in some tea for"
	line "your #mon?"
	done

.RefusedText:
	text "Don't go filling up"
	line "on Lemonade and"
	cont "Soda Pop, now!"
	done

.AcceptedText:
	text "Which one of your"
	line "#mon wants tea?"
	done

.LikedFlavorText:
	text "Now, what flavor"
	line "does "
	text_ram wStringBuffer1
	cont "like?"
	done

.DislikedFlavorText:
	text "And what flavor"
	line "does it dislike?"
	done

.NeutralTeaText:
	text "That's an unusual"
	line "preference, but"
	cont "I can brew it!"

	para "One cup for you,"
	line "and one cup for"
	cont ""
	text_ram wStringBuffer1
	text "!"
	done

.TeaIsReadyText:
	text "Okay! Here's"
	line "your tea."

	para "One cup for you,"
	line "and one cup for"
	cont ""
	text_ram wStringBuffer1
	text "!"
	done

.MonLooksDifferentText:
	text_ram wStringBuffer1
	text " looks"
	line "different somehow!"
	done

.MenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 9, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 5 ; items
	; this order is meaningful to calculate the new nature
	db "Spicy@" ; atk
	db "Sour@" ; def
	db "Sweet@" ; spe
	db "Dry@" ; sat
	db "Bitter@" ; sdf

CeladonMansion1FMeowthText:
	text "Meowth: Meow!"
	done

CeladonMansion1FClefairyText:
	text "Clefairy: Clef"
	line "cleff!"
	done

CeladonMansion1FNidoranFText:
	text "Nidoran: Kya"
	line "kyaoo!"
	done
