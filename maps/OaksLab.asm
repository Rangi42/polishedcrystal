OaksLab_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

OaksLab_MapEventHeader:

.Warps: db 2
	warp_def 11, 4, 3, PALLET_TOWN
	warp_def 11, 5, 3, PALLET_TOWN

.XYTriggers: db 0

.Signposts: db 16
	signpost 1, 6, SIGNPOST_JUMPSTD, difficultbookshelf
	signpost 1, 7, SIGNPOST_JUMPSTD, difficultbookshelf
	signpost 1, 8, SIGNPOST_JUMPSTD, difficultbookshelf
	signpost 1, 9, SIGNPOST_JUMPSTD, difficultbookshelf
	signpost 7, 0, SIGNPOST_JUMPSTD, difficultbookshelf
	signpost 7, 1, SIGNPOST_JUMPSTD, difficultbookshelf
	signpost 7, 2, SIGNPOST_JUMPSTD, difficultbookshelf
	signpost 7, 3, SIGNPOST_JUMPSTD, difficultbookshelf
	signpost 7, 6, SIGNPOST_JUMPSTD, difficultbookshelf
	signpost 7, 7, SIGNPOST_JUMPSTD, difficultbookshelf
	signpost 7, 8, SIGNPOST_JUMPSTD, difficultbookshelf
	signpost 7, 9, SIGNPOST_JUMPSTD, difficultbookshelf
	signpost 0, 4, SIGNPOST_JUMPTEXT, OaksLabPoster1Text
	signpost 0, 5, SIGNPOST_JUMPTEXT, OaksLabPoster2Text
	signpost 3, 9, SIGNPOST_JUMPTEXT, OaksLabTrashcanText
	signpost 1, 0, SIGNPOST_JUMPTEXT, OaksLabPCText

.PersonEvents: db 8
	person_event SPRITE_OAK, 2, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Oak, -1
	person_event SPRITE_BULBASAUR, 3, 6, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, BulbasaurDollScript, EVENT_DECO_BULBASAUR_DOLL
	person_event SPRITE_CHARMANDER, 3, 7, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CharmanderDollScript, EVENT_DECO_CHARMANDER_DOLL
	person_event SPRITE_SQUIRTLE, 3, 8, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SquirtleDollScript, EVENT_DECO_SQUIRTLE_DOLL
	person_event SPRITE_SCIENTIST, 8, 1, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, OaksAssistant1Text, -1
	person_event SPRITE_SCIENTIST, 9, 8, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, OaksAssistant2Text, -1
	person_event SPRITE_SCIENTIST, 4, 1, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, OaksAssistant3Text, -1
	person_event SPRITE_POKEDEX, 1, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptext, OaksLabPokedexText, -1

const_value set 1
	const OAKSLAB_OAK
	const OAKSLAB_BULBASAUR_DOLL
	const OAKSLAB_CHARMANDER_DOLL
	const OAKSLAB_SQUIRTLE_DOLL

Oak:
	faceplayer
	opentext
	checkevent EVENT_OPENED_MT_SILVER
	iftrue .GiveStarter
	checkevent EVENT_TALKED_TO_OAK_IN_KANTO
	iftrue .GiveStarter
	writetext OakWelcomeKantoText
	buttonsound
	setevent EVENT_TALKED_TO_OAK_IN_KANTO
.GiveStarter:
	checkevent EVENT_GOT_A_POKEMON_FROM_OAK
	iftrue .CheckBadges
	checkevent EVENT_GOT_A_POKEMON_FROM_IVY
	iffalse .CheckBadges
	writetext OakLabGiveStarterText
	buttonsound
	waitsfx
	checkcode VAR_PARTYCOUNT
	if_equal $6, .PartyFull
	checkevent EVENT_GOT_BULBASAUR_FROM_IVY
	iftrue .Charmander
	checkevent EVENT_GOT_CHARMANDER_FROM_IVY
	iftrue .Squirtle
	pokenamemem BULBASAUR, $0
	writetext OakLabReceivedKantoStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	buttonsound
	givepoke BULBASAUR, 10, SITRUS_BERRY
	setevent EVENT_GOT_A_POKEMON_FROM_OAK
	jump .CheckBadges

.Charmander:
	pokenamemem CHARMANDER, $0
	writetext OakLabReceivedKantoStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	buttonsound
	givepoke CHARMANDER, 10, SITRUS_BERRY
	setevent EVENT_GOT_A_POKEMON_FROM_OAK
	jump .CheckBadges

.Squirtle:
	pokenamemem SQUIRTLE, $0
	writetext OakLabReceivedKantoStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	buttonsound
	givepoke SQUIRTLE, 10, SITRUS_BERRY
	setevent EVENT_GOT_A_POKEMON_FROM_OAK
	jump .CheckBadges

.PartyFull:
	writetext OakLabPartyFullText
	waitbutton
.CheckBadges:
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .BattleOak
	checkcode VAR_BADGES
	if_equal 16, .Complain1
	if_equal  8, .Complain2
	writetext OakYesKantoBadgesText
	buttonsound
.CheckPokedex:
	writetext OakLabDexCheckText
	waitbutton
	special ProfOaksPCBoot
	checkevent EVENT_GOT_OVAL_CHARM_FROM_OAK
	iftrue .NoOvalCharm
	checkcode VAR_DEXSEEN
	if_less_than NUM_POKEMON, .NoOvalCharm
	writetext OakLabSeenAllText
	buttonsound
	verbosegiveitem OVAL_CHARM
	setevent EVENT_GOT_OVAL_CHARM_FROM_OAK
	writetext OakLabOvalCharmText
	waitbutton
.NoOvalCharm
	checkevent EVENT_GOT_SHINY_CHARM_FROM_OAK
	iftrue .NoShinyCharm
	checkcode VAR_DEXCAUGHT
	if_less_than NUM_POKEMON, .NoShinyCharm
	writetext OakLabCaughtAllText
	buttonsound
	verbosegiveitem SHINY_CHARM
	setflag ENGINE_HAVE_SHINY_CHARM
	setevent EVENT_GOT_SHINY_CHARM_FROM_OAK
	writetext OakLabShinyCharmText
	waitbutton
.NoShinyCharm
	jumpopenedtext OakLabGoodbyeText

.BattleOak:
	checkevent EVENT_LISTENED_TO_OAK_INTRO
	iftrue .HeardIntro
	writetext OakMightBeReadyText
	waitbutton
	setevent EVENT_LISTENED_TO_OAK_INTRO
.HeardIntro:
	writetext OakChallengeText
	yesorno
	iffalse .NotReady
	writetext OakSeenText
	waitbutton
	closetext
	winlosstext OakWinText, 0
	setlasttalked OAKSLAB_OAK
	loadtrainer PROF_OAK, 1
	startbattle
	reloadmapafterbattle
	opentext
	writetext OakOpenMtSilverText
	buttonsound
	setevent EVENT_BEAT_PROF_OAK
	setevent EVENT_OPENED_MT_SILVER
	jump .CheckPokedex

.NotReady:
	writetext OakRefusedText
	buttonsound
	jump .CheckPokedex

.Complain1:
	writetext OakNoEliteFourRematchText
	buttonsound
	jump .CheckPokedex

.Complain2:
	writetext OakNoKantoBadgesText
	buttonsound
	jump .CheckPokedex

BulbasaurDollScript:
	spriteface OAKSLAB_OAK, RIGHT
	opentext
	writetext ProfOakBulbasaurDollTradeText
	waitbutton
	checkitem LEAF_STONE
	iffalse_jumpopenedtext NoStoneText
	writetext WantToTradeText
	yesorno
	iffalse_jumpopenedtext NoTradeText
	takeitem LEAF_STONE
	disappear OAKSLAB_BULBASAUR_DOLL
	setevent EVENT_DECO_BULBASAUR_DOLL
	writetext BulbasaurDollText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext BulbasaurDollSentText
	waitbutton
	jumpopenedtext ProfOakAfterTradeText

CharmanderDollScript:
	spriteface OAKSLAB_OAK, RIGHT
	opentext
	writetext ProfOakCharmanderDollTradeText
	waitbutton
	checkitem FIRE_STONE
	iffalse_jumpopenedtext NoStoneText
	writetext WantToTradeText
	yesorno
	iffalse_jumpopenedtext NoTradeText
	takeitem FIRE_STONE
	disappear OAKSLAB_CHARMANDER_DOLL
	setevent EVENT_DECO_CHARMANDER_DOLL
	writetext CharmanderDollText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext CharmanderDollSentText
	waitbutton
	jumpopenedtext ProfOakAfterTradeText

SquirtleDollScript:
	spriteface OAKSLAB_OAK, RIGHT
	opentext
	writetext ProfOakSquirtleDollTradeText
	waitbutton
	checkitem WATER_STONE
	iffalse_jumpopenedtext NoStoneText
	writetext WantToTradeText
	yesorno
	iffalse_jumpopenedtext NoTradeText
	takeitem WATER_STONE
	disappear OAKSLAB_SQUIRTLE_DOLL
	setevent EVENT_DECO_SQUIRTLE_DOLL
	writetext SquirtleDollText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext SquirtleDollSentText
	waitbutton
	jumpopenedtext ProfOakAfterTradeText

OakWelcomeKantoText:
	text "Oak: Ah, <PLAYER>!"
	line "It's good of you"

	para "to come all this"
	line "way to Kanto."

	para "What do you think"
	line "of the trainers"

	para "out here?"
	line "Pretty tough, huh?"
	done

OakLabGiveStarterText:
	text "Oak: Oh, so Prof."
	line "Ivy says hello?"

	para "Thanks for convey-"
	line "ing her message,"
	cont "<PLAYER>."

	para "She's a good friend"
	line "of mine."

	para "If she gave you a"
	line "#mon, let me do"
	cont "the same!"

	para "You don't see this"
	line "#mon very often"
	cont "in Kanto or Johto."
	done

OakLabPartyFullText:
	text "Hm, you don't have"
	line "room for it."
	done

OakLabReceivedKantoStarterText:
	text "<PLAYER> received"
	line "@"
	text_from_ram StringBuffer3
	text "!"
	done

OakLabDexCheckText:
	text "How is your #-"
	line "dex coming?"

	para "Let's see…"
	done

OakLabSeenAllText:
	text "You've been meeting"
	line "new #mon at a"

	para "good clip, haven't"
	line "you?"

	para "Take this as a"
	line "reward for your"
	cont "hard work!"
	done

OakLabOvalCharmText:
	text "Holding an Oval"
	line "Charm will improve"

	para "your chances of"
	line "finding an Egg at"
	cont "the Day-Care."
	done

OakLabCaughtAllText:
	text "I was completely"
	line "justified in"

	para "giving you that"
	line "#dex."

	para "It is a testament"
	line "to your effort…"

	para "And to the support"
	line "of the many who"
	cont "helped you…"

	para "And to the bonds"
	line "you have built"
	cont "with your #mon!"

	para "Take this as a"
	line "reward for your"
	cont "hard work!"
	done

OakLabShinyCharmText:
	text "Holding a Shiny"
	line "Charm will improve"

	para "your chances of"
	line "finding a shiny"
	cont "#mon!"
	done

OakLabGoodbyeText:
	text "If you're in the"
	line "area, I hope you"
	cont "come visit again."
	done

OakMightBeReadyText:
	text "Oak: Incredible,"
	line "<PLAYER>!"

	para "You won against"
	line "the Elite Four"
	cont "a second time!"

	para "You just might be"
	line "ready to ascend"
	cont "Mt.Silver."
	done

OakChallengeText:
	text "Oak: Mt.Silver is"
	line "a tall mountain"

	para "that is home to"
	line "many wild #mon."

	para "It's too dangerous"
	line "for your average"

	para "trainer, so it's"
	line "off limits."

	para "I'll need to see"
	line "your skills for"
	cont "myself."

	para "Are you ready for"
	line "a battle?"
	done

OakRefusedText:
	text "Oak: Come back"
	line "when you're ready."
	done

OakSeenText:
	text "Oak: Put every-"
	line "thing you have"
	cont "into this battle!"
	done

OakWinText:
	text "I was right in my"
	line "assessment of you!"
	done

OakOpenMtSilverText:
	text "Oak: Spectacular,"
	line "<PLAYER>!"

	para "I'll make arrange-"
	line "ments so that you"

	para "can go to Mt."
	line "Silver."

	para "It's unusual, but"
	line "we can make an"

	para "exception in your"
	line "case, <PLAYER>."

	para "Go up to Indigo"
	line "Plateau. You can"

	para "reach Mt.Silver"
	line "from there."

	para "…"

	para "I let Red train on"
	line "Mt.Silver after"

	para "his first defeat"
	line "as Champion."

	para "But he hasn't"
	line "come back…"
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
	line "<PLAYER>!"
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
	line "<PLAYER>!"
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
	line "that <PLAYER> is"

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

OaksLabPokedexText:
	text "It's Prof.Oak's"
	line "#dex."
	done
