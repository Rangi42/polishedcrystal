Route22Past_MapScriptHeader:
	def_scene_scripts
	scene_script Route22PastNoopScene, SCENE_ROUTE22PAST_NOOP

	def_callbacks

	def_warp_events

	def_coord_events

	def_bg_events

	def_object_events
	object_event  6,  8, SPRITE_CELEBI, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
	object_event  5,  7, SPRITE_LYRA, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
	object_event  5,  2, SPRITE_RIVAL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
	object_event  2,  2, SPRITE_GIOVANNI, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1

	object_const_def
	const ROUTE22PAST_CELEBI
	const ROUTE22PAST_LYRA
	const ROUTE22PAST_RIVAL
	const ROUTE22PAST_GIOVANNI

Route22PastNoopScene:
	sdefer Route22PastCelebiEventScript
	end

Route22PastCelebiEventScript:
	pause 30
	applymovement PLAYER, Route22Past_PlayerLooksAroundMovementData
	showemote EMOTE_SHOCK, ROUTE22PAST_LYRA, 15
	showtext Route22PastLyraWhereAreWeText
	applymovement ROUTE22PAST_LYRA, Route22Past_LyraLooksAroundMovementData
	showtext Route22PastLyraIlexForestDisappearedText
	applymovement ROUTE22PAST_LYRA, Route22Past_LyraStepDownMovementData
	turnobject PLAYER, LEFT
	showtext Route22PastLyraPokeGearText
	applymovement ROUTE22PAST_LYRA, Route22Past_LyraStepDownTurnHeadRigthMovementData
	turnobject PLAYER, DOWN
	showtext Route22PastLyraExplainsTimeTravelText
	showemote EMOTE_SHOCK, ROUTE22PAST_LYRA, 15
	applymovement ROUTE22PAST_LYRA, Route22Past_LyraMoveUpToHearMovementData
	showtext Route22PastLyraHearsSomeoneText
	applymovement PLAYER, Route22Past_PlayerStepUpToLyraMovementData
	follow ROUTE22PAST_LYRA, PLAYER
	applymovement ROUTE22PAST_LYRA, Route22Past_LyraApproachesRivalMovementData
	turnobject ROUTE22PAST_LYRA, UP
	turnobject PLAYER, UP
	stopfollow
	applyonemovement ROUTE22PAST_CELEBI, step_up
	special Special_FadeOutMusic
	applyonemovement ROUTE22PAST_RIVAL, slow_step_left
	showtext Route22PastRivalQuestionsGiovanniText
	turnobject ROUTE22PAST_GIOVANNI, RIGHT
	showtext Route22PastGiovanniRivalArgumentText
	applyonemovement ROUTE22PAST_RIVAL, slow_step_left
	showtext Route22PastRivalProtestsText
	turnobject ROUTE22PAST_GIOVANNI, LEFT
	showtext Route22PastGiovanniGoodbyeText
	applymovement ROUTE22PAST_GIOVANNI, Route22Past_GiovanniLeavesMovementData
	pause 15
	applyonemovement ROUTE22PAST_RIVAL, slow_step_left
	showtext Route22PastRivalRantText
	special Special_FadeOutMusic
	playmusic MUSIC_RIVAL_ENCOUNTER
	applymovement ROUTE22PAST_RIVAL, ROUTE22PAST_RIVALRunsIntoPlayerMovementData
	showemote EMOTE_SHOCK, ROUTE22PAST_RIVAL, 15
	showtext Route22PastRivalInsultText
	playsound SFX_TACKLE
	applymovement PLAYER, ROUTE22PAST_RIVALShovesPlayerDownMovementData
	turnobject ROUTE22PAST_LYRA, DOWN
	applymovement ROUTE22PAST_RIVAL, ROUTE22PAST_RIVALLeavesMovementData
	special RestartMapMusic
	applymovement ROUTE22PAST_LYRA, Route22Past_LyraMeetsPlayerMovementData
	showtext Route22PastLyraConclusionText
	cry CELEBI
	applymovement ROUTE22PAST_CELEBI, Route22Past_CelebiHopsMovementData
	waitsfx
	playsound SFX_GAME_FREAK_LOGO_GS
	special FadeOutPalettes
	special LoadMapPalettes
	pause 30
	special FadeInPalettes_EnableDynNoApply
	waitsfx
	showemote EMOTE_SHOCK, PLAYER, 15
	applymovement ROUTE22PAST_LYRA, Route22Past_LyraLooksAroundAgainMovementData
	turnobject ROUTE22PAST_LYRA, DOWN
	showtext Route22PastLyraOhNoText
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
	setmapscene GIOVANNIS_CAVE, SCENE_GIOVANNISCAVE_NOOP
	warp GIOVANNIS_CAVE, 15, 5
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
	step_end

Route22Past_LyraStepDownTurnHeadRigthMovementData:
	slow_step_down
	turn_head_right
	step_end

Route22Past_LyraMoveUpToHearMovementData:
	slow_step_up
	slow_step_up
	step_end

Route22Past_PlayerStepUpToLyraMovementData:
	slow_step_up
	step_end

Route22Past_LyraApproachesRivalMovementData:
	slow_step_up
	slow_step_up
	slow_step_left
	step_end

Route22Past_GiovanniLeavesMovementData:
	slow_step_left
	slow_step_left
	step_end

ROUTE22PAST_RIVALRunsIntoPlayerMovementData:
	step_right
	step_right
	step_right
	step_down
	step_end

ROUTE22PAST_RIVALShovesPlayerDownMovementData:
	turn_head_up
	fix_facing
	jump_step_down
	step_sleep_6
	turn_head_left
	step_right
	remove_fixed_facing
	step_end

ROUTE22PAST_RIVALLeavesMovementData:
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

Route22PastLyraPokeGearText:
	text "Lyra: <PLAYER>, my"
	line "#gear radio"

	para "said the date is"
	line "from three years"
	cont "ago!"
	done

Route22PastLyraExplainsTimeTravelText:
	text "Is that… am I"
	line "looking at…"
	cont "Celebi?"

	para "That explains it!"
	line "Celebi must have"
	cont "used its power to"

	para "take us back in"
	line "time!"
	done

Route22PastLyraHearsSomeoneText:
	text "<PLAYER>, I hear"
	line "someone else."

	para "Let's find out"
	line "who it is!"
	done

Route22PastRivalQuestionsGiovanniText:
	text "<RIVAL>: You told"
	line "me… you were the"

	para "number one in the"
	line "world!"

	para "Are you gonna"
	line "quit?"

	para "What are you"
	line "going to do now?"
	done

Route22PastGiovanniRivalArgumentText:
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

Route22PastRivalProtestsText:
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

Route22PastRivalRantText:
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

Route22PastRivalInsultText:
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
