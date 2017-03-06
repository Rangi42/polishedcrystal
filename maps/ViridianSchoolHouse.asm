const_value set 2
	const VIRIDIANSCHOOLHOUSE_TEACHER
	const VIRIDIANSCHOOLHOUSE_LASS
	const VIRIDIANSCHOOLHOUSE_BOOK
	const VIRIDIANSCHOOLHOUSE_YOUNGSTER
	const VIRIDIANSCHOOLHOUSE_GAMEBOY_KID

ViridianSchoolHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ViridianSchoolHouseTeacherScript:
	jumptextfaceplayer ViridianSchoolHouseTeacherText

ViridianSchoolHouseLassScript:
	jumptextfaceplayer ViridianSchoolHouseLassText

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

ViridianSchoolHouseLassText:
	text "Wait! I thought"
	line "that, like, all"

	para "Fire-type moves"
	line "were special?"
	done

ViridianSchoolHouseNotesText:
	text "There's a doodle"
	line "of a maze."
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

ViridianSchoolHouseBlackboardText:
	text "Physical moves use"
	line "the Attack and"
	cont "Defense stats."

	para "Special moves use"
	line "the Spcl.Atk and"
	cont "Spcl.Def stats."

	para "Status moves are"
	line "not damaging."
	done

ViridianSchoolHouseBookshelfText:
	text "It's full of text-"
	line "books and study"
	cont "guides."
	done

ViridianSchoolHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $9, $2, 8, VIRIDIAN_CITY
	warp_def $9, $3, 8, VIRIDIAN_CITY

.XYTriggers:
	db 0

.Signposts:
	db 3
	signpost 0, 3, SIGNPOST_READ, ViridianSchoolHouseBlackboardScript
	signpost 1, 6, SIGNPOST_READ, ViridianSchoolHouseBookshelfScript
	signpost 1, 7, SIGNPOST_READ, ViridianSchoolHouseBookshelfScript

.PersonEvents:
	db 5
	person_event SPRITE_TEACHER, 1, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ViridianSchoolHouseTeacherScript, -1
	person_event SPRITE_LASS, 4, 3, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ViridianSchoolHouseLassScript, -1
	person_event SPRITE_BOOK, 3, 3, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, ViridianSchoolHouseNotesScript, -1
	person_event SPRITE_YOUNGSTER, 4, 5, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, ViridianSchoolHouseYoungsterScript, -1
	person_event SPRITE_GAMEBOY_KID, 6, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ViridianSchoolHouseGameBoyKidScript, -1
