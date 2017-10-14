LakeofRageMagikarpHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

LakeofRageMagikarpHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 2, LAKE_OF_RAGE
	warp_def 7, 3, 2, LAKE_OF_RAGE

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 7, SIGNPOST_JUMPSTD, difficultbookshelf

.PersonEvents: db 1
	person_event SPRITE_FISHING_GURU, 3, 2, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FishingGuruScript_0x19a6ae, -1

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
	iftrue UnknownScript_0x19a6d1
	writetext UnknownText_0x19a72e
	waitbutton
	closetext
	setevent EVENT_LAKE_OF_RAGE_EXPLAINED_WEIRD_MAGIKARP
	end

UnknownScript_0x19a6d1:
	jumpopenedtext UnknownText_0x19a84d

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
	if_equal $0, UnknownScript_0x19a71c
	if_equal $1, UnknownScript_0x19a722
	if_equal $2, UnknownScript_0x19a716
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
	jumpopenedtext UnknownText_0x19aa01

UnknownScript_0x19a71c:
	jumpopenedtext UnknownText_0x19aa5c

UnknownScript_0x19a722:
	jumpopenedtext UnknownText_0x19aa79

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

UnknownText_0x19aa01:
	text "Wow! This one is"
	line "outstanding!"

	para "…I wish I could"
	line "say that, but I've"

	para "seen a bigger one"
	line "before."
	done

UnknownText_0x19aa5c:
	text "What? That's not a"
	line "Magikarp!"
	done

UnknownText_0x19aa79:
	text "Oh… So you didn't"
	line "get one good"

	para "enough to show me?"
	line "Maybe next time."
	done
