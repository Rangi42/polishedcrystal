Route26DayofWeekSiblingsHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, ROUTE_26, 3
	warp_event  3,  7, ROUTE_26, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayOfWeekSiblingsHousePokedexScript, -1

DayOfWeekSiblingsHousePokedexScript:
	opentext
	writetext DayOfWeekSiblingsHousePokedexText1
	yesorno
	iffalse .End
	writetext DayOfWeekSiblingsHousePokedexText2
	yesorno
	iffalse .End
	writetext DayOfWeekSiblingsHousePokedexText3
	waitbutton
.End:
	endtext

DayOfWeekSiblingsHousePokedexText1:
	text "There's something"
	line "written here."

	para "Read it?"
	done

DayOfWeekSiblingsHousePokedexText2:
	text "To my brothers and"
	line "sisters:"

	para "We take pride in"
	line "serving #mon"
	cont "trainers."

	para "When trainers talk"
	line "to you, give them"
	cont "something useful."

	para "Love,"
	line "Monica"

	para "Keep reading?"
	done

DayOfWeekSiblingsHousePokedexText3:
	text "Monday, Monica"
	line "Route 40"

	para "Tuesday, Tuscany"
	line "Route 29"

	para "Wednesday, Wesley"
	line "Lake of Rage"

	para "Thursday, Arthur"
	line "Route 36"

	para "Friday, Frieda"
	line "Route 32"

	para "Saturday, Santos"
	line "Blackthorn City"

	para "Sunday, Sunny"
	line "Route 37"
	done
