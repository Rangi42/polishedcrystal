const_value set 2
	const ROUTE22PAST_CELEBI
	const ROUTE22PAST_LYRA
	const ROUTE22PAST_SILVER
	const ROUTE22PAST_GIOVANNI

Route22Past_MapScriptHeader:
.MapTriggers:
	db 1

	; triggers
	maptrigger .Trigger0

.MapCallbacks:
	db 0

.Trigger0:
	priorityjump Route22PastCelebiEventScript
	end

Route22PastCelebiEventScript:
	pause 30
	applymovement PLAYER, Route22Past_PlayerLooksAroundMovementData
	showemote EMOTE_SHOCK, ROUTE22PAST_LYRA, 15
	opentext
	writetext Route22PastLyraWhereAreWeText
	waitbutton
	closetext
	applymovement ROUTE22PAST_LYRA, Route22Past_LyraLooksAroundMovementData
	opentext
	writetext Route22PastLyraIlexForestDisappearedText
	waitbutton
	closetext
	applymovement ROUTE22PAST_LYRA, Route22Past_LyraStepDownMovementData
	spriteface PLAYER, LEFT
	opentext
	writetext Route22PastLyraExplainsTimeTravelText
	waitbutton
	closetext
	showemote EMOTE_SHOCK, ROUTE22PAST_LYRA, 15
	spriteface ROUTE22PAST_LYRA, UP
	opentext
	writetext Route22PastLyraHearsSomeoneText
	waitbutton
	closetext
	follow ROUTE22PAST_LYRA, PLAYER
	applymovement ROUTE22PAST_LYRA, Route22Past_LyraApproachesSilverMovementData
	spriteface ROUTE22PAST_LYRA, UP
	spriteface PLAYER, UP
	stopfollow
	applymovement ROUTE22PAST_CELEBI, Route22Past_CelebiStepsUpMovementData
	special Special_FadeOutMusic
	applymovement ROUTE22PAST_SILVER, Route22Past_SilverApproachesGiovanniMovementData
	opentext
	writetext Route22PastSilverQuestionsGiovanniText
	waitbutton
	closetext
	spriteface ROUTE22PAST_GIOVANNI, RIGHT
	opentext
	writetext Route22PastGiovanniSilverArgumentText
	waitbutton
	closetext
	applymovement ROUTE22PAST_SILVER, Route22Past_SilverApproachesGiovanniMovementData
	opentext
	writetext Route22PastSilverProtestsText
	waitbutton
	closetext
	spriteface ROUTE22PAST_GIOVANNI, LEFT
	opentext
	writetext Route22PastGiovanniGoodbyeText
	waitbutton
	closetext
	applymovement ROUTE22PAST_GIOVANNI, Route22Past_GiovanniLeavesMovementData
	pause 15
	applymovement ROUTE22PAST_SILVER, Route22Past_SilverApproachesGiovanniMovementData
	opentext
	writetext Route22PastSilverRantText
	waitbutton
	closetext
	special Special_FadeOutMusic
	playmusic MUSIC_RIVAL_ENCOUNTER
	applymovement ROUTE22PAST_SILVER, Route22Past_SilverRunsIntoPlayerMovementData
	showemote EMOTE_SHOCK, ROUTE22PAST_SILVER, 15
	opentext
	writetext Route22PastSilverInsultText
	waitbutton
	closetext
	playsound SFX_TACKLE
	applymovement PLAYER, Route22Past_SilverShovesPlayerDownMovementData
	spriteface ROUTE22PAST_LYRA, DOWN
	applymovement ROUTE22PAST_SILVER, Route22Past_SilverLeavesMovementData
	special RestartMapMusic
	applymovement ROUTE22PAST_LYRA, Route22Past_LyraMeetsPlayerMovementData
	opentext
	writetext Route22PastLyraConclusionText
	waitbutton
	closetext
	cry CELEBI
	applymovement ROUTE22PAST_CELEBI, Route22Past_CelebiHopsMovementData
	waitsfx
	playsound SFX_GAME_FREAK_LOGO_GS
	special FadeOutPalettes
	pause 30
	special FadeInPalettes
	waitsfx
	showemote EMOTE_SHOCK, PLAYER, 15
	applymovement ROUTE22PAST_LYRA, Route22Past_LyraLooksAroundAgainMovementData
	spriteface ROUTE22PAST_LYRA, DOWN
	opentext
	writetext Route22PastLyraOhNoText
	waitbutton
	closetext
	playsound SFX_PROTECT
	applymovement ROUTE22PAST_CELEBI, Route22Past_CelebiFloatsMovementData
	waitsfx
	playsound SFX_GAME_FREAK_LOGO_GS
	special FadeOutPalettes
	pause 30
	waitsfx
	clearevent EVENT_GIOVANNIS_CAVE_CELEBI
	clearevent EVENT_GIOVANNIS_CAVE_LYRA
	clearevent EVENT_GIOVANNIS_CAVE_GIOVANNI
	domaptrigger GIOVANNIS_CAVE, $1
	warp GIOVANNIS_CAVE, $f, $5
	end

Route22Past_PlayerLooksAroundMovementData:
	turn_head_left
	step_sleep_8
	step_sleep_8
	step_sleep_8
	turn_head_right
	step_sleep_8
	step_sleep_8
	step_sleep_8
	turn_head_up
	step_sleep_8
	step_sleep_8
	step_sleep_8
	step_end

Route22Past_LyraLooksAroundMovementData:
	slow_step_up
	step_sleep_8
	step_sleep_8
	step_sleep_8
Route22Past_LyraLooksAroundAgainMovementData:
	turn_head_left
	step_sleep_8
	step_sleep_8
	step_sleep_8
	turn_head_right
	step_sleep_8
	step_sleep_8
	step_sleep_8
	step_end

Route22Past_LyraStepDownMovementData:
	slow_step_down
	turn_head_right
	step_end

Route22Past_LyraApproachesSilverMovementData:
	slow_step_up
	slow_step_up
	slow_step_up
	slow_step_left
	step_end

Route22Past_CelebiStepsUpMovementData:
	step_up
	step_end

Route22Past_GiovanniLeavesMovementData:
	slow_step_left
Route22Past_SilverApproachesGiovanniMovementData:
	slow_step_left
	step_end

Route22Past_SilverRunsIntoPlayerMovementData:
	step_right
	step_right
	step_right
	step_down
	step_end

Route22Past_SilverShovesPlayerDownMovementData:
	turn_head_up
	fix_facing
	jump_step_down
	step_sleep_6
	turn_head_left
	step_right
	remove_fixed_facing
	step_end

Route22Past_SilverLeavesMovementData:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

Route22Past_LyraMeetsPlayerMovementData:
	step_right
	step_down
	step_down
	turn_head_right
	step_end

Route22Past_CelebiHopsMovementData:
	step_left
	turn_head_down
	step_end

Route22Past_CelebiFloatsMovementData:
	turn_head_down
	fix_facing
	slow_step_up
	slow_step_up
	slow_step_up
	remove_fixed_facing
	step_end

Route22PastLyraWhereAreWeText:
	text "Lyra: Where are"
	line "we…?"
	done

Route22PastLyraIlexForestDisappearedText:
	text "Lyra: Ilex Forest"
	line "has disappeared!"

	para "…That's not it."
	line "We've been trans-"
	cont "ported somewhere"
	cont "else…?"
	done

Route22PastLyraExplainsTimeTravelText:
	text "Lyra: <PLAYER>, my"
	line "#gear radio"

	para "said the date is"
	line "from three years"
	cont "ago!"

	para "Celebi must have"
	line "used its power to"

	para "take us back in"
	line "time!"
	done

Route22PastLyraHearsSomeoneText:
	text "<PLAYER>, I hear"
	line "someone else."

	para "Let's find out"
	line "who it is!"
	done

Route22PastSilverQuestionsGiovanniText:
	text "<RIVAL>: You told"
	line "me… you were the"

	para "number one in the"
	line "world!"

	para "Are you gonna"
	line "quit?"

	para "What are you"
	line "going to do now?"
	done

Route22PastGiovanniSilverArgumentText:
	text "…… …… ……"

	para "One must acknow-"
	line "ledge one's defeat"

	para "before he can move"
	line "on…"

	para "I will go solo…"
	line "for now…"

	para "So that one day I"
	line "will form a"

	para "stronger organ-"
	line "ization!"

	para "<RIVAL>: What"
	line "aspect of you was"
	cont "number one?"

	para "Gathering so many"
	line "only to be"

	para "defeated by a"
	line "mere child!"

	para "…… …… ……"

	para "Putting together"
	line "the potential of"

	para "many is how you"
	line "produce a huge"
	cont "power…"

	para "That's what an"
	line "organization is!"

	para "I failed… to make"
	line "the best use of"

	para "my subordinates'"
	line "potential…"

	para "But you shall wit-"
	line "ness one day the"

	para "revival of me and"
	line "my Team Rocket!"
	done

Route22PastSilverProtestsText:
	text "<RIVAL>: I don't"
	line "understand you!"

	para "You don't make"
	line "any sense!"
	done

Route22PastGiovanniGoodbyeText:
	text "…… …… ……"

	para "One day, you will"
	line "understand."
	done

Route22PastSilverRantText:
	text "<RIVAL>: I don't"
	line "want to understand"
	cont "you!"

	para "I will never"
	line "become someone"
	cont "like you."

	para "A coward when"
	line "you're alone and"

	para "acting like a"
	line "tyrant when you're"

	para "in front of other"
	line "cowards!"

	para "I will become"
	line "strong!"

	para "I will become a"
	line "stronger man all"
	cont "by myself!"

	para "All by myself!"
	done

Route22PastSilverInsultText:
	text "<RIVAL>: …What are"
	line "you staring at?"
	done

Route22PastLyraConclusionText:
	text "Lyra: Who does he"
	line "think he is?"

	para "That was"
	line "unnecessary!"

	para "But they were"
	line "talking about the"

	para "revival of Team"
	line "Rocket…"

	para "Team Rocket was"
	line "removed from Kanto"

	para "by a child three"
	line "years ago."

	para "So this really"
	line "is the past!"
	done

Route22PastLyraOhNoText:
	text "Lyra: Oh no!"
	line "It's happening"
	cont "again…!"

	para "It's Celebi's"
	line "Time Travel!"
	done

Route22Past_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 0

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 4
	person_event SPRITE_CELEBI, 8, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_LYRA, 7, 5, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_SILVER, 2, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_GIOVANNI, 2, 2, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
