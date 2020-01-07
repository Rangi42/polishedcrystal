LightningIslandRoof_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 1 ; warp events
	warp_event  3,  7, LIGHTNING_ISLAND, 2

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  5,  5, SPRITE_SPARK, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, LightningIslandRoofSparkScript, EVENT_SHAMOUTI_COAST_SPARK

	const_def 1 ; object constants
	const LIGHTNINGISLANDROOF_SPARK

LightningIslandRoofSparkScript:
	faceplayer
	opentext
	writetext .GreetingText
	yesorno
	iffalse .Refused
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	loadtrainer SPARK_T, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_SPARK
	checkevent EVENT_BEAT_BLANCHE
	iffalse .BlancheUndefeated
	checkevent EVENT_BEAT_CANDELA
	iffalse .CandelaUndefeated
	checkevent EVENT_BEAT_LAWRENCE
	iffalse .NeedSilverWing
	jump .AllBeaconsLit
	return

.BlancheUndefeated
	checkevent EVENT_BEAT_CANDELA
	iffalse .BothUndefeated
	showtext .BlancheUndefeatedText
	playsound SFX_WARP_TO
	applyonemovement LIGHTNINGISLANDROOF_SPARK, teleport_from
	disappear LIGHTNINGISLANDROOF_SPARK
	clearevent EVENT_CELADON_UNIVERSITY_SPARK
	end

.CandelaUndefeated
	showtext .CandelaUndefeatedText
	playsound SFX_WARP_TO
	applyonemovement LIGHTNINGISLANDROOF_SPARK, teleport_from
	disappear LIGHTNINGISLANDROOF_SPARK
	clearevent EVENT_CELADON_UNIVERSITY_SPARK
	end

.BothUndefeated
	showtext .AfterText
	playsound SFX_WARP_TO
	applyonemovement LIGHTNINGISLANDROOF_SPARK, teleport_from
	disappear LIGHTNINGISLANDROOF_SPARK
	clearevent EVENT_CELADON_UNIVERSITY_SPARK
	end

.NeedSilverWing
	showtext .NeedSilverWingText
	playsound SFX_WARP_TO
	applyonemovement LIGHTNINGISLANDROOF_SPARK, teleport_from
	disappear LIGHTNINGISLANDROOF_SPARK
	clearevent EVENT_CELADON_UNIVERSITY_SPARK
	end

.AllBeaconsLit
	showtext .AllBeaconsLitText
	playsound SFX_WARP_TO
	applyonemovement LIGHTNINGISLANDROOF_SPARK, teleport_from
	disappear LIGHTNINGISLANDROOF_SPARK
	clearevent EVENT_CELADON_UNIVERSITY_SPARK
	end'

.Refused:
	jumpopenedtext .RefusedText

.GreetingText:
	text "So you're the one"
	line "who caught Zapdos?"

	para "If you can do that"
	line "you might stand a"
	cont "chance against me."

	para "You're going to"
	line "have to be atleast"
	cont "that good if you're"

	para "hoping to find"
	line "Lugia."

	para "What do you say,"
	line "beat me and I'll"
	cont "light this beacon."

	para "You ready???"
	done

.SeenText:
	text "Let's go!"
	done

.BeatenText:
	text "You just might"
	line "stand a chance"
	cont "against Lugia..."
	done

.AfterText:
	text "Lugia won't just"
	line "appear for anyone."

	para "Find Articuno"
	line "and Moltres."

	para "Then Blanche and"
	line "Candela will"
	cont "help you light"

	para "the other beacons."
	done

.CandelaUndefeatedText:
	text "Lugia won't just"
	line "appear for anyone."

	para "Find Moltres."
	line "Then Candela will"
	cont "help you light"

	para "the last beacon."
	done

.BlancheUndefeatedText:
	text "Lugia won't just"
	line "appear for anyone."

	para "Find Articuno."
	line "Then Blanche will"
	cont "help you light"

	para "the last beacon."
	done

.NeedSilverWingText:
	text "You've lit all the"
	line "beacons?"

	para "If you had an item"
	line "familiar to Lugia,"
	cont "I'm sure it would"

	para "appear for you!"
	done

.AllBeaconsLitText:
	text "You've lit all the"
	line "beacons?"

	para "And is that the"
	line "SILVER WING you're"
	cont "carrying?"

	para "The mighty Lugia"
	line "will certainly"
	cont "appear for you!"

	para "It's said to dwell"
	line "Deep within the"
	cont "Whirlpool Islands."
	done	

.RefusedText:
	text "Fair enough!"
	line "Taking on Lugia is"
	cont "no easy task."
	done
