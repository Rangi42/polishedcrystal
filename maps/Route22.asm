Route22_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route22_MapEventHeader:

.Warps: db 1
	warp_def 5, 3, 1, POKEMON_LEAGUE_GATE

.XYTriggers: db 0

.Signposts: db 1
	signpost 6, 6, SIGNPOST_JUMPTEXT, VictoryRoadEntranceSignText

.PersonEvents: db 2
	person_event SPRITE_KUKUI, 11, 14, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, KukuiScript, -1
	person_event SPRITE_COOLTRAINER_F, 2, 20, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, Route22CooltrainerfText, -1

const_value set 1
	const ROUTE22_KUKUI

KukuiScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_KUKUI
	iftrue .Beaten
	checkevent EVENT_INTRODUCED_KUKUI
	iftrue .Introduced
	writetext .IntroText
	jump .Question
.Introduced
	writetext .RematchText
.Question
	yesorno
	iffalse .Refused
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked ROUTE22_KUKUI
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .Rematch
	loadtrainer KUKUI, 1
	jump .StartBattle
.Rematch
	loadtrainer KUKUI, 2
.StartBattle
	startbattle
	reloadmapafterbattle
	setevent EVENT_INTRODUCED_KUKUI
	setevent EVENT_BEAT_KUKUI
	opentext
.Beaten:
	jumpopenedtext .AfterText

.Refused:
	jumpopenedtext .RefusedText

.IntroText:
	text "Hey there!"
	line "The name's Kukui."

	para "So, you go by"
	line "<PLAYER>? 10-4,"
	cont "good buddy!"

	para "I'm from the far-"
	line "off region of"
	cont "Alola!"

	para "But we don't have a"
	line "Pokemon League, so"

	para "I came to Kanto to"
	line "battle the Elite"
	cont "Four here, yeah!"

	para "Huh? You're the"
	line "new Champion?"

	para "Woo, no wonder you"
	line "look so stylin'!"

	para "My team and I feel"
	line "ready. How about"

	para "we skip the League"
	line "and challenge you"
	cont "right now?"
	done

.RematchText:
	text "Hey there,"
	line "<PLAYER>!"

	para "I've been training"
	line "hard since our"
	cont "last battle, yeah!"

	para "You look like you"
	line "got stronger too!"

	para "Say, how about a"
	line "rematch?"
	done

.SeenText:
	text "Let's have a battle"
	line "worthy of this"
	cont "moment!"
	done

.BeatenText:
	text "I couldn't win"
	line "even though I"
	cont "went all out…"
	done

.AfterText:
	text "Amazing! I went"
	line "right at you, and"
	cont "you still won!"

	para "No wonder you're"
	line "the Champion!"

	para "I need to train"
	line "harder before I'm"

	para "ready for the"
	line "League."

	para "And when I do,"
	line "I'll battle you"
	cont "again! Woo!"
	done

.RefusedText:
	text "Totally focused on"
	line "your own quest,"
	cont "yeah?"

	para "I respect that!"
	done

Route22CooltrainerfText:
	text "The name “Kanto”"
	line "means “east of the"
	cont "barrier.”"

	para "I suppose the"
	line "barrier must be"
	cont "Mt.Silver."
	done

VictoryRoadEntranceSignText:
	text "Route 22"

	para "#mon League"
	line "Reception Gate"
	done
