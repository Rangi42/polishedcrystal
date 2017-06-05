const_value set 2
	const ECRUTEAKDESTINYKNOTHOUSE_COOLTRAINER_F
	const ECRUTEAKDESTINYKNOTHOUSE_RICH_BOY

EcruteakDestinyKnotHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

EcruteakDestinyKnotHouseCooltrainerFScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_DESTINY_KNOT_FROM_ECRUTEAK
	iftrue .GotItem
	writetext EcruteakDestinyKnotHouseCooltrainerFText1
	buttonsound
	special SpecialBeastsCheck
	iffalse .NotEnough
	special SpecialBirdsCheck
	iffalse .NotEnough
	special SpecialDuoCheck
	iffalse .NotEnough
	writetext EcruteakDestinyKnotHouseCooltrainerFText3
	verbosegiveitem DESTINY_KNOT
	iffalse .Done
.GotItem:
	writetext EcruteakDestinyKnotHouseCooltrainerFText4
	waitbutton
.Done:
	closetext
	end

.NotEnough:
	writetext EcruteakDestinyKnotHouseCooltrainerFText2
	waitbutton
	closetext
	end

EcruteakDestinyKnotHouseRichBoyScript:
	jumptextfaceplayer EcruteakDestinyKnotHouseRichBoyText

DestinyKnotHouseRadio:
	jumpstd radio2

EcruteakDestinyKnotHouseCooltrainerFText1:
	text "Two mighty bird"
	line "#mon of Johto,"

	para "each guarding a"
	line "trio of legendary"
	cont "#mon."

	para "Legends within"
	line "legends…"
	done

EcruteakDestinyKnotHouseCooltrainerFText2:
	text "What if a trainer"
	line "were to catch all"
	cont "of them?"

	para "What an unlikely"
	line "destiny!"
	done

EcruteakDestinyKnotHouseCooltrainerFText3:
	text "What? You've seen"
	line "them? And you even"
	cont "caught them?!"

	para "Let me see your"
	line "#dex… Wow!"

	para "It must have been"
	line "your destiny."

	para "Here, you should"
	line "have this."
	done

EcruteakDestinyKnotHouseCooltrainerFText4:
	text "The red string of"
	line "fate ties you to"

	para "the legendary"
	line "#mon…"

	para "Are you some kind"
	line "of Chosen One?"
	done

EcruteakDestinyKnotHouseRichBoyText:
	text "Gah! I want to"
	line "battle Morty, but"

	para "I just can't figure"
	line "out the pattern"
	cont "on the Gym floor."
	done

EcruteakDestinyKnotHouse_MapEventHeader:
.Warps:
	db 2
	warp_def $7, $3, 17, ECRUTEAK_CITY
	warp_def $7, $4, 17, ECRUTEAK_CITY

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 1, 2, SIGNPOST_READ, DestinyKnotHouseRadio

.PersonEvents:
	db 2
	person_event SPRITE_COOLTRAINER_F, 4, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, EcruteakDestinyKnotHouseCooltrainerFScript, -1
	person_event SPRITE_RICH_BOY, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, EcruteakDestinyKnotHouseRichBoyScript, -1
