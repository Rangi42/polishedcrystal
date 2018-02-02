Route26HealSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, ROUTE_26, 2
	warp_event  3,  7, ROUTE_26, 2

	db 0 ; coord events

	db 1 ; bg events
	bg_event  7,  1, SIGNPOST_JUMPSTD, picturebookshelf

	db 1 ; object events
	object_event  2,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, TeacherScript_0x7b125, -1

TeacherScript_0x7b125:
	showtextfaceplayer UnknownText_0x7b14d
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	playmusic MUSIC_HEAL
	special HealParty
	pause 60
	special Special_FadeInQuickly
	special RestartMapMusic
	jumptext UnknownText_0x7b18b

UnknownText_0x7b14d:
	text "Your #mon look"
	line "a little tired."

	para "You should rest"
	line "them a while."
	done

UnknownText_0x7b18b:
	text "There!"

	para "Your #mon are"
	line "looking good!"

	para "Keep at it!"
	done
