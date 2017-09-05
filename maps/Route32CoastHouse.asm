Route32CoastHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route32CoastHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 2, ROUTE_32_COAST
	warp_def 7, 3, 2, ROUTE_32_COAST

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_BAKER, 2, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GourmetManiacScript, -1

GourmetManiacScript:
	faceplayer
	opentext
	writetext .GreetingText
	buttonsound
	special Special_ChooseItem
	iffalse .NoItem
	special GetGourmetManiacPrice
	iffalse .WrongItem
	writetext .OfferText
	special PlaceMoneyTopRight
	yesorno
	iffalse .NoItem
	copybytetovar CurItem
	takeitem ITEM_FROM_MEM
	waitsfx
	playsound SFX_TRANSACTION
	special Give_hMoneyTemp
	special PlaceMoneyTopRight
	jumpopenedtext .ThankYouText

.NoItem:
	jumpopenedtext .NoItemText

.WrongItem:
	jumpopenedtext .WrongItemText

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
	line "¥@"
	deciram hMoneyTemp, 3, 7
	text " for it?"
	done

.ThankYouText:
	text "Merci! Thank you!"

	para "With this, I can"
	line "create something"
	cont "superb."
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
