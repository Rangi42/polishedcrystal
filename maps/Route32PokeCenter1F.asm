Route32PokeCenter1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route32PokeCenter1F_MapEventHeader:

.Warps: db 3
	warp_def $7, $5, 1, ROUTE_32
	warp_def $7, $6, 1, ROUTE_32
	warp_def $7, $0, 1, POKECENTER_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalKurtScript

.PersonEvents: db 4
	person_event SPRITE_NURSE, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_JUMPSTD, 0, pokecenternurse, -1
	person_event SPRITE_FISHING_GURU, 4, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, FishingGuruScript_0x69b55, -1
	person_event SPRITE_COOLTRAINER_F, 2, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x69b80, -1
	person_event SPRITE_POKEFAN_M, 5, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, Route32PokeCenter1FPokefanMScript, -1

FishingGuruScript_0x69b55:
	faceplayer
	opentext
	checkevent EVENT_GOT_OLD_ROD
	iftrue UnknownScript_0x69b7a
	writetext UnknownText_0x69b83
	yesorno
	iffalse UnknownScript_0x69b74
	writetext UnknownText_0x69be8
	buttonsound
	verbosegiveitem OLD_ROD
	writetext UnknownText_0x69c1b
	waitbutton
	closetext
	setevent EVENT_GOT_OLD_ROD
	end

UnknownScript_0x69b74:
	jumpopenedtext UnknownText_0x69c6c

UnknownScript_0x69b7a:
	jumpopenedtext UnknownText_0x69c8d

CooltrainerFScript_0x69b80:
	jumptextfaceplayer UnknownText_0x69cac

Route32PokeCenter1FPokefanMScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_LURE_BALL_FROM_FRENCHMAN
	iftrue .GotLureBall
	writetext Route32PokeCenter1FPokefanMText1
	yesorno
	iftrue .Yes
	writetext Route32PokeCenter1FPokefanMText2
	jump .Continue

.Yes:
	writetext Route32PokeCenter1FPokefanMText3
.Continue
	buttonsound
	verbosegiveitem LURE_BALL
	iffalse .NoRoom
	writetext Route32PokeCenter1FPokefanMText4
	waitbutton
	closetext
	setevent EVENT_GOT_LURE_BALL_FROM_FRENCHMAN
	end

.GotLureBall:
	writetext Route32PokeCenter1FPokefanMText5
	waitbutton
.NoRoom:
	closetext
	end

PokemonJournalKurtScript:
	setflag ENGINE_READ_KURT_JOURNAL
	jumptext PokemonJournalKurtText

UnknownText_0x69b83:
	text "This is a great"
	line "fishing spot."

	para "You saw people"
	line "fishing? How"
	cont "about you?"

	para "Would you like one"
	line "of my Rods?"
	done

UnknownText_0x69be8:
	text "Heh, that's good"
	line "to hear."

	para "Now you're an"
	line "angler too!"
	done

UnknownText_0x69c1b:
	text "Fishing is great!"

	para "If there's water,"
	line "be it the sea or a"

	para "stream, try out"
	line "your Rod."
	done

UnknownText_0x69c6c:
	text "Oh. That's rather"
	line "disappointing…"
	done

UnknownText_0x69c8d:
	text "Yo, kid. How are"
	line "they biting?"
	done

UnknownText_0x69cac:
	text "What should I make"
	line "my #mon hold?"

	para "Maybe an item that"
	line "increases Attack"
	cont "power…"
	done

Route32PokeCenter1FPokefanMText1:
	text "Bonjour. How are"
	line "you? Do you know"
	cont "about Apricorns?"
	done

Route32PokeCenter1FPokefanMText2:
	text "Non? What a waste!"
	line "I will show you"

	para "how great Apri-"
	line "corns are!"
	done

Route32PokeCenter1FPokefanMText3:
	text "Youpi! Way to go!"
	line "I feel so great,"

	para "I want to give you"
	line "this!"
	done

Route32PokeCenter1FPokefanMText4:
	text "This Ball easily"
	line "catches #mon"
	cont "hooked on a Rod!"

	para "Kurt of Azalea"
	line "Town made it from"
	cont "an Apricorn."

	para "Apricorns,"
	line "hourrah!"
	done

Route32PokeCenter1FPokefanMText5:
	text "Kurt is the hero"
	line "of every Apricorn"
	cont "collector."

	para "Apricorns,"
	line "hourrah!"
	done

PokemonJournalKurtText:
	text "#mon Journal"

	para "Special Feature:"
	line "Craftsman Kurt!"

	para "Kurt does not let"
	line "anyone near while"

	para "he is making #"
	line "Balls except his"

	para "granddaughter"
	line "Maizie."
	done
