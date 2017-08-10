Route27RestHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route27RestHouse_MapEventHeader:

.Warps: db 2
	warp_def $7, $2, 1, ROUTE_27
	warp_def $7, $3, 1, ROUTE_27

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 7, SIGNPOST_JUMPSTD, difficultbookshelf

.PersonEvents: db 1
	person_event SPRITE_GRANNY, 4, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, RestHouseWoman, -1

RestHouseWoman:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM44_REST
	iftrue .AlreadyGotItem
	special GetFirstPokemonHappiness
	writetext RestHouseWomanText1
	buttonsound
	if_greater_than $95, .Loyal
	jump .Disloyal

.Loyal:
	writetext RestHouseWomanLoyalText
	buttonsound
	verbosegivetmhm TM_REST
	setevent EVENT_GOT_TM44_REST
.AlreadyGotItem:
	writetext RestHouseRestDescription
	waitbutton
	closetext
	end

.Disloyal:
	writetext RestHouseWomanDisloyalText
	waitbutton
	closetext
	end

RestHouseWomanText1:
	text "Where are you off"
	line "to with #mon?"

	para "The #mon"
	line "League?"

	para "Are your #mon"
	line "loyal enough for"
	cont "you to win?"

	para "Let me see…"
	done

RestHouseWomanLoyalText:
	text "Ah! Your #mon"
	line "trusts you very"
	cont "much."

	para "It's nice to see a"
	line "good trainer."

	para "Here. A gift for"
	line "your journey."
	done

RestHouseRestDescription:
	text "TM44 happens to be"
	line "Rest."

	para "It's a move that"
	line "regains health,"
	cont "but leaves the"
	cont "user vulnerable."

	para "It's for advanced"
	line "trainers only."

	para "Use it if you"
	line "dare. Good luck!"
	done

RestHouseWomanDisloyalText:
	text "If it doesn't come"
	line "to trust you some"

	para "more, it could be"
	line "tough going."

	para "Trust is the tie"
	line "that binds #mon"
	cont "and trainers."
	done
