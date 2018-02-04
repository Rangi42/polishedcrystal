PokemonFanClub_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, VERMILION_CITY, 3
	warp_event  3,  7, VERMILION_CITY, 3

	db 0 ; coord events

	db 3 ; bg events
	bg_event  7,  0, SIGNPOST_JUMPTEXT, UnknownText_0x191dfc
	bg_event  9,  0, SIGNPOST_JUMPTEXT, UnknownText_0x191e29
	bg_event  0,  1, SIGNPOST_READ, PokemonJournalGreenScript

	db 6 ; object events
	object_event  3,  3, SPRITE_CLEFAIRY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptext, ClefairyDollText, EVENT_VERMILION_FAN_CLUB_DOLL
	object_event  5,  1, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GentlemanScript_0x1917e9, -1
	object_event  6,  1, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x191b6d, -1
	object_event  3,  4, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FisherScript_0x191824, -1
	object_event  7,  2, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x191d73, -1
	object_event  7,  3, SPRITE_ODDISH, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_POKEMON, ODDISH, FanClubOddishText, -1

	const_def 1 ; object constants
	const POKEMONFANCLUB_CLEFAIRY_DOLL

GentlemanScript_0x1917e9:
	checkevent EVENT_LISTENED_TO_FAN_CLUB_PRESIDENT
	iftrue_jumptextfaceplayer UnknownText_0x191ae0
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_FAN_CLUB_PRESIDENT_BUT_BAG_WAS_FULL
	iftrue UnknownScript_0x191802
	writetext UnknownText_0x191881
	yesorno
	iffalse_jumpopenedtext UnknownText_0x191b38
	writetext UnknownText_0x191911
	buttonsound
UnknownScript_0x191802:
	writetext UnknownText_0x191a3d
	buttonsound
	verbosegiveitem RARE_CANDY
	iffalse_endtext
	setevent EVENT_LISTENED_TO_FAN_CLUB_PRESIDENT
	jumpopenedtext UnknownText_0x191a72

FisherScript_0x191824:
	checkevent EVENT_GOT_LOST_ITEM_FROM_FAN_CLUB
	iftrue_jumptextfaceplayer UnknownText_0x191d1e
	checkevent EVENT_RETURNED_MACHINE_PART
	iffalse_jumptextfaceplayer UnknownText_0x191ba0
	faceplayer
	opentext
	writetext UnknownText_0x191bff
	checkevent EVENT_MET_COPYCAT_FOUND_OUT_ABOUT_LOST_ITEM
	iftrue UnknownScript_0x191844
	waitendtext
UnknownScript_0x191844:
	buttonsound
	writetext UnknownText_0x191c5a
	buttonsound
	waitsfx
	giveitem LOST_ITEM
	iffalse_jumpopenedtext UnknownText_0x191d58
	disappear POKEMONFANCLUB_CLEFAIRY_DOLL
	writetext UnknownText_0x191d0a
	playsound SFX_KEY_ITEM
	waitsfx
	itemnotify
	setevent EVENT_GOT_LOST_ITEM_FROM_FAN_CLUB
	endtext

PokemonJournalGreenScript:
	setflag ENGINE_READ_GREEN_JOURNAL
	thistext

	text "#mon Journal"

	para "Special Feature:"
	line "<PK><MN> Trainer Green!"

	para "In addition to"
	line "being a powerful"
	cont "trainer, Green is"

	para "said to be fascin-"
	line "ated by legendary"
	cont "#mon."
	done

UnknownText_0x191881:
	text "I'm the Chairman"
	line "of the #mon Fan"
	cont "Club."

	para "I've raised over"
	line "150 #mon."

	para "I'm very fussy"
	line "when it comes to"
	cont "#mon."

	para "Did you visit just"
	line "to hear about my"
	cont "#mon?"
	done

UnknownText_0x191911:
	text "Good!"
	line "Then listen up!"

	para "So… my favorite"
	line "Rapidash…"

	para "It… cute… lovely…"
	line "smart… unbearably…"
	cont "plus… amazing… oh…"
	cont "you think so?…"
	cont "Too much… wild…"
	cont "beautiful… kindly…"
	cont "love it!"

	para "Hug it… when…"
	line "sleeping… warm and"
	cont "cuddly… Oh, and…"
	cont "spectacular…"
	cont "ravishing… simply"
	cont "divine…"
	cont "Oops! Look at the"
	cont "time! I've kept"
	cont "you too long!"
	done

UnknownText_0x191a3d:
	text "Thanks for hearing"
	line "me out. I want you"
	cont "to have this!"
	done

UnknownText_0x191a72:
	text "It's a Rare Candy"
	line "that makes #mon"
	cont "stronger."

	para "I prefer making my"
	line "#mon stronger"

	para "by battling, so"
	line "you can have it."
	done

UnknownText_0x191ae0:
	text "Hello, <PLAYER>!"

	para "Did you come see"
	line "me about my #-"
	cont "mon again?"

	para "No? Oh… I had more"
	line "tales to tell…"
	done

UnknownText_0x191b38:
	text "How disappointing…"

	para "Come back if you"
	line "want to listen."
	done

UnknownText_0x191b6d:
	text "Our Chairman is"
	line "very vocal when it"
	cont "comes to #mon…"
	done

UnknownText_0x191ba0:
	text "I love the way"
	line "Clefairy waggles"

	para "its finger when"
	line "it's trying to use"

	para "Metronome."
	line "It's so adorable!"
	done

UnknownText_0x191bff:
	text "I love Clefairy,"
	line "but I could never"

	para "catch one. So I'm"
	line "making do with a"

	para "# Doll that I"
	line "found."
	done

UnknownText_0x191c5a:
	text "Oh, I see now. The"
	line "girl who lost this"

	para "# Doll is sad…"

	para "OK. Could you take"
	line "this # Doll"

	para "back to that poor"
	line "little girl?"

	para "I'll befriend a"
	line "real Clefairy on"

	para "my own one day."
	line "No worries!"
	done

UnknownText_0x191d0a:
	text "<PLAYER> received"
	line "# Doll."
	done

UnknownText_0x191d1e:
	text "You watch. I'm"
	line "going to get a"

	para "real Clefairy as"
	line "my friend."
	done

UnknownText_0x191d58:
	text "Your Bag is"
	line "jammed full."
	done

UnknownText_0x191d73:
	text "Look at my darling"
	line "Oddish!"

	para "The leaves on its"
	line "head are so cute!"
	done

ClefairyDollText:
	text "It's a Clefairy!"
	line "Huh?"

	para "Oh, right. It's a"
	line "Clefairy #"
	cont "Doll."
	done

FanClubOddishText:
	text "Oddish: Diish!"
	done

UnknownText_0x191dfc:
	text "Let's all listen"
	line "politely to other"
	cont "trainers."
	done

UnknownText_0x191e29:
	text "If someone brags,"
	line "brag right back!"
	done
