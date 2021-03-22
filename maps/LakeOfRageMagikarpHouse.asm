LakeOfRageMagikarpHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, LAKE_OF_RAGE, 2
	warp_event  3,  7, LAKE_OF_RAGE, 2

	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_JUMPSTD, difficultbookshelf

	def_object_events
	object_event  2,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, MagikarpLengthRaterScript, -1

MagikarpLengthRaterScript:
	faceplayer
	opentext
	checkevent EVENT_LAKE_OF_RAGE_ELIXIR_ON_STANDBY
	iftrue .GetReward
	checkevent EVENT_LAKE_OF_RAGE_ASKED_FOR_MAGIKARP
	iftrue .AskedForMagikarp
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .ClearedRocketHideout
	checkevent EVENT_LAKE_OF_RAGE_EXPLAINED_WEIRD_MAGIKARP
	iftrue_jumpopenedtext MagikarpLengthRaterText_MenInBlack
	writetext MagikarpLengthRaterText_LakeOfRageHistory
	waitbutton
	closetext
	setevent EVENT_LAKE_OF_RAGE_EXPLAINED_WEIRD_MAGIKARP
	end

.ClearedRocketHideout:
	writetext MagikarpLengthRaterText_WorldsLargestMagikarp
	waitbutton
	closetext
	setevent EVENT_LAKE_OF_RAGE_ASKED_FOR_MAGIKARP
	end

.AskedForMagikarp:
	setval MAGIKARP
	special Special_FindThatSpecies
	iffalse .ClearedRocketHideout
	writetext MagikarpLengthRaterText_YouHaveAMagikarp
	waitbutton
	special CheckMagikarpLength
	iffalse_jumpopenedtext MagikarpLengthRaterText_NotMagikarp
	ifequal $1, .Refused
	ifequal $2, .TooShort
.GetReward:
	writetext MagikarpLengthRaterText_Memento
	promptbutton
	verbosegiveitem ELIXIR
	iffalse .NoRoom
	writetext MagikarpLengthRaterText_Bonus
	waitbutton
	closetext
	clearevent EVENT_LAKE_OF_RAGE_ELIXIR_ON_STANDBY
	end

.NoRoom:
	closetext
	setevent EVENT_LAKE_OF_RAGE_ELIXIR_ON_STANDBY
	end

.TooShort:
	jumpthisopenedtext

	text "Wow! This one is"
	line "outstanding!"

	para "…I wish I could"
	line "say that, but I've"

	para "seen a bigger one"
	line "before."
	done

.Refused:
	jumpthisopenedtext

	text "Oh… So you didn't"
	line "get one good"

	para "enough to show me?"
	line "Maybe next time."
	done

MagikarpLengthRaterText_LakeOfRageHistory:
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

MagikarpLengthRaterText_MenInBlack:
	text "The lake hasn't"
	line "been normal since"

	para "those men wearing"
	line "black arrived."
	done

MagikarpLengthRaterText_WorldsLargestMagikarp:
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

MagikarpLengthRaterText_YouHaveAMagikarp:
	text "Ah, you have a"
	line "Magikarp! Let's"

	para "see how big that"
	line "baby is."
	done

MagikarpLengthRaterText_Memento:
	text "Wow! This one is"
	line "outstanding!"

	para "I tip my hat to"
	line "you!"

	para "Take this as a"
	line "memento!"
	done

MagikarpLengthRaterText_Bonus:
	text "The record is the"
	line "important thing."

	para "Think of that as"
	line "a bonus!"
	done

MagikarpLengthRaterText_NotMagikarp:
	text "What? That's not a"
	line "Magikarp!"
	done
