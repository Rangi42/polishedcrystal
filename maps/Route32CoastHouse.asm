Route32CoastHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, ROUTE_32_COAST, 2
	warp_event  3,  7, ROUTE_32_COAST, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  2, SPRITE_BAKER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GourmetManiacScript, -1

GourmetManiacScript:
	faceplayer
	opentext
	writetext .GreetingText
	promptbutton
	special Special_ChooseItem
	iffalse_jumpopenedtext .NoItemText
	special GetGourmetManiacPrice
	iffalse_jumpopenedtext .WrongItemText
	writetext .OfferText
	special PlaceMoneyTopRight
	yesorno
	iffalse_jumpopenedtext .NoItemText
	readmem wCurItem
	takeitem ITEM_FROM_MEM
	waitsfx
	playsound SFX_TRANSACTION
	special Give_hMoneyTemp
	special PlaceMoneyTopRight
	jumpthisopenedtext

	text "Merci! Thank you!"

	para "With this, I can"
	line "create something"
	cont "superb."
	done

.GreetingText:
	text "Hi there! I am"
	line "a gourmet Baker!"

	para "I cook wonderful"
	line "dishes with only"
	cont "the finest of"
	cont "ingredients!"

	para "Do you have any"
	line "ingredients to"
	cont "sell me?"
	done

.OfferText:
	text "Oh, it smells so"
	line "good!"

	para "Would you accept"
	line "¥"
	text_decimal hMoneyTemp, 3, 7
	text " for it?"
	done

.WrongItemText:
	text "Hmmm… This is not"
	line "quite what I'm"
	cont "looking for."
	done

.NoItemText:
	text "Aww… Well,"
	line "that's OK."
	done
