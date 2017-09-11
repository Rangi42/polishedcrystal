CeladonGym_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonGym_MapEventHeader:

.Warps: db 2
	warp_def 17, 4, 8, CELADON_CITY
	warp_def 17, 5, 8, CELADON_CITY

.XYTriggers: db 0

.Signposts: db 2
	signpost 15, 3, SIGNPOST_READ, CeladonGymStatue
	signpost 15, 6, SIGNPOST_READ, CeladonGymStatue

.PersonEvents: db 7
	person_event SPRITE_ERIKA, 3, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ErikaScript_0x72a6a, -1
	person_event SPRITE_LASS, 8, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerLassMichelle, -1
	person_event SPRITE_LASS, 8, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerPicnickerTanya, -1
	person_event SPRITE_BEAUTY, 5, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerBeautyJulia, -1
	person_event SPRITE_LADY, 5, 6, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerAroma_ladyDahlia, -1
	person_event SPRITE_TWIN, 10, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerTwinsJoandzoe1, -1
	person_event SPRITE_TWIN, 10, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerTwinsJoandzoe2, -1

ErikaScript_0x72a6a:
	faceplayer
	opentext
	checkflag ENGINE_RAINBOWBADGE
	iftrue .FightDone
	writetext UnknownText_0x72b28
	waitbutton
	closetext
	winlosstext UnknownText_0x72c3e, 0
	loadtrainer ERIKA, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_ERIKA
	setevent EVENT_BEAT_LASS_MICHELLE
	setevent EVENT_BEAT_PICNICKER_TANYA
	setevent EVENT_BEAT_BEAUTY_JULIA
	setevent EVENT_BEAT_AROMA_LADY_DAHLIA
	setevent EVENT_BEAT_TWINS_JO_AND_ZOE
	opentext
	writetext UnknownText_0x72c96
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_RAINBOWBADGE
	checkcode VAR_BADGES
	if_equal 9, .FirstBadge
	if_equal 10, .SecondBadge
	if_equal 12, .LyrasEgg
	jump .FightDone
.FirstBadge:
	specialphonecall SPECIALCALL_FIRSTBADGE
	jump .FightDone
.SecondBadge:
	checkevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	iftrue .FightDone
	specialphonecall SPECIALCALL_SECONDBADGE
	jump .FightDone
.LyrasEgg:
	specialphonecall SPECIALCALL_LYRASEGG
.FightDone:
	checkevent EVENT_GOT_TM19_GIGA_DRAIN
	iftrue_jumpopenedtext UnknownText_0x72d8f
	writetext UnknownText_0x72cb0
	buttonsound
	verbosegivetmhm TM_GIGA_DRAIN
	setevent EVENT_GOT_TM19_GIGA_DRAIN
	jumpopenedtext ErikaOutroText

TrainerLassMichelle:
	trainer EVENT_BEAT_LASS_MICHELLE, LASS, MICHELLE, LassMichelleSeenText, LassMichelleBeatenText, 0, LassMichelleScript

LassMichelleScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x72e30

TrainerPicnickerTanya:
	trainer EVENT_BEAT_PICNICKER_TANYA, PICNICKER, TANYA, PicnickerTanyaSeenText, PicnickerTanyaBeatenText, 0, PicnickerTanyaScript

PicnickerTanyaScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x72e8e

TrainerBeautyJulia:
	trainer EVENT_BEAT_BEAUTY_JULIA, BEAUTY, JULIA, BeautyJuliaSeenText, BeautyJuliaBeatenText, 0, BeautyJuliaScript

BeautyJuliaScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x72f01

TrainerAroma_ladyDahlia:
	trainer EVENT_BEAT_AROMA_LADY_DAHLIA, AROMA_LADY, DAHLIA, Aroma_ladyDahliaSeenText, Aroma_ladyDahliaBeatenText, 0, Aroma_ladyDahliaScript

Aroma_ladyDahliaScript:
	end_if_just_battled
	jumptextfaceplayer Aroma_ladyDahliaAfterText

TrainerTwinsJoandzoe1:
	trainer EVENT_BEAT_TWINS_JO_AND_ZOE, TWINS, JOANDZOE1, TwinsJoandzoe1SeenText, TwinsJoandzoe1BeatenText, 0, TwinsJoandzoe1Script

TwinsJoandzoe1Script:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x72f70

TrainerTwinsJoandzoe2:
	trainer EVENT_BEAT_TWINS_JO_AND_ZOE, TWINS, JOANDZOE2, TwinsJoandzoe2SeenText, TwinsJoandzoe2BeatenText, 0, TwinsJoandzoe2Script

TwinsJoandzoe2Script:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x72fc0

CeladonGymStatue:
	trainertotext ERIKA, 1, $1
	checkflag ENGINE_RAINBOWBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten:
	jumpstd gymstatue2

UnknownText_0x72b28:
	text "Erika: Hello…"
	line "Lovely weather,"

	para "isn't it?"
	line "It's so pleasant…"

	para "…I'm afraid I may"
	line "doze off…"

	para "My name is Erika."
	line "I am the Leader of"
	cont "Celadon Gym."

	para "…Oh? All the way"
	line "from Johto, you"
	cont "say? How nice…"

	para "Oh. I'm sorry, I"
	line "didn't realize"

	para "that you wished to"
	line "challenge me."

	para "Very well, but I"
	line "shall not lose."
	done

UnknownText_0x72c3e:
	text "Erika: Oh!"
	line "I concede defeat…"

	para "You are remarkably"
	line "strong…"

	para "I shall give you"
	line "the Rainbow Badge…"
	done

UnknownText_0x72c96:
	text "<PLAYER> received"
	line "the Rainbow Badge."
	done

UnknownText_0x72cb0:
	text "Erika: That was a"
	line "delightful match."

	para "I felt inspired."
	line "Please, I wish you"
	cont "to have this TM."
	done

ErikaOutroText:
	text "It is Giga Drain."

	para "It is a wonderful"
	line "move that drains"

	para "half the damage it"
	line "inflicts to heal"
	cont "your #mon."

	para "Please use it if"
	line "it pleases you…"
	done

UnknownText_0x72d8f:
	text "Erika: Losing"
	line "leaves a bitter"
	cont "aftertaste…"

	para "But knowing that"
	line "there are strong"

	para "trainers spurs me"
	line "to do better…"
	done

LassMichelleSeenText:
	text "Do you think a"
	line "girls-only Gym"
	cont "is rare?"
	done

LassMichelleBeatenText:
	text "Oh, bleah!"
	done

UnknownText_0x72e30:
	text "I just got care-"
	line "less, that's all!"
	done

PicnickerTanyaSeenText:
	text "Oh, a battle?"
	line "That's kind of"
	cont "scary, but OK!"
	done

PicnickerTanyaBeatenText:
	text "Oh, that's it?"
	done

UnknownText_0x72e8e:
	text "Oh, look at all"
	line "your Badges. No"

	para "wonder I couldn't"
	line "win!"
	done

BeautyJuliaSeenText:
	text "Were you looking"
	line "at these flowers"
	cont "or at me?"
	done

BeautyJuliaBeatenText:
	text "How annoying!"
	done

UnknownText_0x72f01:
	text "How do I go about"
	line "becoming ladylike"
	cont "like Erika?"
	done

Aroma_ladyDahliaSeenText:
	text "There is an in-"
	line "triguing scent"
	cont "around you…"
	done

Aroma_ladyDahliaBeatenText:
	text "The foul scent"
	line "of defeat…"
	done

Aroma_ladyDahliaAfterText:
	text "Gloom releases a"
	line "foul fragrance,"

	para "but Erika knows"
	line "how to turn it"

	para "into a sweet"
	line "perfume."
	done

TwinsJoandzoe1SeenText:
	text "We'll show you"
	line "#mon moves that"
	cont "Erika taught us!"
	done

TwinsJoandzoe1BeatenText:
	text "Oh… We lost…"
	done

UnknownText_0x72f70:
	text "Erika will get you"
	line "back for us!"
	done

TwinsJoandzoe2SeenText:
	text "We're going to"
	line "protect Erika!"
	done

TwinsJoandzoe2BeatenText:
	text "We couldn't win…"
	done

UnknownText_0x72fc0:
	text "Erika is much,"
	line "much stronger!"
	done
