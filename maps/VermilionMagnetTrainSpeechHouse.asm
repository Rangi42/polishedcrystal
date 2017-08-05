VermilionMagnetTrainSpeechHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

VermilionMagnetTrainSpeechHouse_MapEventHeader:

.Warps: db 2
	warp_def $7, $2, 4, VERMILION_CITY
	warp_def $7, $3, 4, VERMILION_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_POKEFAN_F, 3, 2, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, PokefanFScript_0x191eb7, -1
	person_event SPRITE_YOUNGSTER, 3, 0, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x191eba, -1

PokefanFScript_0x191eb7:
	jumptextfaceplayer UnknownText_0x191ec0

YoungsterScript_0x191eba:
	jumptextfaceplayer UnknownText_0x191f16

UnknownText_0x191ec0:
	text "Do you know about"
	line "the Magnet Train?"

	para "It's a railway"
	line "that goes to Gol-"
	cont "denrod in Johto."
	done

UnknownText_0x191f16:
	text "I want to go to"
	line "Saffron to see"
	cont "the Magnet Train."
	done
