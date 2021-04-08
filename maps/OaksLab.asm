OaksLab_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4, 11, PALLET_TOWN, 3
	warp_event  5, 11, PALLET_TOWN, 3

	def_coord_events

	def_bg_events
	bg_event  6,  1, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  7,  1, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  8,  1, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  9,  1, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  0,  7, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  1,  7, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  2,  7, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  3,  7, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  6,  7, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  7,  7, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  8,  7, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  9,  7, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  4,  0, BGEVENT_JUMPTEXT, OaksLabPoster1Text
	bg_event  5,  0, BGEVENT_JUMPTEXT, OaksLabPoster2Text
	bg_event  9,  3, BGEVENT_JUMPTEXT, OaksLabTrashcanText
	bg_event  0,  1, BGEVENT_JUMPTEXT, OaksLabPCText

	def_object_events
	object_event  4,  2, SPRITE_OAK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Oak, -1
	object_event  7,  3, SPRITE_MON_ICON, SPRITEMOVEDATA_STILL, 0, EEVEE, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, EeveeDollScript, EVENT_DECO_EEVEE_DOLL
	object_event  1,  8, SPRITE_AROMA_LADY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OaksAssistant1Text, -1
	object_event  8,  9, SPRITE_SCIENTIST, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OaksAssistant2Text, -1
	object_event  1,  4, SPRITE_SCIENTIST, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OaksAssistant3Text, -1
	object_event  2,  1, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptext, OaksLabPokedexText, -1

	object_const_def
	const OAKSLAB_OAK
	const OAKSLAB_EEVEE_DOLL

Oak:
	faceplayer
	opentext
	checkevent EVENT_OPENED_MT_SILVER
	iftrue .GiveStarter
	checkevent EVENT_TALKED_TO_OAK_IN_KANTO
	iftrue .GiveStarter
	writetext OakWelcomeKantoText
	promptbutton
	setevent EVENT_TALKED_TO_OAK_IN_KANTO
.GiveStarter:
	checkevent EVENT_GOT_A_POKEMON_FROM_OAK
	iftrue .CheckBadges
	checkevent EVENT_GOT_A_POKEMON_FROM_IVY
	iffalse .CheckBadges
	writetext OakLabGiveStarterText
	promptbutton
	waitsfx
	checkevent EVENT_GOT_BULBASAUR_FROM_IVY
	iftrue .Charmander
	checkevent EVENT_GOT_CHARMANDER_FROM_IVY
	iftrue .Squirtle
	givepoke BULBASAUR, NO_FORM, 10, SITRUS_BERRY
	iffalse .PartyAndBoxFull
	setevent EVENT_GOT_A_POKEMON_FROM_OAK
	sjump .CheckBadges

.Charmander:
	givepoke CHARMANDER, NO_FORM, 10, SITRUS_BERRY
	iffalse .PartyAndBoxFull
	setevent EVENT_GOT_A_POKEMON_FROM_OAK
	sjump .CheckBadges

.Squirtle:
	givepoke SQUIRTLE, NO_FORM, 10, SITRUS_BERRY
	iffalse .PartyAndBoxFull
	setevent EVENT_GOT_A_POKEMON_FROM_OAK
	sjump .CheckBadges

.PartyAndBoxFull:
	writetext OakLabPartyAndBoxFullText
	waitbutton
.CheckBadges:
	checkevent EVENT_OPENED_MT_SILVER
	iftrue .CheckPokedex
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .BattleOak
	readvar VAR_BADGES
	ifequal 16, .Complain1
	ifequal  8, .Complain2
	writetext OakYesKantoBadgesText
	promptbutton
.CheckPokedex:
	writetext OakLabDexCheckText
	waitbutton
	special ProfOaksPCBoot
	checkevent EVENT_GOT_OVAL_CHARM_FROM_OAK
	iftrue .NoOvalCharm
	readvar VAR_DEXSEEN
	ifless NUM_POKEMON, .NoOvalCharm
	writetext OakLabSeenAllText
	promptbutton
	verbosegivekeyitem OVAL_CHARM
	setevent EVENT_GOT_OVAL_CHARM_FROM_OAK
	writetext OakLabOvalCharmText
	waitbutton
.NoOvalCharm
	checkevent EVENT_GOT_SHINY_CHARM_FROM_OAK
	iftrue .NoShinyCharm
	readvar VAR_DEXCAUGHT
	ifless NUM_POKEMON, .NoShinyCharm
	writetext OakLabCaughtAllText
	promptbutton
	verbosegivekeyitem SHINY_CHARM
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
	promptbutton
	setevent EVENT_BEAT_PROF_OAK
	setevent EVENT_OPENED_MT_SILVER
	sjump .CheckPokedex

.NotReady:
	writetext OakRefusedText
	promptbutton
	sjump .CheckPokedex

.Complain1:
	writetext OakNoEliteFourRematchText
	promptbutton
	sjump .CheckPokedex

.Complain2:
	writetext OakNoKantoBadgesText
	promptbutton
	sjump .CheckPokedex

EeveeDollScript:
	turnobject OAKSLAB_OAK, RIGHT
	opentext
	writetext ProfOakEeveeDollTradeText
	waitbutton
	checkitem EVERSTONE
	iffalse_jumpopenedtext NoEverstoneText
	writetext WantToTradeText
	yesorno
	iffalse_jumpopenedtext NoTradeText
	takeitem EVERSTONE
	disappear OAKSLAB_EEVEE_DOLL
	setevent EVENT_DECO_EEVEE_DOLL
	writetext EeveeDollText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext EeveeDollSentText
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

OakLabPartyAndBoxFullText:
	text "Hm, you don't have"
	line "room for it, and"
	line "your box is full."
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

OaksLabTrashcanText:
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

ProfOakEeveeDollTradeText:
	text "Oak: Oh, are you"
	line "admiring my"
	cont "Eevee Doll?"

	para "I'll trade it"
	line "to you for an"
	cont "Everstone."
	done

NoEverstoneText:
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

EeveeDollText:
	text "<PLAYER> received"
	line "Eevee Doll."
	done

EeveeDollSentText:
	text "Eevee Doll"
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
