const_value set 2
	const ROUTE32COASTHOUSE_BAKER

Route32CoastHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

;GourmetManiacScript:
;	end
;
;GourmetManiacGreetingText:
;	text "Hi there! I am"
;	line "a gourmet Baker!"
;
;	para "I cook wonderful"
;	line "dishes with only"
;	cont "the finest of"
;	cont "ingredients!"
;
;	para "Do you have any"
;	line "ingredients to"
;	cont "sell me?"
;	done
;
;GourmetManiacOfferText:
;	text "Oh, it smells so"
;	line "good!"
;
;	para "Would you accept"
;	line "$12345 for it?"
;	done
;
;GourmetManiacThankYouText:
;	text "Merci! Thank you!"
;	para "With this, I can"
;	line "create something"
;	cont "superb."
;	done
;
;GourmetManiacWrongItemText:
;	text "Hmmm… This is not"
;	line "quite what I'm"
;	cont "looking for."
;	done
;
;GourmetManiacNoItemText:
;	text "Aww… Well,"
;	line "that's OK."
;	done
;
;GourmetManiacItemRewards:
;	dbw ORAN_BERRY, 20
;	dbw SITRUS_BERRY, 20
;	dbw PECHA_BERRY, 20
;	dbw RAWST_BERRY, 20
;	dbw CHERI_BERRY, 20
;	dbw CHESTO_BERRY, 20
;	dbw ASPEAR_BERRY, 20
;	dbw PERSIM_BERRY, 20
;	dbw LUM_BERRY, 20
;	dbw LEPPA_BERRY, 20
;	dbw FRESH_WATER, 200
;	dbw SODA_POP, 300
;	dbw LEMONADE, 350
;	dbw MOOMOO_MILK, 500
;	dbw RAGECANDYBAR, 6000
;	dbw RARE_CANDY, 10000
;	dbw STICK, 200
;	dbw LEFTOVERS, 200
;	dbw LUCKY_EGG, 200
;	dbw TINYMUSHROOM, 500
;	dbw BIG_MUSHROOM, 5000
;	dbw BALMMUSHROOM, 25000
;	dbw SWEET_HONEY, 500
;	db -1

Route32CoastHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 2, ROUTE_32_COAST
	warp_def $7, $3, 2, ROUTE_32_COAST

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
;	person_event SPRITE_BAKER, 2, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GourmetManiacScript, -1
