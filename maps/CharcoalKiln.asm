CharcoalKiln_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CharcoalKiln_MapEventHeader:

.Warps: db 2
	warp_def $7, $3, 2, AZALEA_TOWN
	warp_def $7, $4, 2, AZALEA_TOWN

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	person_event SPRITE_BLACK_BELT, 4, 1, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CharcoalKilnBoss, EVENT_CHARCOAL_KILN_BOSS
	person_event SPRITE_YOUNGSTER, 3, 4, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CharcoalKilnApprentice, EVENT_CHARCOAL_KILN_APPRENTICE
	person_event SPRITE_FARFETCH_D, 6, 8, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CharcoalKilnFarfetchd, EVENT_CHARCOAL_KILN_FARFETCH_D

CharcoalKilnBoss:
	faceplayer
	opentext
	checkevent EVENT_GOT_HM01_CUT
	iftrue .GotCut
	checkevent EVENT_CLEARED_SLOWPOKE_WELL
	iftrue .SavedSlowpoke
	jumpopenedtext .Text1

.SavedSlowpoke:
	jumpopenedtext .Text2

.GotCut:
	jumpopenedtext .Text3

.Text1:
	text "All the Slowpoke"
	line "have disappeared"
	cont "from the town."

	para "The forest's pro-"
	line "tector may be"
	cont "angry with us…"

	para "It may be a bad"
	line "omen. We should"
	cont "stay in."
	done

.Text2:
	text "The Slowpoke have"
	line "returned…"

	para "But my Apprentice"
	line "hasn't come back"
	cont "from Ilex Forest."

	para "Where in the world"
	line "is that lazy guy?"
	done

.Text3:
	text "You chased off"
	line "Team Rocket and"

	para "went to Ilex"
	line "Forest alone?"

	para "That takes guts!"
	line "I like that. Come"
	cont "train with us."
	done

CharcoalKilnApprentice:
	faceplayer
	opentext
	checkevent EVENT_GOT_CHARCOAL_IN_CHARCOAL_KILN
	iftrue .YoureTheCoolest
	checkevent EVENT_GOT_HM01_CUT
	iftrue .Thanks
	jumpopenedtext .Text1

.Thanks:
	writetext .Text2
	buttonsound
	verbosegiveitem CHARCOAL
	iffalse .Done
	setevent EVENT_GOT_CHARCOAL_IN_CHARCOAL_KILN
.Done:
	closetext
	end

.YoureTheCoolest:
	jumpopenedtext .Text3

.Text1:
	text "Where have all the"
	line "Slowpoke gone?"

	para "Are they out play-"
	line "ing somewhere?"
	done

.Text2:
	text "I'm sorry--I for-"
	line "got to thank you."

	para "This is Charcoal"
	line "that I made."

	para "Fire-type #mon"
	line "would be happy to"
	cont "hold that."
	done

.Text3:
	text "The Slowpoke came"
	line "back, and you even"
	cont "found Farfetch'd."

	para "You're the cool-"
	line "est, man!"
	done

CharcoalKilnFarfetchd:
	faceplayer
	opentext
	writetext .Text
	cry FARFETCH_D
	waitbutton
	closetext
	end

.Text:
	text "Farfetch'd: Kwaa!"
	done
