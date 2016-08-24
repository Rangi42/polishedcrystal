const_value set 2
	const OAKSLAB_OAK
	const OAKSLAB_SCIENTIST1
	const OAKSLAB_SCIENTIST2
	const OAKSLAB_SCIENTIST3
	const OAKSLAB_BULBASAUR_DOLL
	const OAKSLAB_CHARMANDER_DOLL
	const OAKSLAB_SQUIRTLE_DOLL

OaksLab_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

.DummyTrigger:
	end

Oak:
	faceplayer
	opentext
	checkevent EVENT_OPENED_MT_SILVER
	iftrue .CheckPokedex
	checkevent EVENT_TALKED_TO_OAK_IN_KANTO
	iftrue .CheckBadges
	writetext OakWelcomeKantoText
	buttonsound
	setevent EVENT_TALKED_TO_OAK_IN_KANTO
.CheckBadges:
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .OpenMtSilver
	checkcode VAR_BADGES
	if_equal 16, .Complain1
	if_equal  8, .Complain2
	jump .AhGood

.CheckPokedex:
	writetext OakLabDexCheckText
	waitbutton
	special ProfOaksPCBoot
	writetext OakLabGoodbyeText
	waitbutton
	closetext
	end

.OpenMtSilver:
	writetext OakOpenMtSilverText
	buttonsound
	setevent EVENT_OPENED_MT_SILVER
	jump .CheckPokedex

.Complain1:
	writetext OakNoEliteFourRematchText
	buttonsound
	jump .CheckPokedex

.Complain2:
	writetext OakNoKantoBadgesText
	buttonsound
	jump .CheckPokedex

.AhGood:
	writetext OakYesKantoBadgesText
	buttonsound
	jump .CheckPokedex

BulbasaurDollScript:
	opentext
	writetext ProfOakBulbasaurDollTradeText
	waitbutton
	checkitem LEAF_STONE
	iffalse NoStoneScript
	writetext WantToTradeText
	yesorno
	iffalse NoTradeScript
	takeitem LEAF_STONE
	disappear OAKSLAB_BULBASAUR_DOLL
	setevent EVENT_DECO_BULBASAUR_DOLL
	writetext BulbasaurDollText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext BulbasaurDollSentText
	waitbutton
	writetext ProfOakAfterTradeText
	waitbutton
	closetext
	end

CharmanderDollScript:
	opentext
	writetext ProfOakCharmanderDollTradeText
	waitbutton
	checkitem FIRE_STONE
	iffalse NoStoneScript
	writetext WantToTradeText
	yesorno
	iffalse NoTradeScript
	takeitem FIRE_STONE
	disappear OAKSLAB_CHARMANDER_DOLL
	setevent EVENT_DECO_CHARMANDER_DOLL
	writetext CharmanderDollText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext CharmanderDollSentText
	waitbutton
	writetext ProfOakAfterTradeText
	waitbutton
	closetext
	end

SquirtleDollScript:
	opentext
	writetext ProfOakSquirtleDollTradeText
	waitbutton
	checkitem WATER_STONE
	iffalse NoStoneScript
	writetext WantToTradeText
	yesorno
	iffalse NoTradeScript
	takeitem WATER_STONE
	disappear OAKSLAB_SQUIRTLE_DOLL
	setevent EVENT_DECO_SQUIRTLE_DOLL
	writetext SquirtleDollText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext SquirtleDollSentText
	waitbutton
	writetext ProfOakAfterTradeText
	waitbutton
	closetext
	end

NoStoneScript:
	writetext NoStoneText
	waitbutton
	closetext
	end

NoTradeScript:
	writetext NoTradeText
	waitbutton
	closetext
	end

OaksAssistant1Script:
	jumptextfaceplayer OaksAssistant1Text

OaksAssistant2Script:
	jumptextfaceplayer OaksAssistant2Text

OaksAssistant3Script:
	jumptextfaceplayer OaksAssistant3Text

OaksLabBookshelf:
	jumpstd difficultbookshelf

OaksLabPoster1:
	jumptext OaksLabPoster1Text

OaksLabPoster2:
	jumptext OaksLabPoster2Text

OaksLabTrashcan:
	jumptext OaksLabTrashcanText

OaksLabPC:
	jumptext OaksLabPCText

OakWelcomeKantoText:
	text "Oak: Ah, <PLAY_G>!"
	line "It's good of you"

	para "to come all this"
	line "way to Kanto."

	para "What do you think"
	line "of the trainers"

	para "out here?"
	line "Pretty tough, huh?"
	done

OakLabDexCheckText:
	text "How is your #-"
	line "dex coming?"

	para "Let's see…"
	done

OakLabGoodbyeText:
	text "If you're in the"
	line "area, I hope you"
	cont "come visit again."
	done

OakOpenMtSilverText:
	text "Oak: Incredible,"
	line "<PLAY_G>!"

	para "You won against"
	line "the Elite Four"
	cont "a second time!"

	para "I was right in my"
	line "assessment of you."

	para "Tell you what,"
	line "<PLAY_G>. I'll make"

	para "arrangements so"
	line "that you can go to"
	cont "Mt.Silver."

	para "Mt.Silver is a big"
	line "mountain that is"

	para "home to many wild"
	line "#mon."

	para "It's too dangerous"
	line "for your average"

	para "trainer, so it's"
	line "off limits. But"

	para "we can make an"
	line "exception in your"
	cont "case, <PLAY_G>."

	para "Go up to Indigo"
	line "Plateau. You can"

	para "reach Mt.Silver"
	line "from there."
	done

OakNoKantoBadgesText:
	text "Oak: Hmm? You're"
	line "not collecting"
	cont "Kanto Gym Badges?"

	para "The Gym Leaders in"
	line "Kanto are as tough"

	para "as any you battled"
	line "in Johto."

	para "I recommend that"
	line "you challenge"
	cont "them."
	done

OakNoEliteFourRematchText:
	text "Oak: Wow! That's"
	line "excellent!"

	para "You collected the"
	line "Badges of Gyms in"
	cont "Kanto. Well done!"

	para "Now you can cha-"
	line "llenge the Elite"

	para "Four with their"
	line "best #mon."

	para "Keep trying hard,"
	line "<PLAY_G>!"
	done

OakYesKantoBadgesText:
	text "Oak: Ah, you're"
	line "collecting Kanto"
	cont "Gym Badges."

	para "I imagine that"
	line "it's hard, but the"

	para "experience is sure"
	line "to help you."

	para "After you earn all"
	line "eight, you can"
	cont "challenge the"

	para "Elite Four at"
	line "their best."

	para "Keep trying hard,"
	line "<PLAY_G>!"
	done

OaksAssistant1Text:
	text "The Prof's #mon"
	line "Talk radio program"

	para "isn't aired here"
	line "in Kanto."

	para "It's a shame--I'd"
	line "like to hear it."
	done

OaksAssistant2Text:
	text "Thanks to your"
	line "work on the #-"
	cont "dex, the Prof's"

	para "research is coming"
	line "along great."
	done

OaksAssistant3Text:
	text "Don't tell anyone,"
	line "but Prof.Oak's"

	para "#mon Talk isn't"
	line "a live broadcast."
	done

OaksLabPoster1Text:
	text "Press Start to"
	line "open the Menu."
	done

OaksLabPoster2Text:
	text "The Save option is"
	line "on the Menu."

	para "Use it in a timely"
	line "manner."
	done

OaksLabTrashcanText
	text "There's nothing in"
	line "here…"
	done

OaksLabPCText:
	text "There's an e-mail"
	line "message on the PC."

	para "…"

	para "Prof.Oak, how is"
	line "your research"
	cont "coming along?"

	para "I'm still plugging"
	line "away."

	para "I heard rumors"
	line "that <PLAY_G> is"

	para "getting quite a"
	line "reputation."

	para "I'm delighted to"
	line "hear that."

	para "Elm in New Bark"
	line "Town 8-)"
	done

ProfOakBulbasaurDollTradeText:
	text "Oak: Oh, are you"
	line "admiring my"
	cont "Bulbasaur doll?"

	para "I'll trade it"
	line "to you for a"
	cont "Leaf Stone."
	done

ProfOakCharmanderDollTradeText:
	text "Oak: Oh, are you"
	line "admiring my"
	cont "Charmander doll?"

	para "I'll trade it"
	line "to you for a"
	cont "Fire Stone."
	done

ProfOakSquirtleDollTradeText:
	text "Oak: Oh, are you"
	line "admiring my"
	cont "Squirtle doll?"

	para "I'll trade it"
	line "to you for a"
	cont "Water Stone."
	done

NoStoneText:
	text "But you don't have"
	line "one of those…"
	done

WantToTradeText:
	text "Do you want to"
	line "trade?"
	done

NoTradeText:
	text "It will still be"
	line "here if you change"
	cont "your mind."
	done

BulbasaurDollText:
	text "<PLAYER> received"
	line "Bulbasaur Doll."
	done

BulbasaurDollSentText:
	text "Bulbasaur Doll"
	line "was sent home."
	done

CharmanderDollText:
	text "<PLAYER> received"
	line "Charmander Doll."
	done

CharmanderDollSentText:
	text "Charmander Doll"
	line "was sent home."
	done

SquirtleDollText:
	text "<PLAYER> received"
	line "Squirtle Doll."
	done

SquirtleDollSentText:
	text "Squirtle Doll"
	line "was sent home."
	done

ProfOakAfterTradeText:
	text "Prof.Oak: Set it"
	line "somewhere you can"
	cont "appreciate it!"
	done

OaksLab_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $b, $4, 3, PALLET_TOWN
	warp_def $b, $5, 3, PALLET_TOWN

.XYTriggers:
	db 0

.Signposts:
	db 16
	signpost 1, 6, SIGNPOST_READ, OaksLabBookshelf
	signpost 1, 7, SIGNPOST_READ, OaksLabBookshelf
	signpost 1, 8, SIGNPOST_READ, OaksLabBookshelf
	signpost 1, 9, SIGNPOST_READ, OaksLabBookshelf
	signpost 7, 0, SIGNPOST_READ, OaksLabBookshelf
	signpost 7, 1, SIGNPOST_READ, OaksLabBookshelf
	signpost 7, 2, SIGNPOST_READ, OaksLabBookshelf
	signpost 7, 3, SIGNPOST_READ, OaksLabBookshelf
	signpost 7, 6, SIGNPOST_READ, OaksLabBookshelf
	signpost 7, 7, SIGNPOST_READ, OaksLabBookshelf
	signpost 7, 8, SIGNPOST_READ, OaksLabBookshelf
	signpost 7, 9, SIGNPOST_READ, OaksLabBookshelf
	signpost 0, 4, SIGNPOST_READ, OaksLabPoster1
	signpost 0, 5, SIGNPOST_READ, OaksLabPoster2
	signpost 3, 9, SIGNPOST_READ, OaksLabTrashcan
	signpost 1, 0, SIGNPOST_READ, OaksLabPC

.PersonEvents:
	db 7
	person_event SPRITE_OAK, 2, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Oak, -1
	person_event SPRITE_SCIENTIST, 8, 1, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, OaksAssistant1Script, -1
	person_event SPRITE_SCIENTIST, 9, 8, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, OaksAssistant2Script, -1
	person_event SPRITE_SCIENTIST, 4, 1, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, OaksAssistant3Script, -1
	person_event SPRITE_BULBASAUR, 3, 6, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, BulbasaurDollScript, EVENT_DECO_BULBASAUR_DOLL
	person_event SPRITE_CHARMANDER, 3, 7, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CharmanderDollScript, EVENT_DECO_CHARMANDER_DOLL
	person_event SPRITE_SQUIRTLE, 3, 8, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SquirtleDollScript, EVENT_DECO_SQUIRTLE_DOLL
