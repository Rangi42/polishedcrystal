CeruleanBikeShop_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, CERULEAN_CITY, 8
	warp_event  3,  7, CERULEAN_CITY, 8

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  1,  2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, CeruleanBikeShopClerkScript, -1

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
