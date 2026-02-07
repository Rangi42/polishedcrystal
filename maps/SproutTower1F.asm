SproutTower1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7, 15, VIOLET_CITY, 7
	warp_event  8, 15, VIOLET_CITY, 7
	warp_event  4,  4, SPROUT_TOWER_2F, 1
	warp_event  0,  6, SPROUT_TOWER_2F, 2
	warp_event 15,  3, SPROUT_TOWER_2F, 3

	def_coord_events

	def_bg_events
	bg_event  5, 15, BGEVENT_JUMPTEXT, SproutTower1FStatueText
	bg_event 10, 15, BGEVENT_JUMPTEXT, SproutTower1FStatueText

	def_object_events
	object_event 11,  4, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, KimonoGirlMakoScript, -1
	object_event  5,  4, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SproutTower1FSage1Text, -1
	object_event  4,  7, SPRITE_SAGE, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SproutTower1FSage2Text, -1
	object_event  9, 12, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, SproutTower1FGrannyScript, -1
	object_event  7,  9, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SproutTower1FTeacherText, -1
	object_event  1,  5, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSageChow, -1
	itemball_event 14,  7, PARALYZEHEAL, 1, EVENT_SPROUT_TOWER1F_PARALYZEHEAL

	object_const_def
	const SPROUTTOWER1F_KIMONO_GIRL

SproutTower1FGrannyScript:
	checkunits
	iftrue_jumptextfaceplayer .MetricText
	jumpthistextfaceplayer

	text "A Bellsprout over"
	line "100 feet tall…"

	para "People say that it"
	line "became the center"
	cont "pillar here."
	done

.MetricText:
	text "A Bellsprout over"
	line "30 meters tall…"

	para "People say that it"
	line "became the center"
	cont "pillar here."
	done

GenericTrainerSageChow:
	generictrainer SAGE, CHOW, EVENT_BEAT_SAGE_CHOW, SageChowSeenText, SageChowBeatenText

	text "All living beings"
	line "coexist through"
	cont "cooperation."

	para "We must always be"
	line "thankful for this."
	done

SageChowSeenText:
	text "We stand guard in"
	line "this tower."

	para "Here, we express"
	line "our gratitude to"
	cont "honor all #mon."
	done

SageChowBeatenText:
	text "Th-Thank you!"
	done

SproutTower1FSage1Text:
	text "Only if you reach"
	line "the top will you"
	cont "obtain a TM."
	done

SproutTower1FSage2Text:
	text "Sprout Tower was"
	line "built long ago"

	para "as a place for"
	line "#mon training."
	done

SproutTower1FTeacherText:
	text "See the pillar"
	line "shaking?"

	para "People are train-"
	line "ing upstairs."
	done

SproutTower1FStatueText:
	text "A #mon statue…"

	para "It looks very"
	line "distinguished."
	done

KimonoGirlMakoScript:
	checkevent EVENT_GOT_RARE_CANDY_FROM_KIMONO_GIRL_MAKO
	iftrue_jumptextfaceplayer .OutroText
	faceplayer
	checkevent EVENT_BEAT_KIMONO_GIRL_MAKO
	iftruefwd .Beaten
	checkevent EVENT_BEAT_KIMONO_GIRL_NAOKO
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_KIMONO_GIRL_SAYO
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_KIMONO_GIRL_ZUKI
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_KIMONO_GIRL_KUNI
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_KIMONO_GIRL_MIKI
	iffalse_jumptext .IntroText
	showtext .SeenText
	winlosstext .BeatenText, 0
	setlasttalked SPROUTTOWER1F_KIMONO_GIRL
	loadtrainerwithpal KIMONO_GIRL, MAKO, TRAINERPAL_MAKO
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_KIMONO_GIRL_MAKO
.Beaten:
	opentext
	writetext .AfterText
	promptbutton
	verbosegiveitem RARE_CANDY
	iffalse_endtext
	setevent EVENT_GOT_RARE_CANDY_FROM_KIMONO_GIRL_MAKO
	jumpthisopenedtext

.OutroText:
	text "We Kimono Girls"
	line "dance, but we also"
	cont "battle."
	done

.IntroText:
	text "Hello, trainer."

	para "I am a Kimono"
	line "Girl."

	para "I journeyed here"
	line "from Ecruteak"

	para "City, through for-"
	line "est and cavern,"

	para "to train in this"
	line "tower."

	para "Have you met my"
	line "five dancing cou-"
	cont "sins in Ecruteak?"

	para "Come back and"
	line "tell me if you do!"
	done

.SeenText:
	text "Me oh my…"
	line "You defeated my"

	para "five dancing"
	line "cousins?"

	para "Then allow me to"
	line "challenge you and"
	cont "your #mon!"
	done

.BeatenText:
	text "Oh, you are"
	line "truly strong…"
	done

.AfterText:
	text "Excellent fighting"
	line "spirit!"

	para "You will know what"
	line "to do with this!"
	done
