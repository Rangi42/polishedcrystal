OlivinePokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, OLIVINE_CITY, 1
	warp_event  6,  7, OLIVINE_CITY, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalJasmineScript

	def_object_events
	object_event  8,  1, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BeautyCharlotteScript, -1
	pc_nurse_event  5, 1
	object_event  2,  6, SPRITE_FISHING_GURU, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumpstd, happinesschecknpc, -1
	object_event  2,  3, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivinePokeCenter1FFisherText, -1
	object_event 11,  6, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivinePokeCenter1FTeacherText, -1

	object_const_def
	const OLIVINEPOKECENTER1F_BEAUTY

PokemonJournalJasmineScript:
	setflag ENGINE_READ_JASMINE_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Special Feature:"
	line "Leader Jasmine!"

	para "Rumor has it that"
	line "Jasmine and Erika,"

	para "the Celadon Gym"
	line "Leader, chat about"
	cont "fashion together."
	done

BeautyCharlotteScript:
	checkevent EVENT_BEAT_BEAUTY_CHARLOTTE
	iftrue_jumptextfaceplayer .AfterText
	faceplayer
	opentext
	writetext .GreetingText
	yesorno
	iffalse_jumpopenedtext .NoBattleText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked OLIVINEPOKECENTER1F_BEAUTY
	loadtrainer BEAUTY, CHARLOTTE
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BEAUTY_CHARLOTTE
	jumpthistext

.AfterText:
	text "How cool is it"
	line "to have such a"
	cont "special #mon?"
	done

.GreetingText:
	text "Oh, are you a"
	line "trainer?"

	para "You came at just"
	line "the right time!"

	para "My unique and"
	line "beautiful #mon"
	cont "is all healed."

	para "Do you want to"
	line "battle and be"

	para "amazed by my"
	line "#mon?"
	done

.NoBattleText:
	text "Oh, really? Talk"
	line "to me if you want"

	para "to battle some"
	line "time!"
	done

.SeenText:
	text "All right!"
	line "Here I come!"
	done

.BeatenText:
	text "Amazing battle!"
	done

OlivinePokeCenter1FFisherText:
	text "There's this guy in"
	line "Cianwood City who"
	cont "looks weak, but he"

	para "taught my #-"
	line "mon Strength."

	para "Now it can move"
	line "big boulders."
	done

OlivinePokeCenter1FTeacherText:
	text "There's a person"
	line "in Cianwood City"
	cont "across the sea."

	para "I heard him brag-"
	line "ging about his"
	cont "rare #mon."
	done
