CinnabarIsland_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, CinnabarIslandFlyPoint

CinnabarIsland_MapEventHeader:

.Warps: db 3
	warp_def 15, 11, 1, CINNABAR_POKECENTER_1F
	warp_def 9, 18, 1, CINNABAR_VOLCANO_1F
	warp_def 7, 7, 1, POKEMON_MANSION_1F

.XYTriggers: db 0

.Signposts: db 4
	signpost 15, 9, SIGNPOST_JUMPTEXT, CinnabarIslandGymSignText
	signpost 11, 9, SIGNPOST_JUMPTEXT, CinnabarIslandSignText
	signpost 11, 21, SIGNPOST_JUMPTEXT, CinnabarIslandVolcanoWarningSignText
	signpost 12, 11, SIGNPOST_ITEM + RARE_CANDY, EVENT_CINNABAR_ISLAND_HIDDEN_RARE_CANDY

.PersonEvents: db 2
	person_event SPRITE_BLUE, 14, 20, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CinnabarIslandBlue, EVENT_BLUE_IN_CINNABAR
	itemball_event 2, 22, MAGMARIZER, 1, EVENT_CINNABAR_ISLAND_MAGMARIZER

const_value set 1
	const CINNABARISLAND_BLUE

CinnabarIslandFlyPoint:
	setflag ENGINE_FLYPOINT_CINNABAR
	return

CinnabarIslandBlue:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_BLUE_INTRO
	iftrue .HeardIntro
	writetext CinnabarIslandBlueText
	waitbutton
	setevent EVENT_LISTENED_TO_BLUE_INTRO
.HeardIntro
	writetext CinnabarIslandBlueBattleText
	waitbutton
	checkcode VAR_BADGES
	if_greater_than 14, .Ready
	jumpopenedtext CinnabarIslandBlueNotReadyText

.Ready
	writetext CinnabarIslandBlueReadyText
	waitbutton
	closetext
	playsound SFX_WARP_TO
	applyonemovement CINNABARISLAND_BLUE, teleport_from
	disappear CINNABARISLAND_BLUE
	clearevent EVENT_VIRIDIAN_GYM_BLUE
	end

CinnabarIslandBlueText:
	text "Who are you?"

	para "Well, it's plain"
	line "to see that you're"
	cont "a trainer…"

	para "My name's Blue."

	para "I was once the"
	line "Champion, although"

	para "it was for only a"
	line "short time…"

	para "That meddling Red"
	line "did me in…"

	para "Anyway, what do"
	line "you want? You want"

	para "to challenge me or"
	line "something?"

	para "…I hate to say"
	line "it, but I'm not in"

	para "the mood for a"
	line "battle now."

	para "Take a good look"
	line "around you…"

	para "A volcano erupts,"
	line "and just like"

	para "that, a whole town"
	line "disappears."

	para "We can go on win-"
	line "ning and losing in"

	para "#mon. But if"
	line "nature so much as"

	para "twitches, we can"
	line "lose in a second."

	para "…"

	para "That's the way it"
	line "is…"

	para "But, anyway, I'm"
	line "still a trainer."
	done

CinnabarIslandBlueBattleText:
	text "If I see a strong"
	line "opponent, it makes"
	cont "me want to battle."
	done

CinnabarIslandBlueReadyText:
	text "If you want to"
	line "battle me, come to"
	cont "the Viridian Gym."

	para "I'll take you on"
	line "then."
	done

CinnabarIslandBlueNotReadyText:
	text "If you want to"
	line "battle me, show me"

	para "how many Kanto"
	line "badges you've got."

	para "Less than seven…"
	line "You're not ready"
	cont "to battle me."
	done

CinnabarIslandGymSignText:
	text "There's a notice"
	line "here…"

	para "“Cinnabar Gym has"
	line "relocated to Sea-"
	cont "foam Islands.”"

	para "-- Blaine"
	done

CinnabarIslandSignText:
	text "Cinnabar Island"

	para "The Fiery Town of"
	line "Burning Desire"
	done

CinnabarIslandVolcanoWarningSignText:
	text "CAUTION"

	para "Cinnabar Volcano"
	line "is dormant, but"
	cont "still active!"

	para "Do not explore"
	line "the volcano"
	cont "without a means"
	cont "of escape!"
	done
