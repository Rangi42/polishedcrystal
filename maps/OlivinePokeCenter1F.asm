OlivinePokeCenter1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

OlivinePokeCenter1F_MapEventHeader:

.Warps: db 3
	warp_def 7, 5, 1, OLIVINE_CITY
	warp_def 7, 6, 1, OLIVINE_CITY
	warp_def 7, 0, 1, POKECENTER_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalJasmineScript

.PersonEvents: db 5
	person_event SPRITE_BEAUTY, 1, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BeautyCharlotteScript, -1
	pc_nurse_event 1, 5
	person_event SPRITE_FISHING_GURU, 6, 2, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, happinesschecknpc, -1
	person_event SPRITE_FISHER, 3, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, OlivinePokeCenter1FFisherText, -1
	person_event SPRITE_TEACHER, 6, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, OlivinePokeCenter1FTeacherText, -1

const_value set 1
	const OLIVINEPOKECENTER1F_BEAUTY

PokemonJournalJasmineScript:
	setflag ENGINE_READ_JASMINE_JOURNAL
	thistext

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
	thistext

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
