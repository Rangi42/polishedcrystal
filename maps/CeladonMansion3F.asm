CeladonMansion3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  0, CELADON_MANSION_ROOF, 1
	warp_event  1,  0, CELADON_MANSION_2F, 2
	warp_event  6,  0, CELADON_MANSION_2F, 3
	warp_event  7,  0, CELADON_MANSION_ROOF, 2

	def_coord_events

	def_bg_events
	bg_event  5,  8, BGEVENT_UP, MapCeladonMansion3FSignpost0Script
	bg_event  4,  3, BGEVENT_UP, MapCeladonMansion3FSignpost1Script
	bg_event  1,  6, BGEVENT_UP, MapCeladonMansion3FSignpost2Script
	bg_event  1,  3, BGEVENT_UP, MapCeladonMansion3FSignpost3Script

	def_object_events
	object_event  3,  6, SPRITE_COOL_DUDE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GameFreakGameDesignerScript, -1
	object_event  3,  4, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, GameFreakGraphicArtistText, -1
	object_event  0,  7, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, GameFreakProgrammerText, -1
	object_event  0,  4, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 2, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, GameFreakCharacterDesignerText, -1

GameFreakGameDesignerScript:
	faceplayer
	opentext
	writetext GameFreakGameDesignerText
	checkcode VAR_DEXCAUGHT
	ifgreater 252, UnknownScript_0x7167e
	waitendtext

UnknownScript_0x7167e:
	buttonsound
	writetext GameFreakGameDesignerCompletedPokedexText
	playsound SFX_DEX_FANFARE_230_PLUS
	waitsfx
	writetext GameFreakGameDesignerPauseForDiplomaText
	buttonsound
	special Diploma
	jumpopenedtext GameFreakGameDesignerAfterDiplomaText

MapCeladonMansion3FSignpost0Script:
	jumptext CeladonMansion3FDevRoomSignText

MapCeladonMansion3FSignpost1Script:
	jumptext CeladonMansion3FDrawingText

MapCeladonMansion3FSignpost2Script:
	jumptext CeladonMansion3FGameProgramText

MapCeladonMansion3FSignpost3Script:
	jumptext CeladonMansion3FReferenceMaterialText

GameFreakGameDesignerText:
	text "Is that right?"

	para "I'm the Game"
	line "Designer!"

	para "Filling up your"
	line "#dex is tough,"
	cont "but don't give up!"
	done

GameFreakGameDesignerCompletedPokedexText:
	text "Wow! Excellent!"
	line "You completed your"
	cont "#dex!"

	para "Congratulations!"
	done

GameFreakGameDesignerPauseForDiplomaText:
	text "…"
	done

GameFreakGameDesignerAfterDiplomaText:
	text "You should go show"
	line "that off!"
	done

GameFreakGraphicArtistText:
	text "I'm the Graphic"
	line "Artist."

	para "I drew you!"
	done

GameFreakProgrammerText:
	text "Who, me? I'm the"
	line "Programmer."

	para "Use the Wonder"
	line "Trade Hub!"
	done

GameFreakCharacterDesignerText:
	text "Isn't Lyra"
	line "adorable?"

	para "Jasmine's pretty"
	line "too."

	para "Oh, I love them!"
	done

CeladonMansion3FDevRoomSignText:
	text "GAME FREAK"
	line "Development Room"
	done

CeladonMansion3FDrawingText:
	text "It's a detailed"
	line "drawing of a"
	cont "pretty girl."
	done

CeladonMansion3FGameProgramText:
	text "It's the game"
	line "program. Messing"

	para "with it could put"
	line "a bug in the game!"
	done

CeladonMansion3FReferenceMaterialText:
	text "It's crammed with"
	line "reference materi-"
	cont "als. There's even"
	cont "a # Doll."
	done
