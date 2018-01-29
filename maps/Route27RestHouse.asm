Route27RestHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

Route27RestHouse_MapEventHeader:
	db 2 ; warps
	warp_def 7, 2, 1, ROUTE_27
	warp_def 7, 3, 1, ROUTE_27

	db 0 ; xy triggers

	db 1 ; signposts
	signpost 1, 7, SIGNPOST_JUMPSTD, difficultbookshelf

	db 1 ; person events
	person_event SPRITE_GRANNY, 4, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route27RestHouseGranny, -1

Route27RestHouseGranny:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_SKILL_SWAP_INTRO
	iftrue .HeardIntro
	writetext .IntroText
	setevent EVENT_LISTENED_TO_SKILL_SWAP_INTRO
	jump .Continue
.HeardIntro
	writetext .HeardIntroText
.Continue
	buttonsound
	special GetFirstPokemonHappiness
	if_greater_than $95, .Loyal
	thisopenedtext

	text "If it doesn't come"
	line "to trust you some"

	para "more, it could be"
	line "tough going."

	para "Trust is the tie"
	line "that binds #mon"
	cont "and trainers."
	done

.Loyal:
	writetext .QuestionText
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	yesorno
	iffalse .TutorRefused
	writebyte SKILL_SWAP
	writetext .ClearText
	special Special_MoveTutor
	if_equal $0, .TeachMove
.TutorRefused
	jumpopenedtext .RefusedText

.NoSilverLeaf
	waitbutton
	thisopenedtext

	text "You've not found"
	line "any Silver Leaves…"
	done

.TeachMove
	takeitem SILVER_LEAF
	thisopenedtext

	text "Skill Swap is a"
	line "move that swaps"

	para "your ability with"
	line "that of your"
	cont "opponent."

	para "It's for advanced"
	line "trainers only."

	para "Use it if you"
	line "dare. Good luck!"
	done

.IntroText:
	text "Where are you off"
	line "to with #mon?"

	para "The #mon"
	line "League?"

	para "Are your #mon"
	line "loyal enough for"
	cont "you to win?"

	para "Let me see…"
	done

.HeardIntroText:
	text "Let me see your"
	line "#mon…"
	done

.QuestionText:
	text "Ah! Your #mon"
	line "trusts you very"
	cont "much."

	para "It's nice to see a"
	line "good trainer."

	para "I can teach it my"
	line "secret technique,"

	para "Skill Swap, if"
	line "you'd like."
	done

.RefusedText:
	text "Good luck on your"
	line "journey."
	done

.ClearText:
	text ""
	done
