Route26HealSpeechHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route26HealSpeechHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 2, ROUTE_26
	warp_def 7, 3, 2, ROUTE_26

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 7, SIGNPOST_JUMPSTD, picturebookshelf

.PersonEvents: db 1
	person_event SPRITE_TEACHER, 3, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, TeacherScript_0x7b125, -1

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
