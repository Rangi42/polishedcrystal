RedsHouse1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

RedsHouse1F_MapEventHeader:

.Warps: db 3
	warp_def 7, 2, 1, PALLET_TOWN
	warp_def 7, 3, 1, PALLET_TOWN
	warp_def 0, 7, 1, REDS_HOUSE_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 5, SIGNPOST_UP, RedsHouse1FTVScript

.PersonEvents: db 1
	person_event SPRITE_REDS_MOM, 3, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, RedsMom, -1

RedsMom:
	checkevent EVENT_MET_REDS_MOM
	iftrue_jumptextfaceplayer .Text2
	setevent EVENT_MET_REDS_MOM
	thistextfaceplayer

	text "Hi!"

	para "Red's been away"
	line "for a long time."

	para "He hasn't called"
	line "either, so I have"

	para "no idea where he"
	line "is or what he's"
	cont "been doing."

	para "They say that no"
	line "word is proof that"

	para "he's doing fine,"
	line "but I do worry"
	cont "about him."
	done

.Text2:
	text "I worry about Red"
	line "getting hurt or"

	para "sick, but he's a"
	line "boy. I'm proud"

	para "that he is doing"
	line "what he wants to"

	para "do."
	done

RedsHouse1FTVScript:
	thistext

	text "They have programs"
	line "that aren't shown"
	cont "in Johto…"
	done
