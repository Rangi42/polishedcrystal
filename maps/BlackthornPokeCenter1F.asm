const_value set 2
	const BLACKTHORNPOKECENTER1F_NURSE
	const BLACKTHORNPOKECENTER1F_GENTLEMAN
	const BLACKTHORNPOKECENTER1F_TWIN
	const BLACKTHORNPOKECENTER1F_COOLTRAINER_M

BlackthornPokeCenter1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

NurseScript_0x195b79:
	jumpstd pokecenternurse

GentlemanScript_0x195b7c:
	jumptextfaceplayer UnknownText_0x195b85

TwinScript_0x195b7f:
	jumptextfaceplayer UnknownText_0x195bfd

CooltrainerMScript_0x195b82:
	jumpstd happinesschecknpc

ProfOaksAide3Script:
	faceplayer
	opentext
	checkevent EVENT_GOT_LUCKY_EGG_FROM_PROF_OAKS_AIDE
	iftrue .Explain
	writetext ProfOaksAide3HiText
	waitbutton
	count_caught
	checkcode VAR_DEXCAUGHT
	if_greater_than 49, .HereYouGo
.UhOh
	writetext ProfOaksAide3UhOhText
	waitbutton
	closetext
	end

.HereYouGo
	writetext ProfOaksAide3HereYouGoText
	waitbutton
	giveitem LUCKY_EGG
	waitsfx
	iffalse .NoRoom
	writetext ProfOaksAide3LuckyEggText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	setevent EVENT_GOT_LUCKY_EGG_FROM_PROF_OAKS_AIDE
.Explain
	writetext ProfOaksAide3ExplainText
	waitbutton
	closetext
	end

.NoRoom
	writetext ProfOaksAide3NoRoomText
	waitbutton
	closetext
	end

UnknownText_0x195b85:
	text "Deep inside far-"
	line "off Indigo Plateau"

	para "is the #mon"
	line "League."

	para "I hear the best"
	line "trainers gather"

	para "there from around"
	line "the country."
	done

UnknownText_0x195bfd:
	text "There was this"
	line "move I just had"

	para "to teach my #-"
	line "mon."

	para "So I got the Move"
	line "Deleter to make it"
	cont "forget an HM move."
	done

ProfOaksAide3HiText:
	text "Hello there! I'm"
	line "Prof.Oak's aide."

	para "If you caught 50"
	line "kinds of #mon,"

	para "I'm supposed to"
	line "give you an item."

	para "So, <PLAYER>,"
	line "have you caught"

	para "at least 50 kinds"
	line "of #mon?"
	done

ProfOaksAide3UhOhText:
	text "Let's see…"
	line "Uh-oh! You've only"

	para "caught @"
	deciram wd002, 1, 3
	text " kinds"
	line "of #mon."

	para "Come back and see"
	line "me when you catch"
	cont "50 kinds."
	done

ProfOaksAide3HereYouGoText:
	text "Let's see…"
	line "Great job! You've"

	para "caught @"
	deciram wd002, 1, 3
	text " kinds"
	line "of #mon."

	para "Congratulations!"
	line "Here you go!"
	done

ProfOaksAide3NoRoomText:
	text "Oh! I see you"
	line "don't have any"
	cont "room for this."
	done

ProfOaksAide3LuckyEggText:
	text "<PLAYER> received"
	line "Lucky Egg."
	done

ProfOaksAide3ExplainText:
	text "That Lucky Egg"
	line "helps a #mon"

	para "gain more exper-"
	line "ience than usual."

	para "Use it to com-"
	line "plete the #dex!"
	done

BlackthornPokeCenter1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $7, $5, 5, BLACKTHORN_CITY
	warp_def $7, $6, 5, BLACKTHORN_CITY
	warp_def $7, $0, 1, POKECENTER_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 5
	person_event SPRITE_NURSE, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, NurseScript_0x195b79, -1
	person_event SPRITE_GENTLEMAN, 4, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GentlemanScript_0x195b7c, -1
	person_event SPRITE_TWIN, 4, 1, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, TwinScript_0x195b7f, -1
	person_event SPRITE_COOLTRAINER_M, 6, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CooltrainerMScript_0x195b82, -1
	person_event SPRITE_SCIENTIST, 1, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ProfOaksAide3Script, -1
