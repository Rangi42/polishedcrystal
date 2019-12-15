LacunosaTown_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_TILES, LacunosaTownTileScript

	db 10 ; warp events
	warp_event 15, 10, LACUNOSA_TOWN, 2
	warp_event 14,  7, LACUNOSA_TOWN, 1
	warp_event 15, 13, LACUNOSA_TOWN, 7
	warp_event 16, 13, LACUNOSA_TOWN, 8
	warp_event 17, 13, LACUNOSA_TOWN, 9
	warp_event 18, 13, LACUNOSA_TOWN, 10
	warp_event 15, 17, LACUNOSA_TOWN, 3
	warp_event 16, 17, LACUNOSA_TOWN, 4
	warp_event 17, 17, LACUNOSA_TOWN, 5
	warp_event 18, 17, LACUNOSA_TOWN, 6

	db 8 ; coord events
	coord_event  8,  6, 0, LacunosaTownUnderfootTrigger
	coord_event  9,  6, 0, LacunosaTownUnderfootTrigger
	coord_event 26, 20, 0, LacunosaTownUnderfootTrigger
	coord_event 27, 20, 0, LacunosaTownUnderfootTrigger
	coord_event  8,  8, 1, LacunosaTownOverheadTrigger
	coord_event  9,  8, 1, LacunosaTownOverheadTrigger
	coord_event 26, 22, 1, LacunosaTownOverheadTrigger
	coord_event 27, 22, 1, LacunosaTownOverheadTrigger

	db 3 ; bg events
	bg_event 30, 12, SIGNPOST_JUMPTEXT, LacunosaTownSignText
	bg_event 26, 14, SIGNPOST_UP, LacunosaTownTrashCan
	bg_event 27, 14, SIGNPOST_UP, LacunosaTownVendingMachine

	db 26 ; object events
	object_event 16, 24, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WANDER, 1, 2, -1, (1 << MORN) | (1 << DAY), PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, LacunosaTownPokefanFText, -1
	object_event 30,  6, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << MORN) | (1 << DAY), PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, LacunosaTownGrannyScript, -1
	object_event 22, 25, SPRITE_CHILD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, (1 << MORN) | (1 << DAY), PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, LacunosaTownChildText, -1
	object_event 30, 23, SPRITE_FISHER, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, (1 << MORN) | (1 << DAY), PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, LacunosaTownFisherText, -1
	object_event 26,  3, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << MORN) | (1 << DAY), PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, LacunosaTownBlackBeltText, -1
	object_event 15, 18, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, (1 << MORN) | (1 << DAY), PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, LacunosaTownBattleGirlText, -1
	object_event  8, 11, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, (1 << MORN) | (1 << DAY), PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, LacunosaTownOfficerText, -1
	object_event  4, 11, SPRITE_EEVEE, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, (1 << MORN) | (1 << DAY), PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, LacunosaTownEeveeScript, -1
	object_event 22, 11, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << MORN) | (1 << DAY), PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, LacunosaTownFatGuyText, -1
	itemball_event 16,  7, FULL_HEAL, 1, EVENT_MURKY_SWAMP_FULL_HEAL
	object_event 11,  2, SPRITE_LACUNOSA_TILES, SPRITEMOVEDATA_EDGE_HI, 0, 0, -1, -1, PAL_NPC_ROCK, PERSONTYPE_COMMAND, end, NULL, -1
	object_event 11,  3, SPRITE_LACUNOSA_TILES, SPRITEMOVEDATA_EDGE_LO, 0, 0, -1, -1, PAL_NPC_ROCK, PERSONTYPE_COMMAND, end, NULL, -1
	object_event 22,  2, SPRITE_LACUNOSA_TILES, SPRITEMOVEDATA_RAIL_UPPER_HI, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, end, NULL, -1
	object_event 22,  3, SPRITE_LACUNOSA_TILES, SPRITEMOVEDATA_RAIL_UPPER_LO, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, end, NULL, -1
	object_event 22,  4, SPRITE_LACUNOSA_TILES, SPRITEMOVEDATA_RAIL_LOWER_HI, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, end, NULL, -1
	object_event 22,  5, SPRITE_LACUNOSA_TILES, SPRITEMOVEDATA_RAIL_LOWER_LO, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, end, NULL, -1
	object_event 14, 13, SPRITE_LACUNOSA_TILES, SPRITEMOVEDATA_RAIL_UPPER_HI, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, end, NULL, -1
	object_event 14, 14, SPRITE_LACUNOSA_TILES, SPRITEMOVEDATA_RAIL_UPPER_LO, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, end, NULL, -1
	object_event 14, 15, SPRITE_LACUNOSA_TILES, SPRITEMOVEDATA_RAIL_LOWER_HI, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, end, NULL, -1
	object_event 14, 16, SPRITE_LACUNOSA_TILES, SPRITEMOVEDATA_RAIL_LOWER_LO, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, end, NULL, -1
	object_event 19, 13, SPRITE_LACUNOSA_TILES, SPRITEMOVEDATA_RAIL_UPPER_HI_FLIP, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, end, NULL, -1
	object_event 19, 14, SPRITE_LACUNOSA_TILES, SPRITEMOVEDATA_RAIL_UPPER_LO_FLIP, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, end, NULL, -1
	object_event 19, 15, SPRITE_LACUNOSA_TILES, SPRITEMOVEDATA_RAIL_LOWER_HI_FLIP, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, end, NULL, -1
	object_event 19, 16, SPRITE_LACUNOSA_TILES, SPRITEMOVEDATA_RAIL_LOWER_LO_FLIP, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, end, NULL, -1
	object_event 15, 17, SPRITE_LACUNOSA_TILES, SPRITEMOVEDATA_ARCH_LEFT, 0, 0, -1, -1, PAL_NPC_ROCK, PERSONTYPE_COMMAND, end, NULL, -1
	object_event 18, 17, SPRITE_LACUNOSA_TILES, SPRITEMOVEDATA_ARCH_RIGHT, 0, 0, -1, -1, PAL_NPC_ROCK, PERSONTYPE_COMMAND, end, NULL, -1

lacunosa_town_overhead_changebridgeblocks: MACRO
	changebridgeblock  8, 14, $4a, LACUNOSA_TOWN
	changebridgeblock 10, 14, $4a, LACUNOSA_TOWN
	changebridgeblock 12, 14, $4b, LACUNOSA_TOWN
	changebridgeblock 14, 14, $4c, LACUNOSA_TOWN
	changebridgeblock 14, 12, $40, LACUNOSA_TOWN
	changebridgeblock 16, 12, $41, LACUNOSA_TOWN
	changebridgeblock 18, 12, $42, LACUNOSA_TOWN
	changebridgeblock 18, 14, $4e, LACUNOSA_TOWN
	changebridgeblock 20, 14, $4f, LACUNOSA_TOWN
	changebridgeblock 22, 14, $50, LACUNOSA_TOWN
	changebridgeblock 24, 12, $44, LACUNOSA_TOWN
ENDM

lacunosa_town_underfoot_changebridgeblocks: MACRO
	changebridgeblock  8, 14, $97, LACUNOSA_TOWN
	changebridgeblock 10, 14, $97, LACUNOSA_TOWN
	changebridgeblock 12, 14, $98, LACUNOSA_TOWN
	changebridgeblock 14, 14, $99, LACUNOSA_TOWN
	changebridgeblock 14, 12, $9a, LACUNOSA_TOWN
	changebridgeblock 16, 12, $9b, LACUNOSA_TOWN
	changebridgeblock 18, 12, $9c, LACUNOSA_TOWN
	changebridgeblock 18, 14, $9d, LACUNOSA_TOWN
	changebridgeblock 20, 14, $9e, LACUNOSA_TOWN
	changebridgeblock 22, 14, $9f, LACUNOSA_TOWN
	changebridgeblock 24, 12, $a0, LACUNOSA_TOWN
ENDM

LacunosaTownTileScript:
	checkscene
	iftrue .underfoot
	callasm LacunosaTownOverheadAsm
	return

.underfoot:
	callasm LacunosaTownUnderfootAsm
	return

LacunosaTownOverheadAsm:
	lacunosa_town_overhead_changebridgeblocks
	jp BufferScreen

LacunosaTownUnderfootAsm:
	lacunosa_town_underfoot_changebridgeblocks
	jp BufferScreen

LacunosaTownOverheadTrigger:
	thisasm
	lacunosa_town_overhead_changebridgeblocks
	xor a
	jr LacunosaTownUnderfootTrigger.Finish

LacunosaTownUnderfootTrigger:
	thisasm
	lacunosa_town_underfoot_changebridgeblocks
	ld a, 1
.Finish:
	ld [wWalkingOnBridge], a
	ld [wLacunosaTownTrigger], a ; setscene a
	jp RefreshScreen_BridgeUpdate ; refreshscreen (optimized)

LacunosaTownTrashCan:
	jumpstd trashcan

LacunosaTownVendingMachine:
	jumpstd vendingmachine

LacunosaTownSignText:
	text "Lacunosa Town"

	para "Methodical and"
	line "Orderly for Safety"
	done

LacunosaTownPokefanFText:
	text "Welcome to"
	line "Lacunosa Town."

	para "In this town,"
	line "people live like"
	cont "clockwork from"
	cont "morning to night."

	para "If you live soak-"
	line "ing up sunlight,"

	para "you can sleep"
	line "well at night."
	done

LacunosaTownGrannyScript:
	faceplayer
	opentext
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .NoText
	jumpopenedtext .YesText

.QuestionText:
	text "Hello there,"
	line "young traveler!"

	para "Would you like to"
	line "hear an old story"
	cont "of Lacunosa Town?"

	para "Bear with me, I'm"
	line "an old lady who"
	cont "likes long tales!"
	done

.YesText:
	text "There's a great big"
	line "hole at the back"
	cont "of this town."

	para "A long time ago,"
	line "a huge meteor fell"
	cont "from the sky and"
	cont "made the big hole."

	para "A scary monster"
	line "was hiding inside"
	cont "the meteor!"

	para "People say the"
	line "monster appeared"
	cont "at night, bringing"
	cont "a cold wind, and"
	cont "it stole away peo-"
	cont "ple and #mon…"

	para "So the villagers"
	line "built big walls to"
	cont "keep the monster"
	cont "out and made a"
	cont "rule that no one"
	cont "could go out after"
	cont "dark."

	para "…Of course,"
	line "nowadays nobody"
	cont "believes in such"
	cont "things."

	para "But you know…"

	para "Even now, the peo-"
	line "ple of this town"
	cont "stay inside after"
	cont "dark."

	para "Isn't that"
	line "strange?"

	para "I guess old stor-"
	line "ies and old trad-"
	cont "itions have some"

	para "influence on our"
	line "current life."
	done

.NoText:
	text "Oh, well, that's"
	line "too bad."

	para "Come talk to me if"
	line "you're ever in the"
	cont "mood for a story!"
	done

LacunosaTownChildText:
	text "At night, a scary"
	line "monster comes out"
	cont "of the big hole,"

	para "so you have to go"
	line "home and be good!"
	done

LacunosaTownFisherText:
	text "Along the road,"
	line "there's a coast-"
	cont "line that fishing"
	cont "fans love."

	para "Whirrrrr…"
	line "plunk!"

	para "That's the sound my"
	line "fishing rod makes."

	para "I like to hear it"
	line "every day!"
	done

LacunosaTownBlackBeltText:
	text "My grandma loves"
	line "to tell stories."

	para "She makes me lis-"
	line "ten to them all"
	cont "the time!"
	done

LacunosaTownBattleGirlText:
	text "There are lots of"
	line "people in the"
	cont "world, and there"
	cont "are lots of ideas."
	done

LacunosaTownOfficerText:
	text "I don't have any-"
	line "thing to do ever"
	cont "since I came here."

	para "Nobody goes out at"
	line "night, so it's very"
	cont "peaceful."
	done

LacunosaTownEeveeScript:
	faceplayer
	showcrytext .Text, EEVEE
	end

.Text:
	text "Eevee: Vee! Vee!"
	done

LacunosaTownFatGuyText:
	text "My #mon always"
	line "goes out for fun"
	cont "without me."
	done
