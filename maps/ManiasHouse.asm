ManiasHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, CIANWOOD_CITY, 1
	warp_event  3,  7, CIANWOOD_CITY, 1

	db 0 ; coord events

	db 2 ; bg events
	bg_event  5,  1, SIGNPOST_JUMPSTD, radio2
	bg_event  7,  1, SIGNPOST_JUMPSTD, picturebookshelf

	db 1 ; object events
	object_event  2,  4, SPRITE_ROCKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ManiaScript, -1

ManiaScript:
	faceplayer
	opentext
	checkevent EVENT_MANIA_TOOK_BUFFY_OR_LET_YOU_KEEP_HIM
	iftrue .default_postevent
	checkevent EVENT_GOT_BUFFY
	iftrue .alreadyhavebuffy
	writetext ManiaText_AskLookAfterWobbuffet
	yesorno
	iffalse .refusetotakebuffy
	special SpecialGiveWobbuffet
	iffalse .partyfull
	writetext ManiaText_TakeCareOfWobbuffet
	buttonsound
	waitsfx
	writetext ManiaText_GotWobbuffet
	playsound SFX_KEY_ITEM
	waitsfx
	closetext
	setevent EVENT_GOT_BUFFY
	end

.alreadyhavebuffy
	checkflag ENGINE_WOBBUFFET_GIVEN
	iffalse .returnbuffy
	jumpopenedtext ManiaText_TakeCareOfWobbuffet

.partyfull
	jumpopenedtext ManiaText_PartyFull

.refusetotakebuffy
	jumpopenedtext ManiaText_IfHeComesBack

.returnbuffy
	writetext ManiaText_CanIHaveMyMonBack
	yesorno
	iffalse .refused
	special SpecialReturnWobbuffet
	ifequal $0, .wrong
	ifequal $1, .refused
	ifequal $3, .superhappy
	ifequal $4, .default_postevent
	writetext ManiaText_ThankYou
	waitbutton
	closetext
	setevent EVENT_MANIA_TOOK_BUFFY_OR_LET_YOU_KEEP_HIM
	end

.wrong
	jumpopenedtext ManiaText_WobbuffetNotThere

.superhappy
	writetext ManiaText_WobbuffetLikesYou
	waitbutton
	closetext
	setevent EVENT_MANIA_TOOK_BUFFY_OR_LET_YOU_KEEP_HIM
	end

.refused
	jumpopenedtext ManiaText_SameAsBeingRobbed

.nothingleft
	jumpopenedtext ManiaText_WobbuffetIsYourLastMon

.default_postevent
	jumpopenedtext ManiaText_HappinessSpeech

ManiaText_AskLookAfterWobbuffet:
	text "I, I'm in shock!"

	para "A guy about your"
	line "age with piercing"

	para "eyes and long hair"
	line "came in."

	para "He scared me into"
	line "giving him my"
	cont "prized #mon!"

	para "I still have one"
	line "left, but what if"
	cont "he comes back?"

	para "You look strong."
	line "Could you look"

	para "after my #mon"
	line "for a while?"
	done

ManiaText_TakeCareOfWobbuffet:
	text "Oh, thank you!"

	para "Take good care of"
	line "it, please!"
	done

ManiaText_GotWobbuffet:
	text "<PLAYER> received a"
	line "#mon."
	done

ManiaText_PartyFull:
	text "Your #mon party"
	line "is full."
	done

ManiaText_IfHeComesBack:
	text "Oh, no… What'll"
	line "I do if he comes"
	cont "back?"
	done

ManiaText_CanIHaveMyMonBack:
	text "Hi! How's my #-"
	line "mon?"

	para "I think I'm safe"
	line "now, so may I have"
	cont "it back?"
	done

ManiaText_ThankYou:
	text "Thank you!"
	done

ManiaText_WobbuffetNotThere:
	text "Hey, you don't"
	line "have my #mon"
	cont "with you."
	done

ManiaText_WobbuffetLikesYou:
	text "My #mon has"
	line "come to like you."

	para "All right, you"
	line "should keep it."

	para "But promise to"
	line "be good to it!"
	done

ManiaText_SameAsBeingRobbed:
	text "Oh, no, no… That's"
	line "the same as being"
	cont "robbed."
	done

ManiaText_HappinessSpeech:
	text "For #mon, hap-"
	line "piness is being"

	para "with a person who"
	line "treats them well."
	done

ManiaText_WobbuffetIsYourLastMon:
	text "If I take my #-"
	line "mon back, what are"

	para "you going to use"
	line "in battle?"
	done
