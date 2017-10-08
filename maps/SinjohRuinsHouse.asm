SinjohRuinsHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SinjohRuinsHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 2, SINJOH_RUINS
	warp_def 7, 3, 2, SINJOH_RUINS

.XYTriggers: db 0

.Signposts: db 2
	signpost 1, 0, SIGNPOST_JUMPSTD, difficultbookshelf
	signpost 1, 1, SIGNPOST_JUMPSTD, difficultbookshelf

.PersonEvents: db 4
	person_event SPRITE_CYNTHIA, 4, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, SinjohRuinsHouseCynthiaScript, EVENT_SINJOH_RUINS_HOUSE_CYNTHIA
	person_event SPRITE_POKEFAN_M, 3, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, SinjohRuinsHousePokefanmText, -1
	person_event SPRITE_GRAMPS, 4, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, SinjohRuinsHouseGrampsScript, -1
	person_event SPRITE_ABRA, 3, 2, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_POKEMON, ABRA, SinjohRuinsHouseAbraText, -1

const_value set 1
	const SINJOHRUINSHOUSE_CYNTHIA

SinjohRuinsHouseGrampsScript:
	faceplayer
	opentext
	writetext SinjohRuinsHouseGrampsText
	yesorno
	iffalse .No
	writetext SinjohRuinsHouseGrampsYesText
	waitbutton
	closetext
	playsound SFX_WARP_TO
	special FadeOutPalettes
	waitsfx
	warp NEW_BARK_TOWN, 15, 6
	end

.No:
	jumpopenedtext SinjohRuinsHouseGrampsNoText

SinjohRuinsHouseCynthiaScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_CYNTHIA
	iftrue .Beat
	writetext SinjohRuinsHouseCynthiaChallengeText
	yesorno
	iffalse .Refused
	writetext SinjohRuinsHouseCynthiaYesText
	waitbutton
	closetext
	winlosstext SinjohRuinsHouseCynthiaWinText, 0
	setlasttalked SINJOHRUINSHOUSE_CYNTHIA
	loadtrainer CYNTHIA, 2
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CYNTHIA
	opentext
.Beat:
	jumpopenedtext SinjohRuinsHouseCynthiaAfterText

.Refused:
	jumpopenedtext SinjohRuinsHouseCynthiaNoText

SinjohRuinsHousePokefanmText:
	text "A long time ago,"
	line "people used to"

	para "have closer bonds"
	line "with #mon."

	para "Myths and legends"
	line "formed about"
	cont "powerful #mon,"

	para "and those legends"
	line "were carried to"
	cont "different regions."

	para "The ruins here"
	line "have been influ-"
	cont "enced by the"

	para "ancient peoples of"
	line "Alph in Johto and"

	para "Spear Pillar in"
	line "Sinnoh."
	done

SinjohRuinsHouseGrampsText:
	text "You seem so out"
	line "of place, not even"

	para "knowing why you"
	line "are here."

	para "Do you want my"
	line "Abra to Teleport"
	cont "you back home?"
	done

SinjohRuinsHouseGrampsYesText:
	text "OK, OK. Picture"
	line "your house in your"
	cont "mind…"
	done

SinjohRuinsHouseGrampsNoText:
	text "OK, OK. The best"
	line "of luck to you!"
	done

SinjohRuinsHouseAbraText:
	text "Abra: Aabra…"
	done

SinjohRuinsHouseCynthiaChallengeText:
	text "Cynthia: Hello,"
	line "<PLAYER>."

	para "Have you been"
	line "keeping well?"

	para "You won a rematch"
	line "against the Elite"
	cont "Four! Well done!"

	para "I'm curious about"
	line "what you learned"
	cont "since we last met."

	para "Shall we battle"
	line "again, <PLAYER>?"
	done

SinjohRuinsHouseCynthiaNoText:
	text "Cynthia: Come back"
	line "any time if you"
	cont "change your mind."
	done

SinjohRuinsHouseCynthiaYesText:
	text "Cynthia: Before"
	line "I send out my"
	cont "#mon,"

	para "my heart always"
	line "begins to race…"
	done

SinjohRuinsHouseCynthiaWinText:
	text "I can't remember"
	line "the last time I"

	para "was outclassed"
	line "like this!"
	done

SinjohRuinsHouseCynthiaAfterText:
	text "Cynthia: What an"
	line "incredible battle!"

	para "You're a great"
	line "trainer, and it"

	para "would make me"
	line "happy to see you"
	cont "again sometime."
	done
