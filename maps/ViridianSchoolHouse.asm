ViridianSchoolHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

ViridianSchoolHouse_MapEventHeader:

.Warps: db 2
	warp_def $9, $2, 8, VIRIDIAN_CITY
	warp_def $9, $3, 8, VIRIDIAN_CITY

.XYTriggers: db 0

.Signposts: db 3
	signpost 0, 3, SIGNPOST_READ, ViridianSchoolHouseBlackboardScript
	signpost 1, 6, SIGNPOST_READ, ViridianSchoolHouseBookshelfScript
	signpost 1, 7, SIGNPOST_READ, ViridianSchoolHouseBookshelfScript

.PersonEvents: db 6
	person_event SPRITE_GAMEBOY_KID, 6, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ViridianSchoolHouseGameBoyKidScript, -1
	person_event SPRITE_TEACHER, 1, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ViridianSchoolHouseTeacherScript, -1
	person_event SPRITE_LASS, 4, 3, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ViridianSchoolHouseLass1Script, -1
	person_event SPRITE_BOOK_UNOWN_R, 3, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, ViridianSchoolHouseNotesScript, -1
	person_event SPRITE_YOUNGSTER, 4, 5, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, ViridianSchoolHouseYoungsterScript, -1
	person_event SPRITE_LASS, 6, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ViridianSchoolHouseLass2Script, -1

const_value set 2
	const VIRIDIANSCHOOLHOUSE_GAMEBOY_KID

ViridianSchoolHouseTeacherScript:
	jumptextfaceplayer ViridianSchoolHouseTeacherText

ViridianSchoolHouseLass1Script:
	jumptextfaceplayer ViridianSchoolHouseLass1Text

ViridianSchoolHouseNotesScript:
	jumptext ViridianSchoolHouseNotesText

ViridianSchoolHouseYoungsterScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_WEAK_POLICY_FROM_VIRIDIAN
	iftrue .GotItem
	writetext ViridianSchoolHouseYoungsterText1
	buttonsound
	verbosegiveitem WEAK_POLICY
	iffalse .Done
	setevent EVENT_GOT_WEAK_POLICY_FROM_VIRIDIAN
.GotItem:
	writetext ViridianSchoolHouseYoungsterText2
	waitbutton
.Done:
	closetext
	end

ViridianSchoolHouseGameBoyKidScript:
	faceplayer
	opentext
	writetext ViridianSchoolHouseGameBoyKidText
	waitbutton
	closetext
	spriteface VIRIDIANSCHOOLHOUSE_GAMEBOY_KID, DOWN
	end

ViridianSchoolHouseLass2Script:
	jumptextfaceplayer ViridianSchoolHouseLass2Text

ViridianSchoolHouseBlackboardScript:
	jumptext ViridianSchoolHouseBlackboardText

ViridianSchoolHouseBookshelfScript:
	jumptext ViridianSchoolHouseBookshelfText

ViridianSchoolHouseTeacherText:
	text "I know this is a"
	line "lot of material,"

	para "but please pay"
	line "attention!"
	done

ViridianSchoolHouseLass1Text:
	text "Wait! I thought"
	line "that, like, all"

	para "Fire-type moves"
	line "were special?"
	done

ViridianSchoolHouseNotesText:
	text "The page is cover-"
	line "ed in doodles."
	para "A maze, flowers,"
	line "the letter S…"
	done

ViridianSchoolHouseYoungsterText1:
	text "The teacher gave"
	line "me extra copies of"

	para "these. Here,"
	line "take one."
	done

ViridianSchoolHouseYoungsterText2:
	text "“What doesn't KO"
	line "a Pokemon makes"
	cont "it stronger.”"

	para "That's the effect"
	line "of a Weak Policy."
	done

ViridianSchoolHouseGameBoyKidText:
	text "I'm taking notes"
	line "on my phone!"

	para "I'm not goofing"
	line "off! Really!"
	done

ViridianSchoolHouseLass2Text:
	text "I'm in the pro-"
	line "tagonist's seat!"

	para "So why is my life"
	line "so boring?"
	done

ViridianSchoolHouseBlackboardText:
	text "Physical moves use"
	line "the Attack and"
	cont "Defense stats."

	para "Special moves use"
	line "the Spcl.Atk and"
	cont "Spcl.Def stats."

	para "Status moves do"
	line "not cause damage"
	cont "directly."
	done

ViridianSchoolHouseBookshelfText:
	text "It's full of text-"
	line "books and study"
	cont "guides."
	done
