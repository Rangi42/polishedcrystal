AzaleaMart_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

AzaleaMart_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 3, AZALEA_TOWN
	warp_def 7, 3, 3, AZALEA_TOWN

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 5
	mart_clerk_event 3, 1, MARTTYPE_STANDARD, MART_AZALEA
	person_event SPRITE_COOLTRAINER_M, 5, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, AzaleaMartCooltrainermText, -1
	person_event SPRITE_BUG_CATCHER, 2, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, AzaleaMartBugCatcherText, -1
	person_event SPRITE_LADY, 6, 8, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << MORN) | (1 << DAY), (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, AzaleaMartLadyText, -1
	person_event SPRITE_ROCKER, 6, 8, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, (1 << NITE), (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, AzaleaMartRockerText, -1

AzaleaMartCooltrainermText:
	text "There's no Great"
	line "Ball here. #"

	para "Balls will have"
	line "to do."

	para "I wish Kurt would"
	line "make me some of"
	cont "his custom Balls."
	done

AzaleaMartBugCatcherText:
	text "A Great Ball is"
	line "better for catch-"
	cont "ing #mon than a"
	cont "# Ball."

	para "But Kurt's might"
	line "be better some-"
	cont "times."
	done

AzaleaMartLadyText:
	text "I can buy many"
	line "items at home in"
	cont "Goldenrod City,"

	para "but for boosting"
	line "Fire-type moves,"

	para "nothing beats"
	line "Azalea's Charcoal!"
	done

AzaleaMartRockerText:
	text "The prototype"
	line "versions of"

	para "Kurt's balls had"
	line "some problems."

	para "Love Balls used"
	line "to catch same-"
	cont "gender #mon,"

	para "and Fast Balls"
	line "only worked for"

	para "three different"
	line "#mon species."

	para "Thank goodness"
	line "those problems"
	cont "were fixed!"
	done
