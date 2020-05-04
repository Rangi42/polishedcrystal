INCLUDE "constants.asm"


SECTION "_FruitBearingTreeText", ROMX
_FruitBearingTreeText::
	text "It's a fruit-"
	line "bearing tree."
	done

SECTION "_HeyItsFruitText", ROMX
_HeyItsFruitText::
	text "Hey! It's"
	line ""
	text_from_ram wStringBuffer3
	text "!"
	done

SECTION "_ObtainedOneFruitText", ROMX
_ObtainedOneFruitText::
	text "Obtained a"
	line ""
	text_from_ram wStringBuffer3
	text "!"
	done

SECTION "_ObtainedTwoFruitText", ROMX
_ObtainedTwoFruitText::
	text "Obtained two"
	line ""
	text_from_ram wStringBuffer3
	text "!"
	done

SECTION "_ObtainedThreeFruitText", ROMX
_ObtainedThreeFruitText::
	text "Obtained three"
	line ""
	text_from_ram wStringBuffer3
	text "!"
	done

SECTION "_FruitPackIsFullText", ROMX
_FruitPackIsFullText::
	text "But the Bag is"
	line "full…"
	done

SECTION "_NoApricornBoxText", ROMX
_NoApricornBoxText::
	text "But there's nothing"
	line "to put it in…"
	done

SECTION "_ApricornBoxIsFullText", ROMX
_ApricornBoxIsFullText::
	text "But the Apricorn"
	line "Box is full…"
	done

SECTION "_PutAwayTheApricornText", ROMX
_PutAwayTheApricornText::
	text "<PLAYER> put the"
	line ""
	text_from_ram wStringBuffer3
	text " in"
	cont "the Apricorn Box."
	done

SECTION "_NothingHereText", ROMX
_NothingHereText::
	text "There's nothing"
	line "here…"
	done

SECTION "_WantToUseMulchText", ROMX
_WantToUseMulchText::
	text "Want to use"
	line "Mulch?"
	done

SECTION "_UsedMulchText", ROMX
_UsedMulchText::
	text "<PLAYER> used"
	line "Mulch!"

	para "The tree was"
	line "fertilized!"
	done

SECTION "UnknownText_0x1bc06b", ROMX
UnknownText_0x1bc06b::
	text "Which Apricorn"
	line "should I use?"
	done

SECTION "UnknownText_0x1bc089", ROMX
UnknownText_0x1bc089::
	text "How many should I"
	line "make?"
	done

SECTION "UnknownText_0x1bc0a2", ROMX
UnknownText_0x1bc0a2::
	text_from_ram wStringBuffer1
	text_start
	line "recovered "
	deciram wCurHPAnimDeltaHP, 2, 3
	text "HP!"
	done

SECTION "UnknownText_0x1bc0bb", ROMX
UnknownText_0x1bc0bb::
	text_from_ram wStringBuffer1
	text "'s"
	line "cured of poison."
	done

SECTION "UnknownText_0x1bc0d2", ROMX
UnknownText_0x1bc0d2::
	text_from_ram wStringBuffer1
	text "'s"
	line "rid of paralysis."
	done

SECTION "UnknownText_0x1bc0ea", ROMX
UnknownText_0x1bc0ea::
	text_from_ram wStringBuffer1
	text "'s"
	line "burn was healed."
	done

SECTION "UnknownText_0x1bc101", ROMX
UnknownText_0x1bc101::
	text_from_ram wStringBuffer1
	text_start
	line "was defrosted."
	done

SECTION "UnknownText_0x1bc115", ROMX
UnknownText_0x1bc115::
	text_from_ram wStringBuffer1
	text_start
	line "woke up."
	done

SECTION "UnknownText_0x1bc123", ROMX
UnknownText_0x1bc123::
	text_from_ram wStringBuffer1
	text "'s"
	line "health returned."
	done

SECTION "UnknownText_0x1bc13a", ROMX
UnknownText_0x1bc13a::
	text_from_ram wStringBuffer1
	text_start
	line "is revitalized."
	done

SECTION "UnknownText_0x1bc14f", ROMX
UnknownText_0x1bc14f::
	text_from_ram wStringBuffer1
	text " grew to"
	line "level "
	deciram wCurPartyLevel, 1, 3
	text "!"
	play_sound SFX_DEX_FANFARE_50_79
	text_waitbutton
	text_end

SECTION "UnknownText_0x1bc16e", ROMX
UnknownText_0x1bc16e::
	text_from_ram wStringBuffer1
	text " came"
	line "to its senses."
	done

SECTION "UnknownText_0x1bc29c", ROMX
UnknownText_0x1bc29c::
	text "………………………………"
	line "………………………………"

	para "Zzz… Hm? Wha…?"
	line "You woke me up!"

	para "Will you check the"
	line "clock for me?"
	prompt

SECTION "UnknownText_0x1bc2eb", ROMX
UnknownText_0x1bc2eb::
	text "What time is it?"
	done

SECTION "UnknownText_0x1bc2fd", ROMX
UnknownText_0x1bc2fd::
	text "What?"
	done

SECTION "UnknownText_0x1bc305", ROMX
UnknownText_0x1bc305::
	text "?"
	done

SECTION "UnknownText_0x1bc308", ROMX
UnknownText_0x1bc308::
	text "How many minutes?"
	done

SECTION "UnknownText_0x1bc31b", ROMX
UnknownText_0x1bc31b::
	text "Whoa!"
	done

SECTION "UnknownText_0x1bc323", ROMX
UnknownText_0x1bc323::
	text "?"
	done

SECTION "UnknownText_0x1bc326", ROMX
UnknownText_0x1bc326::
	text "!"
	line "I overslept!"
	done

SECTION "UnknownText_0x1bc336", ROMX
UnknownText_0x1bc336::
	text "!"
	line "Yikes! I over-"
	cont "slept!"
	done

SECTION "UnknownText_0x1bc34f", ROMX
UnknownText_0x1bc34f::
	text "!"
	line "No wonder it's so"
	cont "dark!"
	done

SECTION "UnknownText_0x1bc369", ROMX
UnknownText_0x1bc369::
	text "What day is it?"
	done

SECTION "UnknownText_0x1bc37a", ROMX
UnknownText_0x1bc37a::
	text ", is it?"
	done

SECTION "UnknownText_0x1bc471", ROMX
UnknownText_0x1bc471::
	text "There's nothing to"
	line "choose."
	prompt

SECTION "UnknownText_0x1bc48c", ROMX
UnknownText_0x1bc48c::
	text "Which side do you"
	line "want to put it on?"
	done

SECTION "UnknownText_0x1bc4b2", ROMX
UnknownText_0x1bc4b2::
	text "Which side do you"
	line "want to put away?"
	done

SECTION "UnknownText_0x1bc4d7", ROMX
UnknownText_0x1bc4d7::
	text "Put away the"
	line ""
	text_from_ram wStringBuffer3
	text "."
	prompt

SECTION "UnknownText_0x1bc4ec", ROMX
UnknownText_0x1bc4ec::
	text "There's nothing to"
	line "put away."
	prompt

SECTION "UnknownText_0x1bc509", ROMX
UnknownText_0x1bc509::
	text "Set up the"
	line ""
	text_from_ram wStringBuffer3
	text "."
	prompt

SECTION "UnknownText_0x1bc51c", ROMX
UnknownText_0x1bc51c::
	text "Put away the"
	line ""
	text_from_ram wStringBuffer3
	text_start

	para "and set up the"
	line ""
	text_from_ram wStringBuffer4
	text "."
	prompt

SECTION "UnknownText_0x1bc546", ROMX
UnknownText_0x1bc546::
	text "That's already set"
	line "up."
	prompt

SECTION "UnknownText_0x1bc55d", ROMX
UnknownText_0x1bc55d::
	text "It's the Town Map."
	done

SECTION "UnknownText_0x1bc570", ROMX
UnknownText_0x1bc570::
	text "It's a poster of a"
	line "cute Pikachu."
	done

SECTION "UnknownText_0x1bc591", ROMX
UnknownText_0x1bc591::
	text "It's a poster of a"
	line "cute Clefairy."
	done

SECTION "UnknownText_0x1bc5b3", ROMX
UnknownText_0x1bc5b3::
	text "It's a poster of a"
	line "cute Marill."
	done

SECTION "UnknownText_0x1bc5d7", ROMX
UnknownText_0x1bc5d7::
	text "It's an adorable"
	line ""
	text_from_ram wStringBuffer3
	text "."
	done

SECTION "DecoConsoleText", ROMX
DecoConsoleText::
	text "It's a shiny"
	line ""
	text_from_ram wStringBuffer3
	text "."
	done

SECTION "UnknownText_0x1bc5ef", ROMX
UnknownText_0x1bc5ef::
	text "A giant doll! It's"
	line "fluffy and cuddly."
	done

SECTION "UnknownText_0x1bc615", ROMX
UnknownText_0x1bc615::
	text "Hi, <PLAYER>!"
	line "How are you?"
	prompt

SECTION "UnknownText_0x1bc62a", ROMX
UnknownText_0x1bc62a::
	text "I found a useful"
	line "item shopping, so"
	prompt

SECTION "UnknownText_0x1bc64e", ROMX
UnknownText_0x1bc64e::
	text "I bought it with"
	line "your money. Sorry!"
	prompt

SECTION "UnknownText_0x1bc673", ROMX
UnknownText_0x1bc673::
	text "It's in your PC."
	line "You'll like it!"
	done

SECTION "UnknownText_0x1bc693", ROMX
UnknownText_0x1bc693::
	text "While shopping"
	line "today, I saw this"
	cont "adorable doll, so"
	prompt

SECTION "UnknownText_0x1bc6c7", ROMX
UnknownText_0x1bc6c7::
	text "It's in your room."
	line "You'll love it!"
	done

SECTION "UnknownText_0x1bc6e9", ROMX
UnknownText_0x1bc6e9::
	text_from_ram wPlayerTrademonSpeciesName
	text " was"
	line "sent to "
	text_from_ram wOTTrademonSenderName
	text "."
	done

SECTION "UnknownText_0x1bc701", ROMX
UnknownText_0x1bc701::
	text_start
	done

SECTION "UnknownText_0x1bc703", ROMX
UnknownText_0x1bc703::
	text_from_ram wOTTrademonSenderName
	text " bids"
	line "farewell to"
	done

SECTION "UnknownText_0x1bc719", ROMX
UnknownText_0x1bc719::
	text_from_ram wOTTrademonSpeciesName
	text "."
	done

SECTION "UnknownText_0x1bc71f", ROMX
UnknownText_0x1bc71f::
	text "Take good care of"
	line ""
	text_from_ram wOTTrademonSpeciesName
	text "."
	done

SECTION "UnknownText_0x1bc739", ROMX
UnknownText_0x1bc739::
	text "For "
	text_from_ram wPlayerTrademonSenderName
	text "'s"
	line ""
	text_from_ram wPlayerTrademonSpeciesName
	text ","
	done

SECTION "UnknownText_0x1bc74c", ROMX
UnknownText_0x1bc74c::
	text_from_ram wOTTrademonSenderName
	text " sends"
	line ""
	text_from_ram wOTTrademonSpeciesName
	text "."
	done

SECTION "UnknownText_0x1bc75e", ROMX
UnknownText_0x1bc75e::
	text_from_ram wOTTrademonSenderName
	text " will"
	line "trade "
	text_from_ram wOTTrademonSpeciesName
	text_end

SECTION "UnknownText_0x1bc774", ROMX
UnknownText_0x1bc774::
	text "for "
	text_from_ram wPlayerTrademonSenderName
	text "'s"
	line ""
	text_from_ram wPlayerTrademonSpeciesName
	text "."
	done

; Oak's Pokémon Talk

SECTION "_OPT_IntroText1", ROMX
_OPT_IntroText1::
	text_start
	line "Mary: Prof.Oak's"
	done

SECTION "_OPT_IntroText2", ROMX
_OPT_IntroText2::
	text_start
	line "#mon Talk!"
	done

SECTION "_OPT_IntroText3", ROMX
_OPT_IntroText3::
	text_start
	line "With me, Mary!"
	done

SECTION "_OPT_OakText1", ROMX
_OPT_OakText1::
	text_start
	line "Oak: "
	text_from_ram wMonOrItemNameBuffer
	text_end

SECTION "_OPT_OakText2", ROMX
_OPT_OakText2::
	text_start
	line "may be seen around"
	done

SECTION "_OPT_OakText3", ROMX
_OPT_OakText3::
	text_start
	line ""
	text_from_ram wStringBuffer1
	text "."
	done

SECTION "_OPT_MaryText1", ROMX
_OPT_MaryText1::
	text_start
	line "Mary: "
	text_from_ram wStringBuffer1
	text "'s"
	done

SECTION "OPT_SweetAdorably", ROMX
OPT_SweetAdorably::
	text_start
	line "sweet and adorably"
	done

SECTION "OPT_WigglySlickly", ROMX
OPT_WigglySlickly::
	text_start
	line "wiggly and slickly"
	done

SECTION "OPT_AptlyNamed", ROMX
OPT_AptlyNamed::
	text_start
	line "aptly named and"
	done

SECTION "OPT_UndeniablyKindOf", ROMX
OPT_UndeniablyKindOf::
	text_start
	line "undeniably kind of"
	done

SECTION "OPT_Unbearably", ROMX
OPT_Unbearably::
	text_start
	line "so, so unbearably"
	done

SECTION "OPT_WowImpressively", ROMX
OPT_WowImpressively::
	text_start
	line "wow, impressively"
	done

SECTION "OPT_AlmostPoisonously", ROMX
OPT_AlmostPoisonously::
	text_start
	line "almost poisonously"
	done

SECTION "OPT_Sensually", ROMX
OPT_Sensually::
	text_start
	line "ooh, so sensually"
	done

SECTION "OPT_Mischievously", ROMX
OPT_Mischievously::
	text_start
	line "so mischievously"
	done

SECTION "OPT_Topically", ROMX
OPT_Topically::
	text_start
	line "so very topically"
	done

SECTION "OPT_Addictively", ROMX
OPT_Addictively::
	text_start
	line "sure addictively"
	done

SECTION "OPT_LooksInWater", ROMX
OPT_LooksInWater::
	text_start
	line "looks in water is"
	done

SECTION "OPT_EvolutionMustBe", ROMX
OPT_EvolutionMustBe::
	text_start
	line "evolution must be"
	done

SECTION "OPT_Provocatively", ROMX
OPT_Provocatively::
	text_start
	line "provocatively"
	done

SECTION "OPT_FlippedOut", ROMX
OPT_FlippedOut::
	text_start
	line "so flipped out and"
	done

SECTION "OPT_HeartMeltingly", ROMX
OPT_HeartMeltingly::
	text_start
	line "heart-meltingly"
	done

SECTION "OPT_Cute", ROMX
OPT_Cute::
	text_start
	line "cute."
	done

SECTION "OPT_Weird", ROMX
OPT_Weird::
	text_start
	line "weird."
	done

SECTION "OPT_Pleasant", ROMX
OPT_Pleasant::
	text_start
	line "pleasant."
	done

SECTION "OPT_BoldSortOf", ROMX
OPT_BoldSortOf::
	text_start
	line "bold, sort of."
	done

SECTION "OPT_Frightening", ROMX
OPT_Frightening::
	text_start
	line "frightening."
	done

SECTION "OPT_SuaveDebonair", ROMX
OPT_SuaveDebonair::
	text_start
	line "suave & debonair!"
	done

SECTION "OPT_Powerful", ROMX
OPT_Powerful::
	text_start
	line "powerful."
	done

SECTION "OPT_Exciting", ROMX
OPT_Exciting::
	text_start
	line "exciting."
	done

SECTION "OPT_Groovy", ROMX
OPT_Groovy::
	text_start
	line "groovy!"
	done

SECTION "OPT_Inspiring", ROMX
OPT_Inspiring::
	text_start
	line "inspiring."
	done

SECTION "OPT_Friendly", ROMX
OPT_Friendly::
	text_start
	line "friendly."
	done

SECTION "OPT_HotHotHot", ROMX
OPT_HotHotHot::
	text_start
	line "hot, hot, hot!"
	done

SECTION "OPT_Stimulating", ROMX
OPT_Stimulating::
	text_start
	line "stimulating."
	done

SECTION "OPT_Guarded", ROMX
OPT_Guarded::
	text_start
	line "guarded."
	done

SECTION "OPT_Lovely", ROMX
OPT_Lovely::
	text_start
	line "lovely."
	done

SECTION "OPT_Speedy", ROMX
OPT_Speedy::
	text_start
	line "speedy."
	done

SECTION "_OPT_PokemonChannelText", ROMX
_OPT_PokemonChannelText::
	text "#mon"
	done

SECTION "_PokedexShowText", ROMX
_PokedexShowText::
	text_start
	line ""
	text_from_ram wStringBuffer1
	text_end

; Pokémon Music Channel / Pokémusic

SECTION "_BenIntroText1", ROMX
_BenIntroText1::
	text_start
	line "Ben: #mon Music"
	done

SECTION "_BenIntroText2", ROMX
_BenIntroText2::
	text_start
	line "Channel! ♪"
	done

SECTION "_BenIntroText3", ROMX
_BenIntroText3::
	text_start
	line "It's me, DJ Ben! ♪"
	done

SECTION "_FernIntroText1", ROMX
_FernIntroText1::
	text_start
	line "Fern: #music! ♪"
	done

SECTION "_FernIntroText2", ROMX
_FernIntroText2::
	text_start
	line "With DJ Fern! ♪"
	done

SECTION "_BenFernText1", ROMX
_BenFernText1::
	text_start
	line "Today's "
	current_day
	text ","
	done

SECTION "_BenFernText2A", ROMX
_BenFernText2A::
	text_start
	line "so let's jam to"
	done

SECTION "_BenFernText2B", ROMX
_BenFernText2B::
	text_start
	line "so chill out to"
	done

SECTION "_BenFernText3A", ROMX
_BenFernText3A::
	text_start
	line "#mon March!"
	done

SECTION "_BenFernText3B", ROMX
_BenFernText3B::
	text_start
	line "#mon Lullaby!"
	done

; Lucky Channel

SECTION "_LC_Text1", ROMX
_LC_Text1::
	text_start
	line "Reed: Yeehaw! How"
	done

SECTION "_LC_Text2", ROMX
_LC_Text2::
	text_start
	line "y'all doin' now?"
	done

SECTION "_LC_Text3", ROMX
_LC_Text3::
	text_start
	line "Whether you're up"
	done

SECTION "_LC_Text4", ROMX
_LC_Text4::
	text_start
	line "or way down low,"
	done

SECTION "_LC_Text5", ROMX
_LC_Text5::
	text_start
	line "don't you miss the"
	done

SECTION "_LC_Text6", ROMX
_LC_Text6::
	text_start
	line "Lucky Number Show!"
	done

SECTION "_LC_Text7", ROMX
_LC_Text7::
	text_start
	line "This week's Lucky"
	done

SECTION "_LC_Text8", ROMX
_LC_Text8::
	text_start
	line "Number is "
	interpret_data
	text_from_ram wStringBuffer1
	text "!"
	done

SECTION "_LC_Text9", ROMX
_LC_Text9::
	text_start
	line "I'll repeat that!"
	done

SECTION "_LC_Text10", ROMX
_LC_Text10::
	text_start
	line "Match it and go to"
	done

SECTION "_LC_Text11", ROMX
_LC_Text11::
	text_start
	line "the Radio Tower!"
	done

SECTION "_LC_DragText1", ROMX
_LC_DragText1::
	text_start
	line "…Repeating myself"
	done

SECTION "_LC_DragText2", ROMX
_LC_DragText2::
	text_start
	line "gets to be a drag…"
	done

; Places and People

SECTION "_PnP_Text1", ROMX
_PnP_Text1::
	text_start
	line "Places and People!"
	done

SECTION "_PnP_Text2", ROMX
_PnP_Text2::
	text_start
	line "Brought to you by"
	done

SECTION "_PnP_Text3", ROMX
_PnP_Text3::
	text_start
	line "me, DJ Lily!"
	done

SECTION "_PnP_Text4", ROMX
_PnP_Text4::
	text_start
	line "@"
	text_from_ram wStringBuffer2
	text_start
	text " @"
	text_from_ram wStringBuffer1
	text_end

SECTION "_PnP_cute", ROMX
_PnP_cute::
	text_start
	line "is cute."
	done

SECTION "_PnP_lazy", ROMX
_PnP_lazy::
	text_start
	line "is sort of lazy."
	done

SECTION "_PnP_happy", ROMX
_PnP_happy::
	text_start
	line "is always happy."
	done

SECTION "_PnP_noisy", ROMX
_PnP_noisy::
	text_start
	line "is quite noisy."
	done

SECTION "_PnP_precocious", ROMX
_PnP_precocious::
	text_start
	line "is precocious."
	done

SECTION "_PnP_bold", ROMX
_PnP_bold::
	text_start
	line "is somewhat bold."
	done

SECTION "_PnP_picky", ROMX
_PnP_picky::
	text_start
	line "is too picky!"
	done

SECTION "_PnP_sortofok", ROMX
_PnP_sortofok::
	text_start
	line "is sort of OK."
	done

SECTION "_PnP_soso", ROMX
_PnP_soso::
	text_start
	line "is just so-so."
	done

SECTION "_PnP_great", ROMX
_PnP_great::
	text_start
	line "is actually great."
	done

SECTION "_PnP_mytype", ROMX
_PnP_mytype::
	text_start
	line "is just my type."
	done

SECTION "_PnP_cool", ROMX
_PnP_cool::
	text_start
	line "is so cool, no?"
	done

SECTION "_PnP_inspiring", ROMX
_PnP_inspiring::
	text_start
	line "is inspiring!"
	done

SECTION "_PnP_weird", ROMX
_PnP_weird::
	text_start
	line "is kind of weird."
	done

SECTION "_PnP_rightforme", ROMX
_PnP_rightforme::
	text_start
	line "is right for me?"
	done

SECTION "_PnP_odd", ROMX
_PnP_odd::
	text_start
	line "is definitely odd!"
	done

SECTION "_PnP_Text5", ROMX
_PnP_Text5::
	text_start
	line "@"
	text_from_ram wStringBuffer1
	text_end

SECTION "_RocketRadioText1", ROMX
_RocketRadioText1::
	text_start
	line "… …Ahem, we are"
	done

SECTION "_RocketRadioText2", ROMX
_RocketRadioText2::
	text_start
	line "Team Rocket!"
	done

SECTION "_RocketRadioText3", ROMX
_RocketRadioText3::
	text_start
	line "After three years"
	done

SECTION "_RocketRadioText4", ROMX
_RocketRadioText4::
	text_start
	line "of preparation, we"
	done

SECTION "_RocketRadioText5", ROMX
_RocketRadioText5::
	text_start
	line "have risen again"
	done

SECTION "_RocketRadioText6", ROMX
_RocketRadioText6::
	text_start
	line "from the ashes!"
	done

SECTION "_RocketRadioText7", ROMX
_RocketRadioText7::
	text_start
	line "Giovanni! "
	interpret_data
	text "Can you"
	done

SECTION "_RocketRadioText8", ROMX
_RocketRadioText8::
	text_start
	line "hear?"
	interpret_data
	text " We did it!"
	done

SECTION "_RocketRadioText9", ROMX
_RocketRadioText9::
	text_start
	line ""
	interpret_data
	text "Where is our boss?"
	done

SECTION "_RocketRadioText10", ROMX
_RocketRadioText10::
	text_start
	line ""
	interpret_data
	text "Is he listening?"
	done

SECTION "_BuenaRadioText1", ROMX
_BuenaRadioText1::
	text_start
	line "Buena: Buena here!"
	done

SECTION "_BuenaRadioText2", ROMX
_BuenaRadioText2::
	text_start
	line "Today's password!"
	done

SECTION "_BuenaRadioText3", ROMX
_BuenaRadioText3::
	text_start
	line "Let me think… It's"
	done

SECTION "_BuenaRadioText4", ROMX
_BuenaRadioText4::
	text_start
	line ""
	text_from_ram wStringBuffer1
	text "!"
	done

SECTION "_BuenaRadioText5", ROMX
_BuenaRadioText5::
	text_start
	line "Don't forget it!"
	done

SECTION "_BuenaRadioText6", ROMX
_BuenaRadioText6::
	text_start
	line "I'm in Goldenrod's"
	done

SECTION "_BuenaRadioText7", ROMX
_BuenaRadioText7::
	text_start
	line "Radio Tower!"
	done

SECTION "_BuenaRadioMidnightText1", ROMX
_BuenaRadioMidnightText1::
	text_start
	line "Buena: Oh my…"
	done

SECTION "_BuenaRadioMidnightText2", ROMX
_BuenaRadioMidnightText2::
	text_start
	line "It's midnight! I"
	done

SECTION "_BuenaRadioMidnightText3", ROMX
_BuenaRadioMidnightText3::
	text_start
	line "have to shut down!"
	done

SECTION "_BuenaRadioMidnightText4", ROMX
_BuenaRadioMidnightText4::
	text_start
	line "Thanks for tuning"
	done

SECTION "_BuenaRadioMidnightText5", ROMX
_BuenaRadioMidnightText5::
	text_start
	line "in to the end! But"
	done

SECTION "_BuenaRadioMidnightText6", ROMX
_BuenaRadioMidnightText6::
	text_start
	line "don't stay up too"
	done

SECTION "_BuenaRadioMidnightText7", ROMX
_BuenaRadioMidnightText7::
	text_start
	line "late! Presented to"
	done

SECTION "_BuenaRadioMidnightText8", ROMX
_BuenaRadioMidnightText8::
	text_start
	line "you by DJ Buena!"
	done

SECTION "_BuenaRadioMidnightText9", ROMX
_BuenaRadioMidnightText9::
	text "I'm outta here!"
	done

SECTION "_BuenaRadioMidnightText10", ROMX
_BuenaRadioMidnightText10::
	text "…"
	done

SECTION "_BuenaOffTheAirText", ROMX
_BuenaOffTheAirText::
	text_start
	line ""
	done

SECTION "Text_EnemyUsed", ROMX
Text_EnemyUsed::
	text "<ENEMY>"
	line "used "
	text_from_ram wMonOrItemNameBuffer
	text "!"
	prompt

SECTION "Text_EnemyUsedOn", ROMX
Text_EnemyUsedOn::
	text "<ENEMY>"
	line "used "
	text_from_ram wMonOrItemNameBuffer
	text_start
	cont "on "
	text_from_ram wEnemyMonNick
	text "!"
	prompt

SECTION "UnknownText_0x1bd2bc", ROMX
UnknownText_0x1bd2bc::
	text "Which floor?"
	done

SECTION "UnknownText_0x1bd2ca", ROMX
UnknownText_0x1bd2ca::
	text "Announcer: BEEEP!"

	para "Time's up!"
	done

SECTION "UnknownText_0x1bd2e7", ROMX
UnknownText_0x1bd2e7::
	text "Announcer: The"
	line "Contest is over!"
	done

SECTION "UnknownText_0x1bd308", ROMX
UnknownText_0x1bd308::
	text "Repel's effect"
	line "wore off."
	done

SECTION "UseAnotherRepelText", ROMX
UseAnotherRepelText::
	text "Repel's effect"
	line "wore off."

	para "Use another?"
	done

SECTION "UnknownText_0x1bd34b", ROMX
UnknownText_0x1bd34b::
	text "I just saw some"
	line "rare "
	text_from_ram wStringBuffer1
	text " in"
	cont ""
	text_from_ram wStringBuffer2
	text "."

	para "I'll call you if I"
	line "see another rare"
	cont "#mon, OK?"
	prompt

SECTION "UnknownText_0x1bd39e", ROMX
UnknownText_0x1bd39e::
	text "Saving record…"
	line "Don't turn off!"
	done

SECTION "UnknownText_0x1bd3d7", ROMX
UnknownText_0x1bd3d7::
	text "You have no coins."
	prompt

SECTION "UnknownText_0x1bd3eb", ROMX
UnknownText_0x1bd3eb::
	text "You don't have a"
	line "Coin Case."
	prompt

SECTION "UnknownText_0x1bd407", ROMX
UnknownText_0x1bd407::
	text "OK, connect the"
	line "Game Link Cable."
	prompt

SECTION "UnknownText_0x1bd429", ROMX
UnknownText_0x1bd429::
	text "<PLAYER> traded"
	line ""
	text_from_ram wMonOrItemNameBuffer
	text " for"
	cont ""
	text_from_ram wStringBuffer2
	text "."
	done

SECTION "UnknownText_0x1bd445", ROMX
UnknownText_0x1bd445::
	play_sound SFX_DEX_FANFARE_80_109
	interpret_data
	text_end

SECTION "UnknownText_0x1bd449", ROMX
UnknownText_0x1bd449::
	text "I collect #mon."
	line "Do you have"
	cont ""
	text_from_ram wStringBuffer1
	text "?"

	para "Want to trade it"
	line "for my "
	text_from_ram wStringBuffer2
	text "?"
	done

SECTION "UnknownText_0x1bd48c", ROMX
UnknownText_0x1bd48c::
	text "You don't want to"
	line "trade? Aww…"
	done

SECTION "UnknownText_0x1bd4aa", ROMX
UnknownText_0x1bd4aa::
	text "Huh? That's not"
	line ""
	text_from_ram wStringBuffer1
	text "."
	cont "What a letdown…"
	done

SECTION "UnknownText_0x1bd4d2", ROMX
UnknownText_0x1bd4d2::
	text "Yay! I got myself"
	line ""
	text_from_ram wStringBuffer1
	text "!"
	cont "Thanks!"
	done

SECTION "UnknownText_0x1bd4f4", ROMX
UnknownText_0x1bd4f4::
	text "Hi, how's my old"
	line ""
	text_from_ram wStringBuffer2
	text " doing?"
	done

SECTION "UnknownText_0x1bd512", ROMX
UnknownText_0x1bd512::
	text "Hi, I'm looking"
	line "for this #mon."

	para "If you have"
	line ""
	text_from_ram wStringBuffer1
	text ", would"

	para "you trade it for"
	line "my "
	text_from_ram wStringBuffer2
	text "?"
	done

SECTION "UnknownText_0x1bd565", ROMX
UnknownText_0x1bd565::
	text "You don't have"
	line "one either?"

	para "Gee, that's really"
	line "disappointing…"
	done

SECTION "UnknownText_0x1bd5a1", ROMX
UnknownText_0x1bd5a1::
	text "You don't have"
	line ""
	text_from_ram wStringBuffer1
	text "? That's"
	cont "too bad, then."
	done

SECTION "UnknownText_0x1bd5cc", ROMX
UnknownText_0x1bd5cc::
	text "Great! Thank you!"

	para "I finally got"
	line ""
	text_from_ram wStringBuffer1
	text "."
	done

SECTION "UnknownText_0x1bd5f4", ROMX
UnknownText_0x1bd5f4::
	text "Hi! The "
	text_from_ram wMonOrItemNameBuffer
	text_start
	line "you traded me is"
	cont "doing great!"
	done

SECTION "UnknownText_0x1bd621", ROMX
UnknownText_0x1bd621::
	text_from_ram wMonOrItemNameBuffer
	text "'s cute,"
	line "but I don't have"

	para "it. Do you have"
	line ""
	text_from_ram wStringBuffer1
	text "?"

	para "Want to trade it"
	line "for my "
	text_from_ram wStringBuffer2
	text "?"
	done

SECTION "UnknownText_0x1bd673", ROMX
UnknownText_0x1bd673::
	text "You don't want to"
	line "trade? Oh, darn…"
	done

SECTION "UnknownText_0x1bd696", ROMX
UnknownText_0x1bd696::
	text "That's not"
	line ""
	text_from_ram wStringBuffer1
	text "."

	para "Please trade with"
	line "me if you get one."
	done

SECTION "UnknownText_0x1bd6cd", ROMX
UnknownText_0x1bd6cd::
	text "Wow! Thank you!"
	line "I always wanted"
	cont ""
	text_from_ram wMonOrItemNameBuffer
	text "!"
	done

SECTION "UnknownText_0x1bd6f5", ROMX
UnknownText_0x1bd6f5::
	text "How is that"
	line ""
	text_from_ram wStringBuffer2
	text " I"
	cont "traded you doing?"

	para "Your "
	text_from_ram wMonOrItemNameBuffer
	text "'s"
	line "so cute!"
	done

SECTION "UnknownText_0x1bd731", ROMX
UnknownText_0x1bd731::
	text "Uh? What happened?"
	done

SECTION "UnknownText_0x1bd745", ROMX
UnknownText_0x1bd745::
	text "Trading is so odd…"

	para "I still have a lot"
	line "to learn about it."
	done

SECTION "UnknownText_0x1bd77f", ROMX
UnknownText_0x1bd77f::
	text "Wow, that's a cute"
	line "#mon."

	para "Where did you get"
	line "it?"

	para "…"

	para "So, you're leaving"
	line "on an adventure…"

	para "OK!"
	line "I'll help too."

	para "But what can I do"
	line "for you?"

	para "I know! I'll save"
	line "money for you."

	para "On a long journey,"
	line "money's important."

	para "Do you want me to"
	line "save your money?"
	done

SECTION "UnknownText_0x1bd868", ROMX
UnknownText_0x1bd868::
	text "OK, I'll take care"
	line "of your money."

	para "………………"
	prompt

SECTION "UnknownText_0x1bd88e", ROMX
UnknownText_0x1bd88e::
	text "Be careful."

	para "#mon are your"
	line "friends. You need"
	cont "to work as a team."

	para "Now, go on!"
	done

SECTION "UnknownText_0x1bd8da", ROMX
UnknownText_0x1bd8da::
	text "Hi! Welcome home!"
	line "You're trying very"
	cont "hard, I see."

	para "I've kept your"
	line "room tidy."

	para "Or is this about"
	line "your money?"
	done

SECTION "UnknownText_0x1bd942", ROMX
UnknownText_0x1bd942::
	text "What do you want"
	line "to do?"
	done

SECTION "UnknownText_0x1bd95b", ROMX
UnknownText_0x1bd95b::
	text "How much do you"
	line "want to save?"
	done

SECTION "UnknownText_0x1bd97a", ROMX
UnknownText_0x1bd97a::
	text "How much do you"
	line "want to take?"
	done

SECTION "UnknownText_0x1bd999", ROMX
UnknownText_0x1bd999::
	text "Do you want to"
	line "save some money?"
	done

SECTION "UnknownText_0x1bd9ba", ROMX
UnknownText_0x1bd9ba::
	text "You haven't saved"
	line "that much."
	prompt

SECTION "UnknownText_0x1bd9d7", ROMX
UnknownText_0x1bd9d7::
	text "You can't take"
	line "that much."
	prompt

SECTION "UnknownText_0x1bd9f1", ROMX
UnknownText_0x1bd9f1::
	text "You don't have"
	line "that much."
	prompt

SECTION "UnknownText_0x1bda0b", ROMX
UnknownText_0x1bda0b::
	text "You can't save"
	line "that much."
	prompt

SECTION "UnknownText_0x1bda25", ROMX
UnknownText_0x1bda25::
	text "OK, I'll save your"
	line "money. Trust me!"

	para "<PLAYER>, stick"
	line "with it!"
	done

SECTION "UnknownText_0x1bda5b", ROMX
UnknownText_0x1bda5b::
	text "Your money's safe"
	line "here! Get going!"
	done

SECTION "UnknownText_0x1bda7e", ROMX
UnknownText_0x1bda7e::
	text "<PLAYER>, don't"
	line "give up!"
	done

SECTION "UnknownText_0x1bda90", ROMX
UnknownText_0x1bda90::
	text "Just do what"
	line "you can."
	done

SECTION "UnknownText_0x1bdaa9", ROMX
UnknownText_0x1bdaa9::
	text "I'm the Day-Care"
	line "Man. Want me to"
	cont "raise a #mon?"
	done

SECTION "UnknownText_0x1bdad8", ROMX
UnknownText_0x1bdad8::
	text "I'm the Day-Care"
	line "Man. Do you know"
	cont "about Eggs?"

	para "I was raising"
	line "#mon with my"
	cont "wife, you see."

	para "We were shocked to"
	line "find an Egg!"

	para "How incredible is"
	line "that?"

	para "So, want me to"
	line "raise a #mon?"
	done

SECTION "UnknownText_0x1bdb85", ROMX
UnknownText_0x1bdb85::
	text "I'm the Day-Care"
	line "Lady."

	para "Should I raise a"
	line "#mon for you?"
	done

SECTION "UnknownText_0x1bdbbb", ROMX
UnknownText_0x1bdbbb::
	text "I'm the Day-Care"
	line "Lady. Do you know"
	cont "about Eggs?"

	para "My husband and I"
	line "were raising some"
	cont "#mon, you see."

	para "We were shocked to"
	line "find an Egg!"

	para "How incredible"
	line "could that be?"

	para "Should I raise a"
	line "#mon for you?"
	done

SECTION "UnknownText_0x1bdc79", ROMX
UnknownText_0x1bdc79::
	text "What should I"
	line "raise for you?"
	prompt

SECTION "UnknownText_0x1bdc97", ROMX
UnknownText_0x1bdc97::
	text "Oh? But you have"
	line "just one #mon."
	prompt

SECTION "UnknownText_0x1bdcb8", ROMX
UnknownText_0x1bdcb8::
	text "Sorry, but I can't"
	line "accept an Egg."
	prompt

SECTION "UnknownText_0x1bdcda", ROMX
UnknownText_0x1bdcda::
	text "Remove Mail before"
	line "you come see me."
	prompt

SECTION "UnknownText_0x1bdcff", ROMX
UnknownText_0x1bdcff::
	text "If you give me"
	line "that, what will"
	cont "you battle with?"
	prompt

SECTION "UnknownText_0x1bdd30", ROMX
UnknownText_0x1bdd30::
	text "OK. I'll raise"
	line "your "
	text_from_ram wStringBuffer1
	text "."
	prompt

SECTION "UnknownText_0x1bdd4b", ROMX
UnknownText_0x1bdd4b::
	text "Come back for it"
	line "later."
	done

SECTION "UnknownText_0x1bdd64", ROMX
UnknownText_0x1bdd64::
	text "Are we geniuses or"
	line "what? Want to see"
	cont "your "
	text_from_ram wStringBuffer1
	text "?"
	done

SECTION "UnknownText_0x1bdd96", ROMX
UnknownText_0x1bdd96::
	text "Your "
	text_from_ram wStringBuffer1
	text_start
	line "has grown a lot."

	para "Its level grew"
	line "by "
	deciram wStringBuffer2 + 1, 1, 3
	text "."

	para "If you want your"
	line "#mon back, it"
	cont "will cost ¥"
	deciram wStringBuffer2 + 2, 3, 4
	text "."
	done

SECTION "UnknownText_0x1bde04", ROMX
UnknownText_0x1bde04::
	text "Perfect! Here's"
	line "your #mon."
	prompt

SECTION "UnknownText_0x1bde1f", ROMX
UnknownText_0x1bde1f::
	text "<PLAYER> got back"
	line ""
	text_from_ram wStringBuffer1
	text "."
	prompt

SECTION "UnknownText_0x1bde32", ROMX
UnknownText_0x1bde32::
	text "Huh? Back already?"
	line "Your "
	text_from_ram wStringBuffer1
	text_start
	para "needs a little"
	line "more time with us."

	para "If you want your"
	line "#mon back, it"
	cont "will cost ¥100."
	done

SECTION "UnknownText_0x1bdea2", ROMX
UnknownText_0x1bdea2::
	text "You have no room"
	line "for it."
	prompt

SECTION "UnknownText_0x1bdebc", ROMX
UnknownText_0x1bdebc::
	text "You don't have"
	line "enough money."
	prompt

SECTION "UnknownText_0x1bded9", ROMX
UnknownText_0x1bded9::
	text "Oh, fine then."
	prompt

SECTION "UnknownText_0x1bdee9", ROMX
UnknownText_0x1bdee9::
	text "Come again."
	done

SECTION "UnknownText_0x1bdef6", ROMX
UnknownText_0x1bdef6::
	text "Not yet…"
	done

SECTION "UnknownText_0x1bdf00", ROMX
UnknownText_0x1bdf00::
	text "Ah, it's you!"

	para "We were raising"
	line "your #mon, and"

	para "my goodness, were"
	line "we surprised!"

	para "Your #mon had"
	line "an Egg!"

	para "We don't know how"
	line "it got there, but"

	para "your #mon had"
	line "it. You want it?"
	done

SECTION "UnknownText_0x1bdfa5", ROMX
UnknownText_0x1bdfa5::
	text "<PLAYER> received"
	line "the Egg!"
	done

SECTION "UnknownText_0x1bdfba", ROMX
UnknownText_0x1bdfba::
	text "Take good care of"
	line "it."
	done

SECTION "UnknownText_0x1bdfd1", ROMX
UnknownText_0x1bdfd1::
	text "Well then, I'll"
	line "keep it. Thanks!"
	done

SECTION "UnknownText_0x1bdff2", ROMX
UnknownText_0x1bdff2::
	text "You have no room"
	line "in your party."
	cont "Come back later."
	done

SECTION "UnknownText_0x1c0043", ROMX
UnknownText_0x1c0043::
	text "Hello, hello! I'm"
	line "the Name Rater."

	para "I rate the names"
	line "of #mon."

	para "Would you like me"
	line "to rate names?"
	done

SECTION "UnknownText_0x1c00a0", ROMX
UnknownText_0x1c00a0::
	text "Which #mon's"
	line "nickname should I"
	cont "rate for you?"
	prompt

SECTION "UnknownText_0x1c00cd", ROMX
UnknownText_0x1c00cd::
	text "Hm… "
	text_from_ram wStringBuffer1
	text "…"
	line "That's a fairly"
	cont "decent name."

	para "But, how about a"
	line "slightly better"
	cont "nickname?"

	para "Want me to give it"
	line "a better name?"
	done

SECTION "UnknownText_0x1c0142", ROMX
UnknownText_0x1c0142::
	text "All right. What"
	line "name should we"
	cont "give it, then?"
	prompt

SECTION "UnknownText_0x1c0171", ROMX
UnknownText_0x1c0171::
	text "That's a better"
	line "name than before!"

	para "Well done!"
	done

SECTION "UnknownText_0x1c019e", ROMX
UnknownText_0x1c019e::
	text "OK, then. Come"
	line "again sometime."
	done

SECTION "UnknownText_0x1c01be", ROMX
UnknownText_0x1c01be::
	text "Hm… "
	text_from_ram wStringBuffer1
	text "?"
	line "What a great name!"
	cont "It's perfect."

	para "Treat "
	text_from_ram wStringBuffer1
	text_start
	line "with loving care."
	done

SECTION "UnknownText_0x1c0208", ROMX
UnknownText_0x1c0208::
	text "Whoa… That's just"
	line "an Egg."
	done

SECTION "UnknownText_0x1c0222", ROMX
UnknownText_0x1c0222::
	text "It might look the"
	line "same as before,"

	para "but this new name"
	line "is much better!"

	para "Well done!"
	done

SECTION "UnknownText_0x1c0272", ROMX
UnknownText_0x1c0272::
	text "All right. This"
	line "#mon is now"
	cont "named "
	text_from_ram wStringBuffer1
	text "."
	prompt

SECTION "Text_Gained", ROMX
Text_Gained::
	text_from_ram wStringBuffer1
	text " gained@"
	text_end

SECTION "Text_ABoostedStringBuffer2ExpPoints", ROMX
Text_ABoostedStringBuffer2ExpPoints::
	text_start
	line "a boosted"
	cont ""
	deciram wStringBuffer2, 3, 6
	text " Exp. Points!"
	prompt

SECTION "Text_StringBuffer2ExpPoints", ROMX
Text_StringBuffer2ExpPoints::
	text_start
	line ""
	deciram wStringBuffer2, 3, 6
	text " Exp. Points!"
	prompt

SECTION "Text_GoPkmn", ROMX
Text_GoPkmn::
	text "Go! @"
	text_end

SECTION "Text_DoItPkmn", ROMX
Text_DoItPkmn::
	text "Do it! @"
	text_end

SECTION "Text_GoForItPkmn", ROMX
Text_GoForItPkmn::
	text "Go for it,"
	line "@"
	text_end

SECTION "Text_YourFoesWeakGetmPkmn", ROMX
Text_YourFoesWeakGetmPkmn::
	text "Your foe's weak!"
	line "Get'm, @"
	text_end

SECTION "Text_BattleMonNick01", ROMX
Text_BattleMonNick01::
	text_from_ram wBattleMonNick
	text "!"
	done

SECTION "Text_BattleMonNickComma", ROMX
Text_BattleMonNickComma::
	text_from_ram wBattleMonNick
	text ",@"
	text_end

SECTION "Text_ThatsEnoughComeBack", ROMX
Text_ThatsEnoughComeBack::
	text " that's"
	line "enough! Come back!@"
	text_end

SECTION "Text_OKComeBack", ROMX
Text_OKComeBack::
	text " OK!"
	line "Come back!@"
	text_end

SECTION "Text_GoodComeBack", ROMX
Text_GoodComeBack::
	text " good!"
	line "Come back!@"
	text_end

SECTION "Text_ComeBack", ROMX
Text_ComeBack::
	text " come"
	line "back!"
	done

SECTION "UnknownText_0x1c0373", ROMX
UnknownText_0x1c0373::
	text "Booted up a TM."
	done

SECTION "UnknownText_0x1c0384", ROMX
UnknownText_0x1c0384::
	text "Booted up an HM."
	done

SECTION "UnknownText_0x1c0396", ROMX
UnknownText_0x1c0396::
	text "It contained"
	line ""
	text_from_ram wStringBuffer2
	text "."

	para "Teach "
	text_from_ram wStringBuffer2
	text_start
	line "to a #mon?"
	done

SECTION "UnknownText_0x1c03c2", ROMX
UnknownText_0x1c03c2::
	text_from_ram wStringBuffer2
	text " is"
	line "not compatible"
	cont "with "
	text_from_ram wStringBuffer1
	text "."

	para "It can't learn"
	line ""
	text_from_ram wStringBuffer2
	text "."
	prompt

SECTION "_BadgeRequiredText", ROMX
_BadgeRequiredText::
	text "Sorry! A new Badge"
	line "is required."
	prompt

SECTION "UnknownText_0x1c05c8", ROMX
UnknownText_0x1c05c8::
	text "Can't use that"
	line "here."
	prompt

SECTION "UnknownText_0x1c05dd", ROMX
UnknownText_0x1c05dd::
	text_from_ram wStringBuffer2
	text " used"
	line "Cut!"
	prompt

SECTION "UnknownText_0x1c05ec", ROMX
UnknownText_0x1c05ec::
	text "There's nothing to"
	line "Cut here."
	prompt

SECTION "UnknownText_0x1c0609", ROMX
UnknownText_0x1c0609::
	text "A blinding Flash"
	line "lights the area!"
	text_waitbutton
	text_end

SECTION "_UsedSurfText", ROMX
_UsedSurfText::
	text_from_ram wStringBuffer2
	text " used"
	line "Surf!"
	done

SECTION "_CantSurfText", ROMX
_CantSurfText::
	text "You can't Surf"
	line "here."
	prompt

SECTION "_AlreadySurfingText", ROMX
_AlreadySurfingText::
	text "You're already"
	line "Surfing."
	prompt

SECTION "_AskSurfText", ROMX
_AskSurfText::
	text "The water is calm."
	line "Want to Surf?"
	done

SECTION "UnknownText_0x1c068e", ROMX
UnknownText_0x1c068e::
	text_from_ram wStringBuffer2
	text " used"
	line "Waterfall!"
	done

SECTION "UnknownText_0x1c06a3", ROMX
UnknownText_0x1c06a3::
	text "Wow, it's a huge"
	line "waterfall."
	done

SECTION "UnknownText_0x1c06bf", ROMX
UnknownText_0x1c06bf::
	text "Do you want to use"
	line "Waterfall?"
	done

SECTION "UnknownText_0x1c06de", ROMX
UnknownText_0x1c06de::
	text_from_ram wStringBuffer2
	text " used"
	line "Dig!"
	done

SECTION "UnknownText_0x1c06ed", ROMX
UnknownText_0x1c06ed::
	text "<PLAYER> used an"
	line "Escape Rope."
	done

SECTION "UnknownText_0x1c0705", ROMX
UnknownText_0x1c0705::
	text "Can't use that"
	line "here."
	done

SECTION "UnknownText_0x1c073b", ROMX
UnknownText_0x1c073b::
	text "Can't use that"
	line "here."

	para ""
	done

SECTION "UnknownText_0x1c0774", ROMX
UnknownText_0x1c0774::
	text_from_ram wStringBuffer2
	text " used"
	line "Strength!"
	done

SECTION "UnknownText_0x1c0788", ROMX
UnknownText_0x1c0788::
	text_from_ram wStringBuffer1
	text " can"
	line "move boulders."
	prompt

SECTION "UnknownText_0x1c07a0", ROMX
UnknownText_0x1c07a0::
	text "A #mon may be"
	line "able to move this."

	para "Want to use"
	line "Strength?"
	done

SECTION "UnknownText_0x1c07d8", ROMX
UnknownText_0x1c07d8::
	text "Boulders may now"
	line "be moved!"
	done

SECTION "UnknownText_0x1c07f4", ROMX
UnknownText_0x1c07f4::
	text "A #mon may be"
	line "able to move this."
	done

SECTION "UnknownText_0x1c0816", ROMX
UnknownText_0x1c0816::
	text_from_ram wStringBuffer2
	text " used"
	line "Whirlpool!"
	prompt

SECTION "UnknownText_0x1c082b", ROMX
UnknownText_0x1c082b::
	text "It's a vicious"
	line "whirlpool!"

	para "A #mon may be"
	line "able to pass it."
	done

SECTION "UnknownText_0x1c0864", ROMX
UnknownText_0x1c0864::
	text "A whirlpool is in"
	line "the way."

	para "Want to use"
	line "Whirlpool?"
	done

SECTION "UnknownText_0x1c0897", ROMX
UnknownText_0x1c0897::
	text_from_ram wStringBuffer2
	text " did a"
	line "Headbutt!"
	prompt

SECTION "UnknownText_0x1c08ac", ROMX
UnknownText_0x1c08ac::
	text "Nope. Nothing…"
	done

SECTION "UnknownText_0x1c08bc", ROMX
UnknownText_0x1c08bc::
	text "A #mon could be"
	line "in this tree."

	para "Want to Headbutt"
	line "it?"
	done

SECTION "UnknownText_0x1c08f0", ROMX
UnknownText_0x1c08f0::
	text_from_ram wStringBuffer2
	text " used"
if DEF(FAITHFUL)
	line "Rock Smash!"
else
	line "Brick Break!"
endc
	prompt

SECTION "UnknownText_0x1c0906", ROMX
UnknownText_0x1c0906::
	text "Maybe a #mon"
	line "can break this."
	done

SECTION "UnknownText_0x1c0924", ROMX
UnknownText_0x1c0924::
	text "This rock looks"
	line "breakable."

if DEF(FAITHFUL)
	para "Want to use Rock"
	line "Smash?"
else
	para "Want to use Brick"
	line "Break?"
endc
	done

SECTION "UnknownText_0x1c0958", ROMX
UnknownText_0x1c0958::
	text "Oh!"
	line "A bite!"
	prompt

SECTION "UnknownText_0x1c0965", ROMX
UnknownText_0x1c0965::
	text "Not even a nibble!"
	prompt

SECTION "UnknownText_0x1c099a", ROMX
UnknownText_0x1c099a::
	text "You can't get off"
	line "here!"
	done

SECTION "UnknownText_0x1c09b2", ROMX
UnknownText_0x1c09b2::
	text "<PLAYER> got on the"
	line ""
	text_from_ram wStringBuffer2
	text "."
	done

SECTION "UnknownText_0x1c09c7", ROMX
UnknownText_0x1c09c7::
	text "<PLAYER> got off"
	line "the "
	text_from_ram wStringBuffer2
	text "."
	done

SECTION "UnknownText_0x1c09dd", ROMX
UnknownText_0x1c09dd::
	text "This tree can be"
	line "Cut!"

	para "Want to use Cut?"
	done

SECTION "UnknownText_0x1c0a05", ROMX
UnknownText_0x1c0a05::
	text "This tree can be"
	line "Cut!"
	done

SECTION "UnknownText_0x1c0a1c", ROMX
UnknownText_0x1c0a1c::
	text "<PLAYER> found"
	line ""
	text_from_ram wStringBuffer3
	text "!"
	done

SECTION "WhiteoutText", ROMX
WhiteoutText::
	text "<PLAYER> is out of"
	line "useable #mon!"

	para "<PLAYER> blacked"
	line "out!"
	done

SECTION "WhiteoutToWildText", ROMX
WhiteoutToWildText::
	text "<PLAYER> is out of"
	line "useable #mon!"

	para "<PLAYER> panicked"
	line "and dropped"
	cont "¥"
	deciram hMoneyTemp, 3, 7
	text "…"

	para "………………"
	line "………………"

	para "<PLAYER> blacked"
	line "out!"
	done

SECTION "WhiteoutToTrainerText", ROMX
WhiteoutToTrainerText::
	text "<PLAYER> is out of"
	line "useable #mon!"

	para "<PLAYER> paid"
	line "¥"
	deciram hMoneyTemp, 3, 7
	text " to the"
	cont "winner…"

	para "………………"
	line "………………"

	para "<PLAYER> blacked"
	line "out!"
	done

SECTION "ForfeitToTrainerText", ROMX
ForfeitToTrainerText::
	text "<PLAYER> forfeit-"
	line "ed the battle…"

	para "<PLAYER> paid"
	line "¥"
	deciram hMoneyTemp, 3, 7
	text " to the"
	cont "winner…"

	para "………………"
	line "………………"

	para "<PLAYER> blacked"
	line "out!"
	done

SECTION "UnknownText_0x1c0acc", ROMX
UnknownText_0x1c0acc::
	text_from_ram wStringBuffer3
	text_start
	line "recovered from"
	cont "its poisoning!"
	prompt

SECTION "UnknownText_0x1c0b3b", ROMX
UnknownText_0x1c0b3b::
	text "<PLAYER> sprinkled"
	line "water."

	para "But nothing"
	line "happened…"
	done

SECTION "UnknownText_0x1c0b65", ROMX
UnknownText_0x1c0b65::
	text "<PLAYER>'s #mon"
	line "were all healed!"
	done

SECTION "Text_AnEGGCantHoldAnItem", ROMX
Text_AnEGGCantHoldAnItem::
	text "An Egg can't hold"
	line "an item."
	prompt

SECTION "UnknownText_0x1c0ba5", ROMX
UnknownText_0x1c0ba5::
	text "Throw away how"
	line "many?"
	done

SECTION "UnknownText_0x1c0bbb", ROMX
UnknownText_0x1c0bbb::
	text "Throw away "
	deciram wItemQuantityChangeBuffer, 1, 2
	text_start
	line ""
	text_from_ram wStringBuffer2
	text "(s)?"
	done

SECTION "UnknownText_0x1c0bd8", ROMX
UnknownText_0x1c0bd8::
	text "Threw away"
	line ""
	text_from_ram wStringBuffer2
	text "(s)."
	prompt

SECTION "UnknownText_0x1c0bee", ROMX
UnknownText_0x1c0bee::
	text "Oak: <PLAYER>!"
	line "This isn't the"
	cont "time to use that!"
	prompt

SECTION "Text_YouDontHaveAPkmn", ROMX
Text_YouDontHaveAPkmn::
	text "You don't have a"
	line "#mon!"
	prompt

SECTION "UnknownText_0x1c0c2e", ROMX
UnknownText_0x1c0c2e::
	text "Registered the"
	line ""
	text_from_ram wStringBuffer2
	text "."
	prompt

SECTION "UnregisteredItemText", ROMX
UnregisteredItemText::
	text "Unregistered the"
	line ""
	text_from_ram wStringBuffer2
	text "."
	prompt

SECTION "UnknownText_0x1c0c45", ROMX
UnknownText_0x1c0c45::
	text "You can't register"
	line "that item."
	prompt

SECTION "UnknownText_0x1c0c63", ROMX
UnknownText_0x1c0c63::
	text "Where should this"
	line "be moved to?"
	done

SECTION "UnknownText_0x1c0c83", ROMX
UnknownText_0x1c0c83::
	text_start
	done

SECTION "Text_AreYouABoyOrAreYouAGirl", ROMX
Text_AreYouABoyOrAreYouAGirl::
	text "Are you a boy?"
	line "Or are you a girl?"
	done

SECTION "Text_SoYoureABoy", ROMX
Text_SoYoureABoy::
	text "So you're a boy?"
	done

SECTION "Text_SoYoureAGirl", ROMX
Text_SoYoureAGirl::
	text "So you're a girl?"
	done

SECTION "UnknownText_0x1c0d0e", ROMX
UnknownText_0x1c0d0e::
	text "<USER>@"
	text_end

SECTION "UnknownText_0x1c0d26", ROMX
UnknownText_0x1c0d26::
	text_start
	line "took in sunlight!"
	prompt

SECTION "UnknownText_0x1c0d5c", ROMX
UnknownText_0x1c0d5c::
	text_start
	line "flew up high!"
	prompt

SECTION "UnknownText_0x1c0d6c", ROMX
UnknownText_0x1c0d6c::
	text_start
	line "dug a hole!"
	prompt

SECTION "UnknownText_0x1c0db0", ROMX
UnknownText_0x1c0db0::
	text "Huh?"
	para "@"
	text_end

SECTION "UnknownText_0x1c0db8", ROMX
UnknownText_0x1c0db8::
	text_start
	done

SECTION "UnknownText_0x1c0dba", ROMX
UnknownText_0x1c0dba::
	text_from_ram wStringBuffer1
	text " came"
	line "out of its Egg!"
	play_sound SFX_CAUGHT_MON
	text_waitbutton
	text_end

SECTION "UnknownText_0x1c0dd8", ROMX
UnknownText_0x1c0dd8::
	text "Give a nickname to"
	line ""
	text_from_ram wStringBuffer1
	text "?"
	done

SECTION "UnknownText_0x1c0df3", ROMX
UnknownText_0x1c0df3::
	text "It's "
	text_from_ram wBreedMon2Nick
	text_start
	line "that was left with"
	cont "the Day-Care Lady."
	done

SECTION "UnknownText_0x1c0e24", ROMX
UnknownText_0x1c0e24::
	text "It's "
	text_from_ram wBreedMon1
	text_start
	line "that was left with"
	cont "the Day-Care Man."
	done

SECTION "UnknownText_0x1c0e6f", ROMX
UnknownText_0x1c0e6f::
	text "It has no interest"
	line "in "
	text_from_ram wStringBuffer1
	text "."
	prompt

SECTION "UnknownText_0x1c0e8d", ROMX
UnknownText_0x1c0e8d::
	text "It appears to care"
	line "for "
	text_from_ram wStringBuffer1
	text "."
	prompt

SECTION "UnknownText_0x1c0eac", ROMX
UnknownText_0x1c0eac::
	text "It's friendly with"
	line ""
	text_from_ram wStringBuffer1
	text "."
	prompt

SECTION "UnknownText_0x1c0ec6", ROMX
UnknownText_0x1c0ec6::
	text "It shows interest"
	line "in "
	text_from_ram wStringBuffer1
	text "."
	prompt

SECTION "_EmptyMailboxText", ROMX
_EmptyMailboxText::
	text "There's no Mail"
	line "here."
	prompt

SECTION "ClearedMailPutAwayText", ROMX
ClearedMailPutAwayText::
	text "The cleared Mail"
	line "was put away."
	prompt

SECTION "MailPackFullText", ROMX
MailPackFullText::
	text "The Bag is full."
	prompt

SECTION "MailMessageLostText", ROMX
MailMessageLostText::
	text "The Mail's message"
	line "will be lost. OK?"
	done

SECTION "MailAlreadyHoldingItemText", ROMX
MailAlreadyHoldingItemText::
	text "It's already hold-"
	line "ing an item."
	prompt

SECTION "MailEggText", ROMX
MailEggText::
	text "An Egg can't hold"
	line "any Mail."
	prompt

SECTION "MailMovedFromBoxText", ROMX
MailMovedFromBoxText::
	text "The Mail was moved"
	line "from the Mailbox."
	prompt

SECTION "Text_WasSentToBillsPC", ROMX
Text_WasSentToBillsPC::
	text_from_ram wStringBuffer1
	text " was"
	line "sent to Bill's PC."
	prompt

SECTION "UnknownText_0x1c1006", ROMX
UnknownText_0x1c1006::
	text "You gotta have"
	line "#mon to call!"
	prompt

SECTION "UnknownText_0x1c1024", ROMX
UnknownText_0x1c1024::
	text "What?"
	done

SECTION "UnknownText_0x1c102b", ROMX
UnknownText_0x1c102b::
	text "There is a #mon"
	line "holding Mail."

	para "Please remove the"
	line "Mail."
	prompt

SECTION "UnknownText_0x1c10c0", ROMX
UnknownText_0x1c10c0::
	text "Caught "
	text_from_ram wStringBuffer1
	text "!"
	prompt

SECTION "UnknownText_0x1c10cf", ROMX
UnknownText_0x1c10cf::
	text "Switch #mon?"
	done

SECTION "UnknownText_0x1c10dd", ROMX
UnknownText_0x1c10dd::
	text "You already caught"
	line "a "
	text_from_ram wStringBuffer1
	text "."
	prompt

SECTION "ContestJudging_FirstPlaceText", ROMX
ContestJudging_FirstPlaceText::
	text "This Bug-Catching"
	line "Contest winner is"
	interpret_data
	text "…"

	para ""
	text_from_ram wBugContestWinnerName
	text ","
	line "who caught a"
	cont ""
	text_from_ram wStringBuffer1
	text "!@"
	text_end

SECTION "ContestJudging_FirstPlaceScoreText", ROMX
ContestJudging_FirstPlaceScoreText::
	text_start

	para "The winning score"
	line "was "
	deciram wBugContestFirstPlaceScore, 2, 3
	text " points!"
	prompt

SECTION "ContestJudging_SecondPlaceText", ROMX
ContestJudging_SecondPlaceText::
	text "Placing second was"
	line ""
	text_from_ram wBugContestWinnerName
	text ","
	para "who caught a"
	line ""
	text_from_ram wStringBuffer1
	text "!@"
	text_end

SECTION "ContestJudging_SecondPlaceScoreText", ROMX
ContestJudging_SecondPlaceScoreText::
	text_start
	para "The score was"
	line ""
	deciram wBugContestSecondPlaceScore, 2, 3
	text " points!"
	prompt

SECTION "ContestJudging_ThirdPlaceText", ROMX
ContestJudging_ThirdPlaceText::
	text "Placing third was"
	line ""
	text_from_ram wBugContestWinnerName
	text ","
	para "who caught a"
	line ""
	text_from_ram wStringBuffer1
	text "!@"
	text_end

SECTION "ContestJudging_ThirdPlaceScoreText", ROMX
ContestJudging_ThirdPlaceScoreText::
	text_start
	para "The score was"
	line ""
	deciram wBugContestThirdPlaceScore, 2, 3
	text " points!"
	prompt

SECTION "UnknownText_0x1c1203", ROMX
UnknownText_0x1c1203::
	text "Let me measure"
	line "that Magikarp."

	para "…Hm, it measures"
	line ""
	text_from_ram wStringBuffer1
	text "."
	prompt

SECTION "UnknownText_0x1c123a", ROMX
UnknownText_0x1c123a::
	text "Current Record"
	para ""
	text_from_ram wStringBuffer1
	text " caught by"
	line ""
	text_from_ram wMagikarpRecordHoldersName
	text_waitbutton
	text_end

SECTION "UnknownText_0x1c1261", ROMX
UnknownText_0x1c1261::
	text "Congratulations!"

	para "We have a match"
	line "with the ID number"

	para "of "
	text_from_ram wStringBuffer1
	text " in"
	line "your party."
	prompt

SECTION "UnknownText_0x1c12ae", ROMX
UnknownText_0x1c12ae::
	text "Congratulations!"

	para "We have a match"
	line "with the ID number"

	para "of "
	text_from_ram wStringBuffer1
	text " in"
	line "your PC Box."
	prompt

SECTION "UnknownText_0x1c12fc", ROMX
UnknownText_0x1c12fc::
	text "Give a nickname to"
	line "the "
	text_from_ram wStringBuffer1
	text " you"
	cont "received?"
	done

SECTION "UnknownText_0x1c1328", ROMX
UnknownText_0x1c1328::
	text "Bzzzzt! You must"
	line "have a #mon to"
	cont "use this!"
	prompt

SECTION "UnknownText_0x1c1353", ROMX
UnknownText_0x1c1353::
	text "<PLAYER> turned on"
	line "the PC."
	prompt

SECTION "UnknownText_0x1c1368", ROMX
UnknownText_0x1c1368::
	text "What do you want"
	line "to do?"
	done

SECTION "_KrissPCHowManyWithdrawText", ROMX
_KrissPCHowManyWithdrawText::
	text "How many do you"
	line "want to withdraw?"
	done

SECTION "_KrissPCWithdrewItemsText", ROMX
_KrissPCWithdrewItemsText::
	text "Withdrew "
	deciram wItemQuantityChangeBuffer, 1, 2
	text_start
	line ""
	text_from_ram wStringBuffer2
	text "(s)."
	prompt

SECTION "_KrissPCNoRoomWithdrawText", ROMX
_KrissPCNoRoomWithdrawText::
	text "There's no room"
	line "for more items."
	prompt

SECTION "UnknownText_0x1c13df", ROMX
UnknownText_0x1c13df::
	text "No items here!"
	prompt

SECTION "_KrissPCCantDepositItemText", ROMX
_KrissPCCantDepositItemText::
	text "That item can't"
	line "be deposited."
	prompt

SECTION "_KrissPCHowManyDepositText", ROMX
_KrissPCHowManyDepositText::
	text "How many do you"
	line "want to deposit?"
	done

SECTION "_KrissPCDepositItemsText", ROMX
_KrissPCDepositItemsText::
	text "Deposited "
	deciram wItemQuantityChangeBuffer, 1, 2
	text_start
	line ""
	text_from_ram wStringBuffer2
	text "(s)."
	prompt

SECTION "_KrissPCNoRoomDepositText", ROMX
_KrissPCNoRoomDepositText::
	text "There's no room to"
	line "store items."
	prompt

SECTION "UnknownText_0x1c144d", ROMX
UnknownText_0x1c144d::
	text "<PLAYER> turned on"
	line "the PC."
	prompt

SECTION "UnknownText_0x1c1462", ROMX
UnknownText_0x1c1462::
	text "Access whose PC?"
	done

SECTION "UnknownText_0x1c1474", ROMX
UnknownText_0x1c1474::
	text "Bill's PC"
	line "accessed."

	para "#mon Storage"
	line "System opened."
	prompt

SECTION "UnknownText_0x1c14a4", ROMX
UnknownText_0x1c14a4::
	text "Accessed own PC."

	para "Item Storage"
	line "System opened."
	prompt

SECTION "UnknownText_0x1c14d2", ROMX
UnknownText_0x1c14d2::
	text "Prof.Oak's PC"
	line "accessed."

	para "#dex Rating"
	line "System opened."
	prompt

SECTION "UnknownText_0x1c1505", ROMX
UnknownText_0x1c1505::
	text "…"
	line "Link closed…"
	done

SECTION "_OakPCText1", ROMX
_OakPCText1::
	text "Want to get your"
	line "#dex rated?"
	done

SECTION "_OakPCText2", ROMX
_OakPCText2::
	text "Current #dex"
	line "completion level:"
	prompt

SECTION "_OakPCText3", ROMX
_OakPCText3::
	text_from_ram wStringBuffer3
	text " #mon seen"
	line ""
	text_from_ram wStringBuffer4
	text " #mon owned"

	para "Prof.Oak's"
	line "Rating:"
	done

SECTION "_OakRating01", ROMX
_OakRating01::
	text "Look for #mon"
	line "in grassy areas!"
	done

SECTION "_OakRating02", ROMX
_OakRating02::
	text "Good. I see you"
	line "understand how to"
	cont "use # Balls."
	done

SECTION "_OakRating03", ROMX
_OakRating03::
	text "You're getting"
	line "good at this."

	para "But you have a"
	line "long way to go."
	done

SECTION "_OakRating04", ROMX
_OakRating04::
	text "You need to fill"
	line "up the #dex."

	para "Catch different"
	line "kinds of #mon!"
	done

SECTION "_OakRating05", ROMX
_OakRating05::
	text "You're trying--I"
	line "can see that."

	para "Your #dex is"
	line "coming together."
	done

SECTION "_OakRating06", ROMX
_OakRating06::
	text "To evolve, some"
	line "#mon grow,"

	para "others use the"
	line "effects of Stones."
	done

SECTION "_OakRating07", ROMX
_OakRating07::
	text "Have you gotten a"
	line "fishing Rod? You"

	para "can catch #mon"
	line "by fishing."
	done

SECTION "_OakRating08", ROMX
_OakRating08::
	text "Excellent! You"
	line "seem to like col-"
	cont "lecting things!"
	done

SECTION "_OakRating09", ROMX
_OakRating09::
	text "Some #mon only"
	line "appear during"

	para "certain times of"
	line "the day."
	done

SECTION "_OakRating10", ROMX
_OakRating10::
	text "Your #dex is"
	line "filling up. Keep"
	cont "up the good work!"
	done

SECTION "_OakRating11", ROMX
_OakRating11::
	text "I'm impressed."
	line "You're evolving"

	para "#mon, not just"
	line "catching them."
	done

SECTION "_OakRating12", ROMX
_OakRating12::
	text "Have you met Kurt?"
	line "His custom Balls"
	cont "should help."
	done

SECTION "_OakRating13", ROMX
_OakRating13::
	text "Wow. You've found"
	line "more #mon than"

	para "the last #dex"
	line "research project."
	done

SECTION "_OakRating14", ROMX
_OakRating14::
	text "Are you trading"
	line "your #mon?"

	para "It's tough to do"
	line "this alone!"
	done

SECTION "_OakRating15", ROMX
_OakRating15::
	text "Wow! You've hit"
	line "200! Your #dex"
	cont "is looking great!"
	done

SECTION "_OakRating16", ROMX
_OakRating16::
	text "You've found so"
	line "many #mon!"

	para "You've really"
	line "helped my studies!"
	done

SECTION "_OakRating17", ROMX
_OakRating17::
	text "Magnificent! You"
	line "could become a"

	para "#mon professor"
	line "right now!"
	done

SECTION "_OakRating18", ROMX
_OakRating18::
	text "Your #dex is"
	line "amazing! You're"

	para "ready to turn"
	line "professional!"
	done

SECTION "_OakRating19", ROMX
_OakRating19::
	text "Whoa! A perfect"
	line "#dex! I've"

	para "dreamt about this!"
	line "Congratulations!"
	done

SECTION "_OakPCText4", ROMX
_OakPCText4::
	text "The link to Prof."
	line "Oak's PC closed."
	done

SECTION "UnknownText_0x1c1a5b", ROMX
UnknownText_0x1c1a5b::
	text " , yeah!"
	done

SECTION "UnknownText_0x1c1a65", ROMX
UnknownText_0x1c1a65::
	text "Darn…"
	done

SECTION "UnknownText_0x1c1a6c", ROMX
UnknownText_0x1c1a6c::
	text "Would you like to"
	line "end the Contest?"
	done

SECTION "UnknownText_0x1c1a90", ROMX
UnknownText_0x1c1a90::
	text "Toss out how many"
	line ""
	text_from_ram wStringBuffer2
	text "(s)?"
	done

SECTION "UnknownText_0x1c1aad", ROMX
UnknownText_0x1c1aad::
	text "Throw away "
	deciram wItemQuantityChangeBuffer, 1, 2
	text_start
	line ""
	text_from_ram wStringBuffer2
	text "(s)?"
	done

SECTION "UnknownText_0x1c1aca", ROMX
UnknownText_0x1c1aca::
	text "Discarded"
	line ""
	text_from_ram wStringBuffer1
	text "(s)."
	prompt

SECTION "UnknownText_0x1c1b03", ROMX
UnknownText_0x1c1b03::
	text "Oak: <PLAYER>!"
	line "This isn't the"
	cont "time to use that!"
	done

SECTION "UnknownText_0x1c1b2c", ROMX
UnknownText_0x1c1b2c::
	text "Took "
	text_from_ram wMonOrItemNameBuffer
	text "'s"
	line ""
	text_from_ram wStringBuffer1
	text " and"

	para "made it hold"
	line ""
	text_from_ram wStringBuffer2
	text "."
	prompt

SECTION "UnknownText_0x1c1b57", ROMX
UnknownText_0x1c1b57::
	text "Made "
	text_from_ram wMonOrItemNameBuffer
	text_start
	line "hold "
	text_from_ram wStringBuffer2
	text "."
	prompt

SECTION "UnknownText_0x1c1b6f", ROMX
UnknownText_0x1c1b6f::
	text "Please remove the"
	line "Mail first."
	prompt

SECTION "UnknownText_0x1c1b8e", ROMX
UnknownText_0x1c1b8e::
	text_from_ram wMonOrItemNameBuffer
	text " isn't"
	line "holding anything."
	prompt

SECTION "UnknownText_0x1c1baa", ROMX
UnknownText_0x1c1baa::
	text "Item storage space"
	line "full."
	prompt

SECTION "UnknownText_0x1c1bc4", ROMX
UnknownText_0x1c1bc4::
	text "Took "
	text_from_ram wStringBuffer1
	text_start
	line "from "
	text_from_ram wMonOrItemNameBuffer
	text "."
	prompt

SECTION "UnknownText_0x1c1bdc", ROMX
UnknownText_0x1c1bdc::
	text_from_ram wMonOrItemNameBuffer
	text " is"
	line "already holding"

	para ""
	text_from_ram wStringBuffer1
	text "."
	line "Switch items?"
	done

SECTION "UnknownText_0x1c1c09", ROMX
UnknownText_0x1c1c09::
	text "That item can't be"
	line "held."
	prompt

SECTION "UnknownText_0x1c1c22", ROMX
UnknownText_0x1c1c22::
	text "The Mail will lose"
	line "its message. OK?"
	done

SECTION "UnknownText_0x1c1c47", ROMX
UnknownText_0x1c1c47::
	text "Mail detached from"
	line ""
	text_from_ram wStringBuffer1
	text "."
	prompt

SECTION "UnknownText_0x1c1c62", ROMX
UnknownText_0x1c1c62::
	text "There's no space"
	line "for removing Mail."
	prompt

SECTION "UnknownText_0x1c1c86", ROMX
UnknownText_0x1c1c86::
	text "Send the removed"
	line "Mail to your PC?"
	done

SECTION "UnknownText_0x1c1ca9", ROMX
UnknownText_0x1c1ca9::
	text "Your PC's Mailbox"
	line "is full."
	prompt

SECTION "UnknownText_0x1c1cc4", ROMX
UnknownText_0x1c1cc4::
	text "The Mail was sent"
	line "to your PC."
	prompt

SECTION "UnknownText_0x1c1ce3", ROMX
UnknownText_0x1c1ce3::
	text "Not enough HP!"
	prompt

SECTION "UnknownText_0x1c1cf3", ROMX
UnknownText_0x1c1cf3::
	text "An item in your"
	line "Bag may be"

	para "registered for use"
	line "on Select Button."
	done

SECTION "_InitialOptionsText", ROMX
_InitialOptionsText::
	text "Please choose how"
	line "you want to play"
	cont "Polished Crystal."
	prompt

SECTION "_ElmText1", ROMX
_ElmText1::
	text "Hello! Sorry to"
	line "keep you waiting!"

if !DEF(DEBUG)
	para "Welcome to the"
	line "world of #mon!"

	para "My name is Elm."

	para "People call me the"
	line "#mon Prof."
endc
	prompt

SECTION "_ElmText2", ROMX
_ElmText2::
	text "This world is in-"
	line "habited by crea-"
	cont "tures that we call"
	cont "#mon."
	done

SECTION "_ElmText4", ROMX
_ElmText4::
	text "People and #mon"
	line "live together by"

	para "supporting each"
	line "other."

	para "Some people play"
	line "with #mon, some"
	cont "battle with them."
	prompt

SECTION "_ElmText5", ROMX
_ElmText5::
	text "But we don't know"
	line "everything about"
	cont "#mon yet."

	para "There are still"
	line "many mysteries to"
	cont "solve."

	para "That's why I study"
	line "#mon every day."
	prompt

SECTION "_ElmText6", ROMX
_ElmText6::
	text "Please tell me"
	line "your name."
	prompt

SECTION "_ElmText7", ROMX
_ElmText7::
	text "<PLAYER>, are you"
	line "ready?"

if !DEF(DEBUG)
	para "Your very own"
	line "#mon story is"
	cont "about to unfold."

	para "You'll face fun"
	line "times and tough"
	cont "challenges."

	para "A world of dreams"
	line "and adventures"

	para "with #mon"
	line "awaits! Let's go!"
endc

	para "I'll be seeing you"
	line "later!"
	done

SECTION "UnknownText_0x1c40e6", ROMX
UnknownText_0x1c40e6::
	text "The clock's time"
	line "may be wrong."

	para "Please reset the"
	line "time."
	prompt

SECTION "UnknownText_0x1c411c", ROMX
UnknownText_0x1c411c::
	text "Set with the"
	line "Control Pad."

	para "Confirm: A Button"
	line "Cancel:  B Button"
	done

SECTION "UnknownText_0x1c415b", ROMX
UnknownText_0x1c415b::
	text "Is this OK?"
	done

SECTION "UnknownText_0x1c4168", ROMX
UnknownText_0x1c4168::
	text "The clock has been"
	line "reset."
	done

SECTION "UnknownText_0x1c4183", ROMX
UnknownText_0x1c4183::
	text "Too much time has"
	line "elapsed. Please"
	cont "try again."
	prompt

SECTION "UnknownText_0x1c41b1", ROMX
UnknownText_0x1c41b1::
	text "If you trade that"
	line "#mon, you won't"
	cont "be able to battle."
	prompt

SECTION "UnknownText_0x1c41e6", ROMX
UnknownText_0x1c41e6::
	text "Your friend's"
	line ""
	text_from_ram wStringBuffer1
	text " appears"
	cont "to be abnormal!"
	prompt

SECTION "UnknownText_0x1c4212", ROMX
UnknownText_0x1c4212::
	text "Trade "
	text_from_ram wd004
	text_start
	line "for "
	text_from_ram wStringBuffer1
	text "?"
	done

SECTION "UnknownText_0x1c454b", ROMX
UnknownText_0x1c454b::
	text "Would you like to"
	line "save the game?"
	done

SECTION "UnknownText_0x1c456d", ROMX
UnknownText_0x1c456d::
	text "Saving… Don't turn"
	line "off the power!"
	done

SECTION "UnknownText_0x1c4590", ROMX
UnknownText_0x1c4590::
	text "<PLAYER> saved"
	line "the game."
	done

SECTION "UnknownText_0x1c45d9", ROMX
UnknownText_0x1c45d9::
	text "Warning! There is"
	line "a save file from"
	cont "another game."

	para "Is it OK to over-"
	line "write the other"
	cont "save file?"
	done

SECTION "UnknownText_0x1c460d", ROMX
UnknownText_0x1c460d::
	text "The save file is"
	line "corrupted!"
	prompt

SECTION "UnknownText_0x1c462a", ROMX
UnknownText_0x1c462a::
	text "When you change a"
	line "#mon Box, data"
	cont "will be saved. OK?"
	done

SECTION "UnknownText_0x1c465f", ROMX
UnknownText_0x1c465f::
	text "Each time you move"
	line "a #mon, data"
	cont "will be saved. OK?"
	done

SECTION "UnknownText_0x1c46b7", ROMX
UnknownText_0x1c46b7::
	text "No windows avail-"
	line "able for popping."
	done

SECTION "_ObjectEventText", ROMX
_ObjectEventText::
	text "Object event"
	done

SECTION "UnknownText_0x1c4719", ROMX
UnknownText_0x1c4719::
	text "<PLAYER> received"
	line ""
	text_from_ram wStringBuffer4
	text "."
	done

SECTION "UnknownText_0x1c472c", ROMX
UnknownText_0x1c472c::
	text "<PLAYER> put the"
	line ""
	text_from_ram wStringBuffer1
	text " in"
	cont "the "
	text_from_ram wStringBuffer3
	text "."
	prompt

SECTION "UnknownText_0x1c474b", ROMX
UnknownText_0x1c474b::
	text "The "
	text_from_ram wStringBuffer3
	text_start
	line "is full…"
	prompt

SECTION "UnknownText_0x1c4b92", ROMX
UnknownText_0x1c4b92::
	text "Congratulations!"
	line "Your "
	text_from_ram wStringBuffer2
	text_end

SECTION "UnknownText_0x1c4baf", ROMX
UnknownText_0x1c4baf::
	text_start
	para "evolved into"
	line ""
	text_from_ram wStringBuffer1
	text "!"
	done

SECTION "UnknownText_0x1c4bc5", ROMX
UnknownText_0x1c4bc5::
	text "Huh? "
	text_from_ram wStringBuffer2
	text_start
	line "stopped evolving!"
	prompt

SECTION "UnknownText_0x1c4be3", ROMX
UnknownText_0x1c4be3::
	text "What? "
	text_from_ram wStringBuffer2
	text_start
	line "is evolving!"
	done

SECTION "UnknownText_0x1c4bfd", ROMX
UnknownText_0x1c4bfd::
	text "How many?"
	done

SECTION "UnknownText_0x1c4c08", ROMX
UnknownText_0x1c4c08::
	deciram wItemQuantityChangeBuffer, 1, 2
	text " "
	text_from_ram wStringBuffer2
	text "(s)"
	line "will be ¥"
	deciram hMoneyTemp, 3, 7
	text "."
	done

SECTION "UnknownText_0x1c4c28", ROMX
UnknownText_0x1c4c28::
	text "Hello, dear."

	para "I sell inexpensive"
	line "herbal medicine."

	para "They're good, but"
	line "a trifle bitter."

	para "Your #mon may"
	line "not like them."

	para "Hehehehe…"
	done

SECTION "UnknownText_0x1c4ca3", ROMX
UnknownText_0x1c4ca3::
	text "How many?"
	done

SECTION "UnknownText_0x1c4cae", ROMX
UnknownText_0x1c4cae::
	deciram wItemQuantityChangeBuffer, 1, 2
	text " "
	text_from_ram wStringBuffer2
	text "(s)"
	line "will be ¥"
	deciram hMoneyTemp, 3, 7
	text "."
	done

SECTION "UnknownText_0x1c4cce", ROMX
UnknownText_0x1c4cce::
	text "Thank you, dear."
	line "Hehehehe…"
	done

SECTION "UnknownText_0x1c4cea", ROMX
UnknownText_0x1c4cea::
	text "Oh? Your Bag is"
	line "full, dear."
	done

SECTION "UnknownText_0x1c4d08", ROMX
UnknownText_0x1c4d08::
	text "Hehehe… You don't"
	line "have the money."
	done

SECTION "UnknownText_0x1c4d2a", ROMX
UnknownText_0x1c4d2a::
	text "Come again, dear."
	line "Hehehehe…"
	done

SECTION "UnknownText_0x1c4d47", ROMX
UnknownText_0x1c4d47::
	text "Hiya! Care to see"
	line "some bargains?"

	para "I sell rare items"
	line "that nobody else"

	para "carries--but only"
	line "one of each item."
	done

SECTION "UnknownText_0x1c4db0", ROMX
UnknownText_0x1c4db0::
	text_from_ram wStringBuffer2
	text " costs"
	line "¥"
	deciram hMoneyTemp, 3, 7
	text ". Want it?"
	done

SECTION "UnknownText_0x1c4dcd", ROMX
UnknownText_0x1c4dcd::
	text "Thanks."
	done

SECTION "UnknownText_0x1c4dd6", ROMX
UnknownText_0x1c4dd6::
	text "Uh-oh, your Bag"
	line "is chock-full."
	done

SECTION "UnknownText_0x1c4df7", ROMX
UnknownText_0x1c4df7::
	text "You bought that"
	line "already. I'm all"
	cont "sold out of it."
	done

SECTION "UnknownText_0x1c4e28", ROMX
UnknownText_0x1c4e28::
	text "Uh-oh, you're"
	line "short on funds."
	done

SECTION "UnknownText_0x1c4e46", ROMX
UnknownText_0x1c4e46::
	text "Come by again"
	line "sometime."
	done

SECTION "UnknownText_0x1c4e5f", ROMX
UnknownText_0x1c4e5f::
	text "What's up? Need"
	line "some medicine?"
	done

SECTION "UnknownText_0x1c4e7e", ROMX
UnknownText_0x1c4e7e::
	text "How many?"
	done

SECTION "UnknownText_0x1c4e89", ROMX
UnknownText_0x1c4e89::
	deciram wItemQuantityChangeBuffer, 1, 2
	text " "
	text_from_ram wStringBuffer2
	text "(s)"
	line "will cost ¥"
	deciram hMoneyTemp, 3, 7
	text "."
	done

SECTION "UnknownText_0x1c4eab", ROMX
UnknownText_0x1c4eab::
	text "Thanks much!"
	done

SECTION "UnknownText_0x1c4eb9", ROMX
UnknownText_0x1c4eb9::
	text "You don't have any"
	line "more space."
	done

SECTION "UnknownText_0x1c4ed8", ROMX
UnknownText_0x1c4ed8::
	text "Huh? That's not"
	line "enough money."
	done

SECTION "UnknownText_0x1c4ef6", ROMX
UnknownText_0x1c4ef6::
	text "All right."
	line "See you around."
	done

SECTION "UnknownText_0x1c4f33", ROMX
UnknownText_0x1c4f33::
	text "How many?"
	done

SECTION "UnknownText_0x1c4f3e", ROMX
UnknownText_0x1c4f3e::
	text "I can pay you"
	line "¥"
	deciram hMoneyTemp, 3, 7
	text "."

	para "Is that OK?"
	done

SECTION "UnknownText_0x1c4f62", ROMX
UnknownText_0x1c4f62::
	text "Welcome! How may I"
	line "help you?"
	done

SECTION "UnknownText_0x1c4f80", ROMX
UnknownText_0x1c4f80::
	text "Here you are."
	line "Thank you!"
	done

SECTION "UnknownText_0x1c4f9a", ROMX
UnknownText_0x1c4f9a::
	text "You don't have"
	line "enough money."
	done

SECTION "UnknownText_0x1c4fb7", ROMX
UnknownText_0x1c4fb7::
	text "You can't carry"
	line "any more items."
	done

SECTION "UnknownText_0x1c4fd7", ROMX
UnknownText_0x1c4fd7::
	text "Sorry, I can't buy"
	line "that from you."
	prompt

SECTION "UnknownText_0x1c4ff9", ROMX
UnknownText_0x1c4ff9::
	text "Please come again!"
	done

SECTION "UnknownText_0x1c500d", ROMX
UnknownText_0x1c500d::
	text "Can I do anything"
	line "else for you?"
	done

SECTION "UnknownText_0x1c502e", ROMX
UnknownText_0x1c502e::
	text "Got ¥"
	deciram hMoneyTemp, 3, 7
	text " for"
	line ""
	text_from_ram wStringBuffer2
	text "(s)."
	done

SECTION "UnknownText_0x1c5049", ROMX
UnknownText_0x1c5049::
	text "Bet how many"
	line "coins?"
	done

SECTION "TMMartCostsThisMuchText", ROMX
TMMartCostsThisMuchText::
	text ""
	text_from_ram wStringBuffer2
	text " "
	text_from_ram wStringBuffer1
	text_start
	line "will be ¥"
	deciram hMoneyTemp, 3, 7
	text "."
	done

SECTION "BTMartHowMayIHelpYouText", ROMX
BTMartHowMayIHelpYouText::
	text "Welcome to the"
	line "Exchange Service"
	cont "Corner!"

	para "You can trade your"
	line "BP for prizes."
	done

SECTION "BTMartCostsThisMuchText", ROMX
BTMartCostsThisMuchText::
	deciram wItemQuantityChangeBuffer, 1, 2
	text " "
	text_from_ram wStringBuffer1
	text "(s)"
	line "will cost "
	deciram hMoneyTemp, 3, 3
	text " BP."
	done

SECTION "BTMartInsufficientFundsText", ROMX
BTMartInsufficientFundsText::
	text "I'm sorry, but you"
	line "don't have enough"
	cont "BP."
	done

SECTION "BTMartBagFullText", ROMX
BTMartBagFullText::
	text "I'm sorry, but your"
	line "Bag is full."
	done

SECTION "BTMartComeAgainText", ROMX
BTMartComeAgainText::
	text "Please come back"
	line "any time you want!"
	done

SECTION "UnknownText_0x1c505e", ROMX
UnknownText_0x1c505e::
	text "Start!"
	done

SECTION "UnknownText_0x1c5066", ROMX
UnknownText_0x1c5066::
	text "Not enough"
	line "coins."
	prompt

SECTION "UnknownText_0x1c5079", ROMX
UnknownText_0x1c5079::
	text "Darn… Ran out of"
	line "coins…"
	done

SECTION "UnknownText_0x1c5092", ROMX
UnknownText_0x1c5092::
	text "Play again?"
	done

SECTION "UnknownText_0x1c509f", ROMX
UnknownText_0x1c509f::
	text "lined up!"
	line "Won "
	text_from_ram wStringBuffer2
	text " coins!"
	done

SECTION "UnknownText_0x1c50bb", ROMX
UnknownText_0x1c50bb::
	text "Darn!"
	done

SECTION "UnknownText_0x1c5565", ROMX
UnknownText_0x1c5565::
	text "Huh? Sorry, wrong"
	line "number!"
	done

SECTION "UnknownText_0x1c5580", ROMX
UnknownText_0x1c5580::
	text "Click!"
	done

SECTION "UnknownText_0x1c5588", ROMX
UnknownText_0x1c5588::
	text "……"
	done

SECTION "UnknownText_0x1c558b", ROMX
UnknownText_0x1c558b::
	text "That number is out"
	line "of the area."
	done

SECTION "UnknownText_0x1c55ac", ROMX
UnknownText_0x1c55ac::
	text "Just go talk to"
	line "that person!"
	done

SECTION "UnknownText_0x1c55db", ROMX
UnknownText_0x1c55db::
	text "Select Continue to"
	line "set the time."
	prompt

SECTION "UnknownText_0x1c561c", ROMX
UnknownText_0x1c561c::
	text "Reset the clock?"
	done

SECTION "UnknownText_0x1c564a", ROMX
UnknownText_0x1c564a::
	text "Clear all save"
	line "data?"
	done

SECTION "ResetInitialOptionsText", ROMX
ResetInitialOptionsText::
	text "Reset the initial"
	line "game options?"
	done

SECTION "UnknownText_0x1c5660", ROMX
UnknownText_0x1c5660::
	text_from_ram wMonOrItemNameBuffer
	text " learned"
	line ""
	text_from_ram wStringBuffer2
	text "!"
	play_sound SFX_DEX_FANFARE_50_79
	text_waitbutton
	text_end

SECTION "UnknownText_0x1c5678", ROMX
UnknownText_0x1c5678::
	text "Which move should"
	next "be forgotten?"
	prompt

SECTION "UnknownText_0x1c5699", ROMX
UnknownText_0x1c5699::
	text "Stop learning"
	line ""
	text_from_ram wStringBuffer2
	text "?"
	done

SECTION "UnknownText_0x1c56af", ROMX
UnknownText_0x1c56af::
	text_from_ram wMonOrItemNameBuffer
	text_start
	line "did not learn"
	cont ""
	text_from_ram wStringBuffer2
	text "."
	prompt

SECTION "UnknownText_0x1c56c9", ROMX
UnknownText_0x1c56c9::
	text_from_ram wMonOrItemNameBuffer
	text_start
	line "wants to learn"
	cont ""
	text_from_ram wStringBuffer2
	text "!"

	para "Should it forget"
	line "an old move for"
	cont ""
	text_from_ram wStringBuffer2
	text "?"
	done

SECTION "UnknownText_0x1c5740", ROMX
UnknownText_0x1c5740::
	text "1, 2 and…"
	interpret_data
	text_end

SECTION "UnknownText_0x1c574e", ROMX
UnknownText_0x1c574e::
	text " Poof!"
	interpret_data
	text_start
	para ""
	text_from_ram wMonOrItemNameBuffer
	text " forgot"
	line ""
	text_from_ram wStringBuffer1
	text "."

	para "And…"
	prompt

SECTION "UnknownText_0x1c5772", ROMX
UnknownText_0x1c5772::
	text "HM moves can't be"
	line "forgotten now."
	prompt

SECTION "UnknownText_0x1c5793", ROMX
UnknownText_0x1c5793::
	text "Play with three"
	line "coins?"
	done

SECTION "UnknownText_0x1c57ab", ROMX
UnknownText_0x1c57ab::
	text "Not enough coins…"
	prompt

SECTION "UnknownText_0x1c57be", ROMX
UnknownText_0x1c57be::
	text "Choose a card."
	done

SECTION "UnknownText_0x1c57ce", ROMX
UnknownText_0x1c57ce::
	text "Place your bet."
	done

SECTION "UnknownText_0x1c57df", ROMX
UnknownText_0x1c57df::
	text "Want to play"
	line "again?"
	done

SECTION "UnknownText_0x1c57f4", ROMX
UnknownText_0x1c57f4::
	text "The cards have"
	line "been shuffled."
	prompt

SECTION "UnknownText_0x1c5813", ROMX
UnknownText_0x1c5813::
	text "Yeah!"
	done

SECTION "UnknownText_0x1c581a", ROMX
UnknownText_0x1c581a::
	text "Darn…"
	done

SECTION "UnknownText_0x1c5821", ROMX
UnknownText_0x1c5821::
	current_day
	text_end

SECTION "UnknownText_0x1c5824", ROMX
UnknownText_0x1c5824::
	text "……"
	done

SECTION "UnknownText_0x1c5827", ROMX
UnknownText_0x1c5827::
	text "You're out of the"
	line "service area."
	prompt

SECTION "UnknownText_0x1c5847", ROMX
UnknownText_0x1c5847::
	text "Whom do you want"
	line "to call?"
	done

SECTION "UnknownText_0x1c5862", ROMX
UnknownText_0x1c5862::
	text "Press any button"
	line "to exit."
	done

SECTION "UnknownText_0x1c587d", ROMX
UnknownText_0x1c587d::
	text "Delete this stored"
	line "phone number?"
	done

SECTION "UnknownText_0x1c589f", ROMX
UnknownText_0x1c589f::
	text "You can cash in"
	line "your saved points"

	para "for a lovely prize"
	line "of your choice!"

	para "Which prize would"
	line "you like?"
	done

SECTION "UnknownText_0x1c58bc", ROMX
UnknownText_0x1c58bc::
	text_from_ram wStringBuffer1
	text "?"
	line "Is that right?"
	done

SECTION "UnknownText_0x1c58d1", ROMX
UnknownText_0x1c58d1::
	text "Here you go!"
	done

SECTION "UnknownText_0x1c58e0", ROMX
UnknownText_0x1c58e0::
	text "You don't have"
	line "enough points."
	done

SECTION "UnknownText_0x1c58ff", ROMX
UnknownText_0x1c58ff::
	text "You have no room"
	line "for it."
	done

SECTION "UnknownText_0x1c591a", ROMX
UnknownText_0x1c591a::
	text "Oh. Please come"
	line "back again!"
	done

SECTION "Text_ExcuseMeYoureNotReady", ROMX
Text_ExcuseMeYoureNotReady::
	text "Excuse me."
	line "You're not ready."
	para ""
	done

SECTION "UnknownText_0x1c5962", ROMX
UnknownText_0x1c5962::
	text "Please return when"
	line "you're ready."
	done

SECTION "Text_OnlyThreePkmnMayBeEntered", ROMX
Text_OnlyThreePkmnMayBeEntered::
	text "Three #mon"
	line "must be entered."
	para ""
	done

SECTION "Text_ThePkmnMustAllBeDifferentKinds", ROMX
Text_ThePkmnMustAllBeDifferentKinds::
	text "The three #mon"
	line "must all be"
	cont "different kinds."
	para ""
	done

SECTION "Text_ThePkmnMustNotHoldTheSameItems", ROMX
Text_ThePkmnMustNotHoldTheSameItems::
	text "The three #mon"
	line "must not hold the"
	cont "same items."
	para ""
	done

SECTION "Text_YouCantTakeAnEgg", ROMX
Text_YouCantTakeAnEgg::
	text "You can't take an"
	line "Egg!"
	para ""
	done

SECTION "Text_UberRestriction", ROMX
Text_UberRestriction::
	text_from_ram wStringBuffer1
	text " must be"
	line "<LV>70 or higher."
	para ""
	done

SECTION "UnknownText_0x1c5aa6", ROMX
UnknownText_0x1c5aa6::
	text "Oh no! The #mon"
	line "broke free!"
	prompt

SECTION "UnknownText_0x1c5ac3", ROMX
UnknownText_0x1c5ac3::
	text "Aww! It appeared"
	line "to be caught!"
	prompt

SECTION "UnknownText_0x1c5ae3", ROMX
UnknownText_0x1c5ae3::
	text "Aargh!"
	line "Almost had it!"
	prompt

SECTION "UnknownText_0x1c5afa", ROMX
UnknownText_0x1c5afa::
	text "Shoot! It was so"
	line "close too!"
	prompt

SECTION "UnknownText_0x1c5b17", ROMX
UnknownText_0x1c5b17::
	text "Gotcha! "
	text_from_ram wEnemyMonNick
	text_start
	line "was caught!"
	play_sound SFX_CAUGHT_MON
	text_end

SECTION "Text_Waitbutton_2", ROMX
Text_Waitbutton_2::
	text_waitbutton
	text_end

SECTION "UnknownText_0x1c5b38", ROMX
UnknownText_0x1c5b38::
	text_from_ram wMonOrItemNameBuffer
	text " was"
	line "sent to Bill's PC."
	prompt

SECTION "UnknownText_0x1c5b53", ROMX
UnknownText_0x1c5b53::
	text_from_ram wEnemyMonNick
	text "'s data"
	line "was newly added to"
	cont "the #dex."
	play_sound SFX_SLOT_MACHINE_START
	text_waitbutton
	text_end

SECTION "UnknownText_0x1c5b7f", ROMX
UnknownText_0x1c5b7f::
	text "Give a nickname to"
	line ""
	text_from_ram wStringBuffer1
	text "?"
	done

SECTION "_ItemHappinessRoseButStatFellText", ROMX
_ItemHappinessRoseButStatFellText::
	text_from_ram wStringBuffer1
	text " became"
	line "friendly. Base"
	cont ""
	text_from_ram wStringBuffer2
	text " fell!"
	prompt

SECTION "_ItemStatRoseText", ROMX
_ItemStatRoseText::
	text_from_ram wStringBuffer1
	text "'s"
	line ""
	text_from_ram wStringBuffer2
	text " rose."
	prompt

SECTION "UnknownText_0x1c5bac", ROMX
UnknownText_0x1c5bac::
	text "That can't be used"
	line "on this #mon."
	prompt

SECTION "Text_RepelUsedEarlierIsStillInEffect", ROMX
Text_RepelUsedEarlierIsStillInEffect::
	text "The Repel used"
	line "earlier is still"
	cont "in effect."
	prompt

SECTION "UnknownText_0x1c5c5e", ROMX
UnknownText_0x1c5c5e::
	text "You now have"
	line ""
	deciram wBlueCardBalance, 1, 2
	text " points."
	done

SECTION "UnknownText_0x1c5c7b", ROMX
UnknownText_0x1c5c7b::
	text "Coins:"
	line ""
	deciram wCoins, 2, 5
	text_end

SECTION "Text_RaiseThePPOfWhichMove", ROMX
Text_RaiseThePPOfWhichMove::
	text "Raise the PP of"
	line "which move?"
	done

SECTION "Text_RestoreThePPOfWhichMove", ROMX
Text_RestoreThePPOfWhichMove::
	text "Restore the PP of"
	line "which move?"
	done

SECTION "Text_PPIsMaxedOut", ROMX
Text_PPIsMaxedOut::
	text_from_ram wStringBuffer2
	text "'s PP"
	line "is maxed out."
	prompt

SECTION "Text_PPsIncreased", ROMX
Text_PPsIncreased::
	text_from_ram wStringBuffer2
	text "'s PP"
	line "increased."
	prompt

SECTION "Text_PPsMaximized", ROMX
Text_PPsMaximized::
	text_from_ram wStringBuffer2
	text "'s PP"
	line "maximized."
	prompt

SECTION "UnknownText_0x1c5cf1", ROMX
UnknownText_0x1c5cf1::
	text "PP was restored."
	prompt

SECTION "UnknownText_0x1c5d3e", ROMX
UnknownText_0x1c5d3e::
	text "It looks bitter…"
	prompt

SECTION "UnknownText_0x1c5d50", ROMX
UnknownText_0x1c5d50::
	text "That can't be used"
	line "on an Egg."
	prompt

SECTION "UnknownText_0x1c5d6e", ROMX
UnknownText_0x1c5d6e::
	text "Oak: <PLAYER>!"
	line "This isn't the"
	cont "time to use that!"
	prompt

SECTION "UnknownText_0x1c5db6", ROMX
UnknownText_0x1c5db6::
	text "It won't have any"
	line "effect."
	prompt

SECTION "UnknownText_0x1c5dd0", ROMX
UnknownText_0x1c5dd0::
	text "The trainer"
	line "blocked the Ball!"
	prompt

SECTION "UnknownText_0x1c5def", ROMX
UnknownText_0x1c5def::
	text "Don't be a thief!"
	prompt

SECTION "UnknownText_0x1c5e3a", ROMX
UnknownText_0x1c5e3a::
	text "The #mon Box"
	line "is full. That"
	cont "can't be used now."
	prompt

SECTION "Text_MonIsHiddenFromBall", ROMX
Text_MonIsHiddenFromBall::
	text "The #mon can't"
	line "be seen!"
	prompt

SECTION "Text_MonCantBeCaught", ROMX
Text_MonCantBeCaught::
	text "The #mon can't"
	line "be caught!"
	prompt

SECTION "Text_NuzlockeBallFailure", ROMX
Text_NuzlockeBallFailure::
	text "You already"
	line "encountered a"
	cont "#mon here."
	prompt

SECTION "Text_NuzlockeReviveFailure", ROMX
Text_NuzlockeReviveFailure::
	text "You can't revive"
	line "#mon in"
	cont "Nuzlocke mode!"
	prompt

SECTION "UnknownText_0x1c5e68", ROMX
UnknownText_0x1c5e68::
	text "<PLAYER> used the"
	line ""
	text_from_ram wStringBuffer2
	text "."
	done

SECTION "UnknownText_0x1c5ea8", ROMX
UnknownText_0x1c5ea8::
	text_from_ram wStringBuffer1
	text " knows"
	line ""
	text_from_ram wStringBuffer2
	text "."
	prompt

SECTION "UnknownText_0x1c5eba", ROMX
UnknownText_0x1c5eba::
	text "That #mon knows"
	line "only one move."
	done

SECTION "UnknownText_0x1c5eda", ROMX
UnknownText_0x1c5eda::
	text "Oh, make it forget"
	line ""
	text_from_ram wStringBuffer1
	text "?"
	done

SECTION "UnknownText_0x1c5ef5", ROMX
UnknownText_0x1c5ef5::
	text "Done! Your #mon"
	line "forgot the move."
	done

SECTION "UnknownText_0x1c5f17", ROMX
UnknownText_0x1c5f17::
	text "An Egg doesn't"
	line "know any moves!"
	done

SECTION "UnknownText_0x1c5f36", ROMX
UnknownText_0x1c5f36::
	text "No? Come visit me"
	line "again."
	done

SECTION "UnknownText_0x1c5f50", ROMX
UnknownText_0x1c5f50::
	text "Which move should"
	line "it forget, then?"
	prompt

SECTION "UnknownText_0x1c5f74", ROMX
UnknownText_0x1c5f74::
	text "Um… Oh, yes, I'm"
	line "the Move Deleter."

	para "I can make #mon"
	line "forget moves."

	para "Shall I make a"
	line "#mon forget?"
	done

SECTION "UnknownText_0x1c5fd1", ROMX
UnknownText_0x1c5fd1::
	text "Which #mon?"
	prompt

SECTION "Text_DSTIsThatOK", ROMX
Text_DSTIsThatOK::
	text " DST,"
	line "is that OK?"
	done

SECTION "UnknownText_0x1c5ff1", ROMX
UnknownText_0x1c5ff1::
	text ","
	line "is that OK?"
	done

SECTION "UnknownText_0x1c6000", ROMX
UnknownText_0x1c6000::
	text "Do you want to"
	line "switch to Daylight"
	cont "Saving Time?"
	done

SECTION "UnknownText_0x1c6030", ROMX
UnknownText_0x1c6030::
	text "I set the clock"
	line "forward by one"
	cont "hour."
	prompt

SECTION "UnknownText_0x1c6056", ROMX
UnknownText_0x1c6056::
	text "Is Daylight Saving"
	line "Time over?"
	done

SECTION "UnknownText_0x1c6075", ROMX
UnknownText_0x1c6075::
	text "I put the clock"
	line "back one hour."
	prompt

SECTION "UnknownText_0x1c6095", ROMX
UnknownText_0x1c6095::
	text "Do you want to"
	line "adjust your clock"

	para "for Daylight"
	line "Saving Time?"
	done

SECTION "UnknownText_0x1c60d1", ROMX
UnknownText_0x1c60d1::
	text "I lost the in-"
	line "struction booklet"
	cont "for the #gear."

	para "Come back again in"
	line "a while."
	prompt

SECTION "WonderTradeQuestionText", ROMX
WonderTradeQuestionText::
	text "Would you like to"
	line "trade?"
	done

SECTION "WonderTradePromptText", ROMX
WonderTradePromptText::
	text "Which #mon do"
	line "you want to trade?"
	prompt

;SECTION "WonderTradeCantTradeEggText", ROMX
;WonderTradeCantTradeEggText::
;	text "Sorry. We can't"
;	line "accept an Egg."
;	prompt

;SECTION "UnknownText_0x613c8", ROMX
;UnknownText_0x613c8::
;	text "Sorry, but your"
;	line "#mon appears to"
;
;	para "be abnormal. We"
;	line "can't accept it."
;	prompt

SECTION "WonderTradeConfirmText", ROMX
WonderTradeConfirmText::
	text "Offer to trade"
	line ""
	text_from_ram wStringBuffer1
	text "?"
	done

SECTION "WonderTradeSetupText", ROMX
WonderTradeSetupText::
	text "Searching for a"
	line "trade partner…"
	prompt

SECTION "WonderTradeReadyText", ROMX
WonderTradeReadyText::
	text "A trade partner"
	line "has been found."
	prompt

SECTION "SilphMartIntroText", ROMX
SilphMartIntroText::
	text "Employees like me"
	line "have access to"
	cont "company swag!"

	para "Want to buy some?"
	done

SECTION "SilphMartComeAgainText", ROMX
SilphMartComeAgainText::
	text "Come again! I"
	line "could use the"
	cont "side income."
	done

SECTION "AdventurerMartIntroText", ROMX
AdventurerMartIntroText::
	text "I picked up some"
	line "rare items abroad!"
	done

SECTION "AdventurerMartComeAgainText", ROMX
AdventurerMartComeAgainText::
	text "Come by again!"
	done

SECTION "InformalMartIntroText", ROMX
InformalMartIntroText::
	text "What's up? Need"
	line "some supplies?"
	done

SECTION "BazaarMartIntroText", ROMX
BazaarMartIntroText::
	text "Come take a look"
	line "at my wares!"
	done

SECTION "AlreadyHaveTMText", ROMX
AlreadyHaveTMText::
	text "You already have"
	line "that TM."
	done

SECTION "MartPremierBallText", ROMX
MartPremierBallText::
	text "You also get a"
	line "Premier Ball as"
	cont "an added bonus."
	done

SECTION "ItemCantBeSelectedText", ROMX
ItemCantBeSelectedText::
	text "That item can't be"
	line "selected."
	prompt

SECTION "AlreadyInThatBallTextData", ROMX
AlreadyInThatBallTextData::
	text "Your #mon is in"
	line "that Ball already."
	prompt
