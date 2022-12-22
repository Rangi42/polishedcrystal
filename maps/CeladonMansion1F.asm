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
	pokemon_event  3,  4, CLEFAIRY, SPRITEMOVEDATA_POKEMON, -1, -1, PAL_NPC_RED, CeladonMansion1FClefairyText, -1
	pokemon_event  4,  4, NIDORAN_F, SPRITEMOVEDATA_POKEMON, -1, -1, PAL_NPC_BLUE, CeladonMansion1FNidoranFText, -1

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
	; TODO
	; para "Now, what flavor"
	; line "does it like?"
	;	Spicy/Sour/Dry/Bitter/Sweet
	; para "And what flavor"
	; line "does it dislike?"
	;	Spicy/Sour/Dry/Bitter/Sweet
	; para "Okay! Here's"
	; line "your tea."
	; para "One cup for you,"
	; line "and one cup for"
	; cont "<nickname>!"
	;
	; para "<nickname> looks"
	; line "different somehow!"
	;
	; para "There's nothing"
	; line "like hot mint tea."
	; para "It can change a"
	; line "#mon's very"
	; cont "nature!"
	waitbutton
	closetext
	end

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


	text "My dear #mon"
	line "keep me company,"

	para "so I don't ever"
	line "feel lonely."

	para "Meowth even brings"
	line "money home."
	done

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
