const_value set 2
	const ROUTE22_COOLTRAINER_M
	const ROUTE22_CELEBI
	const ROUTE22_LYRA
	const ROUTE22_SILVER
	const ROUTE22_GIOVANNI

Route22_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	maptrigger .Trigger0
	maptrigger .Trigger1

.MapCallbacks:
	db 0

.Trigger0:
	end

.Trigger1:
	priorityjump Route22CelebiEventScript
	end

Route22CelebiEventScript:
	pause 30
	applymovement PLAYER, Route22_PlayerLooksAroundMovementData
	showemote EMOTE_SHOCK, ROUTE22_LYRA, 15
	opentext
	writetext Route22LyraWhereAreWeText
	waitbutton
	closetext
	applymovement ROUTE22_LYRA, Route22_LyraLooksAroundMovementData
	opentext
	writetext Route22LyraIlexForestDisappearedText
	waitbutton
	closetext
	applymovement ROUTE22_LYRA, Route22_LyraStepDownMovementData
	spriteface PLAYER, LEFT
	opentext
	writetext Route22LyraExplainsTimeTravelText
	waitbutton
	closetext
	showemote EMOTE_SHOCK, ROUTE22_LYRA, 15
	spriteface ROUTE22_LYRA, UP
	opentext
	writetext Route22LyraHearsSomeoneText
	waitbutton
	closetext
	follow ROUTE22_LYRA, PLAYER
	applymovement ROUTE22_LYRA, Route22_LyraApproachesSilverMovementData
	spriteface ROUTE22_LYRA, UP
	spriteface PLAYER, UP
	stopfollow
	applymovement ROUTE22_CELEBI, Route22_CelebiStepsUpMovementData
	special Special_FadeOutMusic
	applymovement ROUTE22_SILVER, Route22_SilverApproachesGiovanniMovementData
	opentext
	writetext Route22SilverQuestionsGiovanniText
	waitbutton
	closetext
	spriteface ROUTE22_GIOVANNI, RIGHT
	opentext
	writetext Route22GiovanniSilverArgumentText
	waitbutton
	closetext
	applymovement ROUTE22_SILVER, Route22_SilverApproachesGiovanniMovementData
	opentext
	writetext Route22SilverProtestsText
	waitbutton
	closetext
	spriteface ROUTE22_GIOVANNI, LEFT
	opentext
	writetext Route22GiovanniGoodbyeText
	waitbutton
	closetext
	applymovement ROUTE22_GIOVANNI, Route22_GiovanniLeavesMovementData
	disappear ROUTE22_GIOVANNI
	pause 15
	applymovement ROUTE22_SILVER, Route22_SilverApproachesGiovanniMovementData
	opentext
	writetext Route22SilverRantText
	waitbutton
	closetext
	special Special_FadeOutMusic
	playmusic MUSIC_RIVAL_ENCOUNTER
	applymovement ROUTE22_SILVER, Route22_SilverRunsIntoPlayerMovementData
	showemote EMOTE_SHOCK, ROUTE22_SILVER, 15
	opentext
	writetext Route22SilverInsultText
	waitbutton
	closetext
	playsound SFX_TACKLE
	applymovement PLAYER, Route22_SilverShovesPlayerDownMovementData
	spriteface ROUTE22_LYRA, DOWN
	applymovement ROUTE22_SILVER, Route22_SilverLeavesMovementData
	disappear ROUTE22_SILVER
	special RestartMapMusic
	applymovement ROUTE22_LYRA, Route22_LyraMeetsPlayerMovementData
	opentext
	writetext Route22LyraConclusionText
	waitbutton
	closetext
	cry CELEBI
	applymovement ROUTE22_CELEBI, Route22_CelebiHopsMovementData
	waitsfx
	playsound SFX_GAME_FREAK_LOGO_GS
	special FadeOutPalettes
	pause 30
	special FadeInPalettes
	waitsfx
	showemote EMOTE_SHOCK, PLAYER, 15
	applymovement ROUTE22_LYRA, Route22_LyraLooksAroundAgainMovementData
	spriteface ROUTE22_LYRA, DOWN
	opentext
	writetext Route22LyraOhNoText
	waitbutton
	closetext
	playsound SFX_PROTECT
	applymovement ROUTE22_CELEBI, Route22_CelebiFloatsMovementData
	waitsfx
	playsound SFX_GAME_FREAK_LOGO_GS
	special FadeOutPalettes
	pause 30
	waitsfx
	disappear ROUTE22_CELEBI
	disappear ROUTE22_LYRA
	clearevent EVENT_GIOVANNIS_CAVE_CELEBI
	clearevent EVENT_GIOVANNIS_CAVE_LYRA
	clearevent EVENT_GIOVANNIS_CAVE_GIOVANNI
	dotrigger $0
	domaptrigger GIOVANNIS_CAVE, $1
	warp GIOVANNIS_CAVE, $5, $5
	end

Route22CooltrainermScript:
	jumptextfaceplayer Route22CooltrainermText

VictoryRoadEntranceSign:
	jumptext VictoryRoadEntranceSignText

Route22_PlayerLooksAroundMovementData:
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

Route22_LyraLooksAroundMovementData:
	slow_step_up
	step_sleep_8
	step_sleep_8
	step_sleep_8
Route22_LyraLooksAroundAgainMovementData:
	turn_head_left
	step_sleep_8
	step_sleep_8
	step_sleep_8
	turn_head_right
	step_sleep_8
	step_sleep_8
	step_sleep_8
	step_end

Route22_LyraStepDownMovementData:
	slow_step_down
	turn_head_right
	step_end

Route22_LyraApproachesSilverMovementData:
	slow_step_up
	slow_step_up
	slow_step_up
	slow_step_left
	step_end

Route22_CelebiStepsUpMovementData:
	step_up
	step_end

Route22_GiovanniLeavesMovementData:
	slow_step_left
Route22_SilverApproachesGiovanniMovementData:
	slow_step_left
	step_end

Route22_SilverRunsIntoPlayerMovementData:
	step_right
	step_right
	step_right
	step_down
	step_end

Route22_SilverShovesPlayerDownMovementData:
	turn_head_up
	fix_facing
	jump_step_down
	step_sleep_6
	turn_head_left
	step_right
	remove_fixed_facing
	step_end

Route22_SilverLeavesMovementData:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

Route22_LyraMeetsPlayerMovementData:
	step_right
	step_down
	step_down
	turn_head_right
	step_end

Route22_CelebiHopsMovementData:
	step_left
	turn_head_down
	step_end

Route22_CelebiFloatsMovementData:
	turn_head_down
	fix_facing
	slow_step_up
	slow_step_up
	slow_step_up
	remove_fixed_facing
	step_end

Route22LyraWhereAreWeText:
	text "Lyra: Where are"
	line "we…?"
	done

Route22LyraIlexForestDisappearedText:
	text "Lyra: Ilex Forest"
	line "has disappeared!"

	para "…That's not it."
	line "We've been trans-"
	cont "ported somewhere"
	cont "else…?"
	done

Route22LyraExplainsTimeTravelText:
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

Route22LyraHearsSomeoneText:
	text "<PLAYER>, I hear"
	line "someone else."

	para "Let's find out"
	line "who it is!"
	done

Route22SilverQuestionsGiovanniText:
	text "<RIVAL>: You told"
	line "me… you were the"

	para "number one in the"
	line "world!"

	para "Are you gonna"
	line "quit?"

	para "What are you"
	line "going to do now?"
	done

Route22GiovanniSilverArgumentText:
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

Route22SilverProtestsText:
	text "<RIVAL>: I don't"
	line "understand you!"

	para "You don't make"
	line "any sense!"
	done

Route22GiovanniGoodbyeText:
	text "…… …… ……"

	para "One day, you will"
	line "understand."
	done

Route22SilverRantText:
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

Route22SilverInsultText:
	text "<RIVAL>: …What are"
	line "you staring at?"
	done

Route22LyraConclusionText:
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

Route22LyraOhNoText:
	text "Lyra: Oh no!"
	line "It's happening"
	cont "again…!"

	para "It's Celebi's"
	line "Time Travel!"
	done

Route22CooltrainermText:
	text "You think you're"
	line "ready for the"
	cont "#mon League?"

	para "Bah!"

	para "…What?! You al-"
	line "ready beat them?"

	para "Well then."
	done

VictoryRoadEntranceSignText:
	text "Route 22"

	para "#mon League"
	line "Reception Gate"
	done

Route22_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $5, $3, 1, POKEMON_LEAGUE_GATE

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 7, 5, SIGNPOST_READ, VictoryRoadEntranceSign

.PersonEvents:
	db 5
	person_event SPRITE_COOLTRAINER_M, 2, 20, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, Route22CooltrainermScript, EVENT_TIME_TRAVELING
	person_event SPRITE_CELEBI, 10, 22, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_22_CELEBI
	person_event SPRITE_LYRA, 9, 21, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_22_LYRA
	person_event SPRITE_SILVER, 4, 21, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_22_SILVER
	person_event SPRITE_GIOVANNI, 4, 18, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_22_GIOVANNI
