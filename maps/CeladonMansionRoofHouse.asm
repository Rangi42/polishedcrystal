CeladonMansionRoofHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonMansionRoofHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 3, CELADON_MANSION_ROOF
	warp_def 7, 3, 3, CELADON_MANSION_ROOF

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_PHARMACIST, 2, 3, SPRITEMOVEDATA_STANDING_DOWN, 2, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CeladonMansionRoofHousePharmacistScript, -1

CeladonMansionRoofHousePharmacistScript:
	checkevent EVENT_GOT_TM03_CURSE
	iftrue_jumptextfaceplayer .CurseText
	faceplayer
	opentext
	writetext .IntroText
	buttonsound
	checknite
	iffalse_jumpopenedtext .NotNiteText
	writetext .StoryText
	buttonsound
	verbosegivetmhm TM_CURSE
	setevent EVENT_GOT_TM03_CURSE
	thisopenedtext

.CurseText:
	text "TM03 is Curse."

	para "It's a terrifying"
	line "move that slowly"

	para "whittles down the"
	line "victim's HP."
	done

.IntroText:
	text "Let me recount a"
	line "terrifying tale…"
	done

.NotNiteText:
	text "Then again, it's"
	line "not as scary while"

	para "it's still light"
	line "outside."

	para "Come back after"
	line "sunset, OK?"
	done

.StoryText:
	text "Once upon a time,"
	line "there was a little"

	para "boy who was given"
	line "a new Bicycle…"

	para "He wanted to try"
	line "it right away…"

	para "He was having so"
	line "much fun that he"

	para "didn't notice the"
	line "sun had set…"

	para "While riding home"
	line "in the pitch-black"

	para "night, the bike"
	line "suddenly slowed!"

	para "The pedals became"
	line "heavy!"

	para "When he stopped"
	line "pedaling, the bike"

	para "began slipping"
	line "backwards!"

	para "It was as if the"
	line "bike were cursed"

	para "and trying to drag"
	line "him into oblivion!"

	para "…"

	para "…"

	para "SHRIEEEEK!"

	para "The boy had been"
	line "riding uphill on"
	cont "Cycling Road!"

	para "…"
	line "Ba-dum ba-dum!"

	para "For listening so"
	line "patiently, you may"
	cont "take this--TM03!"
	done
