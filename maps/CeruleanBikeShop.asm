CeruleanBikeShop_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, CERULEAN_CITY, 8
	warp_event  3,  7, CERULEAN_CITY, 8

	def_coord_events

	def_bg_events

	def_object_events
	object_event  1,  2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeruleanBikeShopClerkScript, -1

CeruleanBikeShopClerkScript:
	showtextfaceplayer CeruleanBikeShopClerkText
	turnobject LAST_TALKED, UP
	end

CeruleanBikeShopClerkText:
	text "A long time ago,"
	line "this cool boy rode"
	cont "my Bike around,"

	para "and that started"
	line "a Bicycle boom."

	para "Then I decided to"
	line "open a branch at"
	cont "Goldenrod City."

	para "And they sold"
	line "like the wind!"

	para "But no one comes"
	line "to this shop"
	cont "anymore."

	para "All I have left"
	line "is a bicycle pump…"

	para "Should I sell"
	line "inflatable tubes?"
	done
