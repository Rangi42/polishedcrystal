Route19BeachHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, ROUTE_19, 2
	warp_event  3,  7, ROUTE_19, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route19BeachHouseVictorScript, -1
	object_event  6,  4, SPRITE_SURFING_PIKACHU, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route19BeachHouseSurfingPikachuScript, -1

	object_const_def
	const ROUTE19BEACHHOUSE_VICTOR

Route19BeachHouseVictorScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_VICTOR
	iftrue .AfterScript
	writetext .GreetingText
	waitbutton
	special CheckForSurfingPikachu
	iffalse .NoPikachu
	writetext .ChallengeText
	yesorno
	iffalse .NoBattle
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked ROUTE19BEACHHOUSE_VICTOR
	loadtrainer VICTOR, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_VICTOR
	opentext
.AfterScript:
	jumpopenedtext .AfterText

.NoPikachu:
	jumpopenedtext .NoPikachuText

.NoBattle:
	jumpopenedtext .NoBattleText

.GreetingText:
	text "Hey there, friend!"
	line "The name's Victor."

	para "I love to Surf,"
	line "and so does Puka."
	cont "That's my Pikachu!"
	done

.ChallengeText:
	text "Whoa!"

	para "Your Pikachu knows"
	line "how to Surf! So,"
	cont "I'm not alone…"

	para "Great! You earned"
	line "the right to a"

	para "Surfing battle"
	line "with me and Puka!"

	para "Give it a go?"
	done

.SeenText:
	text "The sea unites"
	line "all in surfdom!"
	cont "Let's go!"
	done

.BeatenText:
	text "I knew you could"
	line "do it!"
	done

.AfterText:
	text "I hear some Pika-"
	line "chu in Johto"

	para "taught themselves"
	line "to Surf."

	para "Maybe that's where"
	line "mine came from."

	para "I found Puka wash-"
	line "ed ashore years"
	cont "ago, and we've been"

	para "partners ever"
	line "since then."
	done

.NoPikachuText:
	text "You can do it,"
	line "too!"

	para "Go out there and"
	line "find a Surfing"
	cont "Pikachu!"

	para "Show me that you"
	line "love Surfing too!"
	done

.NoBattleText:
	text "Shucks. Come Surf"
	line "anytime, friend!"
	done

Route19BeachHouseSurfingPikachuScript:
	faceplayer
	showcrytext .Text, PIKACHU
	end

.Text:
	text "Puka: Pi-kaa!"
	done
