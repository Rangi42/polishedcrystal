EcruteakLugiaSpeechHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 7, 3, 7, ECRUTEAK_CITY
	warp_def 7, 4, 7, ECRUTEAK_CITY

	db 0 ; xy triggers

	db 1 ; signposts
	signpost 1, 2, SIGNPOST_JUMPSTD, radio2

	db 2 ; person events
	person_event SPRITE_GRAMPS, 3, 2, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9933d, -1
	person_event SPRITE_YOUNGSTER, 4, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x993ec, -1

UnknownText_0x9933d:
	text "This happened when"
	line "I was young."

	para "The sky suddenly"
	line "turned black. A"

	para "giant flying #-"
	line "mon was blocking"
	cont "out the sun."

	para "I wonder what that"
	line "#mon was?"

	para "It was like a bird"
	line "and a dragon."
	done

UnknownText_0x993ec:
	text "Is there really a"
	line "#mon that big?"

	para "If it exists, it"
	line "must be powerful."
	done
