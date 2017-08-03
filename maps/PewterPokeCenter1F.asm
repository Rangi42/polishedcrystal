PewterPokeCenter1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

PewterPokeCenter1F_MapEventHeader:

.Warps: db 3
	warp_def $7, $5, 4, PEWTER_CITY
	warp_def $7, $6, 4, PEWTER_CITY
	warp_def $7, $0, 1, POKECENTER_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalBrockScript

.PersonEvents: db 5
	person_event SPRITE_NURSE, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, NurseScript_0x1a2ee7, -1
	person_event SPRITE_TEACHER, 5, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, TeacherScript_0x1a2eea, -1
	person_event SPRITE_JIGGLYPUFF, 3, 2, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, PewterJigglypuff, -1
	person_event SPRITE_CHILD, 3, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ChildScript_0x1a2ef7, -1
	person_event SPRITE_POKEFAN_M, 2, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, Chris, -1

NurseScript_0x1a2ee7:
	jumpstd pokecenternurse

TeacherScript_0x1a2eea:
	jumptextfaceplayer UnknownText_0x1a2f01

PewterJigglypuff:
	opentext
	writetext PewterJigglypuffText
	cry JIGGLYPUFF
	waitbutton
	closetext
	end

ChildScript_0x1a2ef7:
	jumptextfaceplayer UnknownText_0x1a2f75

Chris:
	faceplayer
	opentext
	trade $4
	waitbutton
	closetext
	end

PokemonJournalBrockScript:
	setflag ENGINE_READ_BROCK_JOURNAL
	jumptext PokemonJournalBrockText

UnknownText_0x1a2f01:
	text "…Yeah, and the"
	line "Gym in Cinnabar's"

	para "gone. I was really"
	line "amazed."

	para "…Yes? I'm on the"
	line "phone. Go away!"
	done

PewterJigglypuffText:
	text "Jigglypuff:"
	line "♪ Puu pupuu. ♪"
	done

UnknownText_0x1a2f75:
	text "Most #mon get"
	line "drowsy if they"

	para "hear a Jigglypuff"
	line "singing."

	para "There are several"
	line "moves that can be"

	para "used only while a"
	line "#mon is asleep."
	done

PokemonJournalBrockText:
	text "#mon Journal"

	para "Special Feature:"
	line "Leader Brock!"

	para "Brock rarely"
	line "laughs, but is"

	para "said to be unable"
	line "to stop if he"
	cont "starts."
	done
