RedsHouse1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, PALLET_TOWN, 1
	warp_event  3,  7, PALLET_TOWN, 1
	warp_event  7,  0, REDS_HOUSE_2F, 1

	def_coord_events

	def_bg_events
	bg_event  5,  1, BGEVENT_UP, RedsHouse1FTVScript

	def_object_events
	object_event  5,  3, SPRITE_REDS_MOM, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RedsMom, -1

RedsMom:
	checkevent EVENT_MET_REDS_MOM
	iftrue_jumptextfaceplayer .Text2
	setevent EVENT_MET_REDS_MOM
	jumpthistextfaceplayer

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
	jumpthistext

	text "They have programs"
	line "that aren't shown"
	cont "in Johto…"
	done
