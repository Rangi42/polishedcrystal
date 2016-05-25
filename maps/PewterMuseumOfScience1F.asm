const_value set 2

PewterMuseumOfScience1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

; TODO: make this work with xy triggers
Museum1FFeeScript1:
	applymovement PLAYER, Museum1F_WalkUpToReceptionistMovementData
Museum1FFeeScript2:
	spriteface PLAYER, RIGHT
	opentext
	writetext Museum1FWelcomeText
	yesorno
	iftrue Museum1FPayFeeScript
	writetext Museum1FComeAgainText
	waitbutton
	closetext
	applymovement PLAYER, Museum1F_WalkDownMovementData
	end

Museum1FPayFeeScript:
	; TODO: pay $50
	writetext Museum1FThankYouText
	waitbutton
	closetext

Museum1F_WalkUpToReceptionistMovementData:
	turn_head_right
	step_right
	step_end

Museum1F_WalkDownMovementData:
	turn_head_down
	step_down
	step_end

Museum1FReceptionistScript:
	jumptextfaceplayer Museum1FReceptionistText

Museum1FScientistScript:
	jumptextfaceplayer Museum1FScientistText

Museum1FFossilScientistScript:
	; TODO: resurrect fossils
	jumptextfaceplayer Museum1FFossilScientistText

Museum1FGrampsScript:
	jumptextfaceplayer Museum1FGrampsText

Museum1FReceptionistDeskSignpostScript:
	jumptext Museum1FReceptionistDeskSignpostText

AerodactylFossilSignpostScript:
	; TODO: show fossil sprite
	jumptext AerodactylFossilSignpostText

KabutopsFossilSignpostScript:
	; TODO: show fossil sprite
	jumptext KabutopsFossilSignpostText

Museum1FBookshelfSignpostScript:
	jumptext Museum1FBookshelfSignpostText

Museum1FWelcomeText:
	text "It's $50 for a"
	line "child's ticket."

	para "Would you like to"
	line "come in?"
	done

Museum1FThankYouText:
	text "Right, $50!"
	line "Thank you!"
	done

Museum1FComeAgainText:
	text "Come again!"
	done

Museum1FReceptionistText:
	text "You can't sneak"
	line "in the back way!"
	done

Museum1FScientistText:
	text "We are proud of"
	line "two fossils of"
	cont "rare, prehistoric"
	cont "#mon!"
	done

Museum1FFossilScientistText:
	text "Did you know that"
	line "you can extract"
	cont "#mon from"
	cont "fossils?"

	para "If you ever need"
	line "to, let me take"
	cont "care of it!"
; Hey! You don't have any fossils.
; I heard that sometimes you find fossils when you smash rocks at the Ruins of Alph and other places.
	done

Museum1FGrampsText:
	text "That is one"
	line "magnificent"
	cont "fossil!"
	done

Museum1FReceptionistDeskSignpostText:
	text "Take plenty of"
	line "time to look!"
	done

AerodactylFossilSignpostText:
	text "Aerodactyl Fossil"

	para "A primitive and"
	line "rare Pokémon."
	done

KabutopsFossilSignpostText:
	text "Kabutops Fossil"

	para "A primitive and"
	line "rare Pokémon."
	done

Museum1FBookshelfSignpostText:
	text "Thick and well-"
	line "read books!"

	para "Archaeology Man-"
	line "ual, Lost #mon,"
	cont "#mon Ancestors,"

	para "Caring at the"
	line "Loamy Layer of"
	cont "Kanto..."
	done

PewterMuseumOfScience1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 5
	warp_def $7, $a, 6, PEWTER_CITY
	warp_def $7, $b, 6, PEWTER_CITY
	warp_def $7, $10, 7, PEWTER_CITY
	warp_def $7, $11, 7, PEWTER_CITY
	warp_def $7, $7, 1, PEWTER_MUSEUM_OF_SCIENCE_2F

.XYTriggers:
	db 0

.Signposts:
	db 9
	signpost 4, 11, SIGNPOST_READ, Museum1FReceptionistDeskSignpostScript
	signpost 3, 2, SIGNPOST_READ, AerodactylFossilSignpostScript
	signpost 6, 2, SIGNPOST_READ, KabutopsFossilSignpostScript
	signpost 1, 12, SIGNPOST_READ, Museum1FBookshelfSignpostScript
	signpost 1, 13, SIGNPOST_READ, Museum1FBookshelfSignpostScript
	signpost 1, 14, SIGNPOST_READ, Museum1FBookshelfSignpostScript
	signpost 1, 15, SIGNPOST_READ, Museum1FBookshelfSignpostScript
	signpost 1, 16, SIGNPOST_READ, Museum1FBookshelfSignpostScript
	signpost 1, 17, SIGNPOST_READ, Museum1FBookshelfSignpostScript

.PersonEvents:
	db 4
	person_event SPRITE_RECEPTIONIST, 4, 12, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Museum1FReceptionistScript, -1
	person_event SPRITE_SCIENTIST, 2, 16, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Museum1FScientistScript, -1
	person_event SPRITE_SCIENTIST, 3, 18, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Museum1FFossilScientistScript, -1
	person_event SPRITE_GRAMPS, 4, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Museum1FGrampsScript, -1
