LakeofRageMagikarpHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, LAKE_OF_RAGE, 2
	warp_event  3,  7, LAKE_OF_RAGE, 2

	db 0 ; coord events

	db 1 ; bg events
	bg_event  7,  1, SIGNPOST_JUMPSTD, difficultbookshelf

	db 1 ; object events
	object_event  2,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FishingGuruScript_0x19a6ae, -1

FishingGuruScript_0x19a6ae:
	faceplayer
	opentext
	checkevent EVENT_LAKE_OF_RAGE_ELIXIR_ON_STANDBY
	iftrue UnknownScript_0x19a6fe
	checkevent EVENT_LAKE_OF_RAGE_ASKED_FOR_MAGIKARP
	iftrue UnknownScript_0x19a6e0
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue UnknownScript_0x19a6d7
	checkevent EVENT_LAKE_OF_RAGE_EXPLAINED_WEIRD_MAGIKARP
	iftrue_jumpopenedtext UnknownText_0x19a84d
	writetext UnknownText_0x19a72e
	waitbutton
	closetext
	setevent EVENT_LAKE_OF_RAGE_EXPLAINED_WEIRD_MAGIKARP
	end

UnknownScript_0x19a6d7:
	writetext UnknownText_0x19a890
	waitbutton
	closetext
	setevent EVENT_LAKE_OF_RAGE_ASKED_FOR_MAGIKARP
	end

UnknownScript_0x19a6e0:
	writebyte MAGIKARP
	special Special_FindThatSpecies
	iffalse UnknownScript_0x19a6d7
	writetext UnknownText_0x19a93e
	waitbutton
	special Special_CheckMagikarpLength
	iffalse_jumpopenedtext UnknownText_0x19aa5c
	ifequal $1, UnknownScript_0x19a722
	ifequal $2, UnknownScript_0x19a716
	jump UnknownScript_0x19a6fe

UnknownScript_0x19a6fe:
	writetext UnknownText_0x19a977
	buttonsound
	verbosegiveitem ELIXER
	iffalse UnknownScript_0x19a711
	writetext UnknownText_0x19a9c3
	waitbutton
	closetext
	clearevent EVENT_LAKE_OF_RAGE_ELIXIR_ON_STANDBY
	end

UnknownScript_0x19a711:
	closetext
	setevent EVENT_LAKE_OF_RAGE_ELIXIR_ON_STANDBY
	end

UnknownScript_0x19a716:
	thisopenedtext

	text "Wow! This one is"
	line "outstanding!"

	para "…I wish I could"
	line "say that, but I've"

	para "seen a bigger one"
	line "before."
	done

UnknownScript_0x19a722:
	thisopenedtext

	text "Oh… So you didn't"
	line "get one good"

	para "enough to show me?"
	line "Maybe next time."
	done

UnknownText_0x19a72e:
	text "Lake of Rage is"
	line "actually a crater"

	para "made by rampaging"
	line "Gyarados."

	para "The crater filled"
	line "up with rainwater"

	para "and the lake was"
	line "formed."

	para "That's the story"
	line "passed on from my"

	para "Grandpa's great-"
	line "great-grandpa."

	para "It used to be that"
	line "you could catch"

	para "lively Magikarp"
	line "there, but…"

	para "I don't understand"
	line "what's happening."
	done

UnknownText_0x19a84d:
	text "The lake hasn't"
	line "been normal since"

	para "those men wearing"
	line "black arrived."
	done

UnknownText_0x19a890:
	text "Lake of Rage is"
	line "back to normal."

	para "The Magikarp have"
	line "returned."

	para "I may yet realize"
	line "my dream of see-"
	cont "ing the world's"
	cont "largest Magikarp."

	para "Do you have a Rod?"
	line "Please help me if"
	cont "you do."
	done

UnknownText_0x19a93e:
	text "Ah, you have a"
	line "Magikarp! Let's"

	para "see how big that"
	line "baby is."
	done

UnknownText_0x19a977:
	text "Wow! This one is"
	line "outstanding!"

	para "I tip my hat to"
	line "you!"

	para "Take this as a"
	line "memento!"
	done

UnknownText_0x19a9c3:
	text "The record is the"
	line "important thing."

	para "Think of that as"
	line "a bonus!"
	done

UnknownText_0x19aa5c:
	text "What? That's not a"
	line "Magikarp!"
	done
