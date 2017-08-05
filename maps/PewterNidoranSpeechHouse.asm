PewterNidoranSpeechHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

PewterNidoranSpeechHouse_MapEventHeader:

.Warps: db 2
	warp_def $7, $2, 1, PEWTER_CITY
	warp_def $7, $3, 1, PEWTER_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_SUPER_NERD, 5, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, SuperNerdScript_0x1a2807, -1
	person_event SPRITE_NIDORAN_M, 5, 4, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, PewterNidoran, -1

SuperNerdScript_0x1a2807:
	jumptextfaceplayer UnknownText_0x1a2814

PewterNidoran:
	opentext
	writetext PewterNidoranText
	cry NIDORAN_M
	waitbutton
	closetext
	end

UnknownText_0x1a2814:
	text "Nidoran, shake!"
	done

PewterNidoranText:
	text "Nidoran: Gau gau!"
	done
