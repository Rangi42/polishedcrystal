BattleText::

BattleText_PlayerPickedUpPayDayMoney: ; 0x80730
	text "<PLAYER> picked up"
	line "¥@"
	deciram wPayDayMoney, 3, 6
	text "!"
	prompt
; 0x80746

WildPokemonAppearedText: ; 0x80746
	text "A wild @"
LegendaryAppearedText: ; 0x80793
	text_from_ram EnemyMonNick
	text ""
	line "appeared!"
	prompt
; 0x8075c

HookedPokemonAttackedText: ; 0x8075c
	text "The hooked"
	line "@"
	text_from_ram EnemyMonNick
	text ""
	cont "attacked!"
	prompt
; 0x80778

PokemonFellFromTreeText: ; 0x80778
	text_from_ram EnemyMonNick
	text " fell"
	line "out of the tree!"
	prompt
; 0x80793

WantsToBattleText:: ; 0x807a9
	text "<ENEMY>"
	line "wants to battle!"
	prompt
; 0x807bd

WantToBattleText::
	text "<ENEMY>"
	line "want to battle!"
	prompt

BattleText_WildFled: ; 0x807bd
	text "Wild @"
BattleText_LegendaryFled:
	text_from_ram EnemyMonNick
	text ""
	line "fled!"
	prompt
; 0x807cf

BattleText_EnemyFled: ; 0x807cf
	text "The foe @"
	text_from_ram EnemyMonNick
	text ""
	line "fled!"
	prompt
; 0x807e2

HurtByPoisonText: ; 0x807e2
	text "<USER> is"
	line "hurt by poison!"
	prompt
; 0x807f8

HurtByBurnText: ; 0x807f8
	text "<USER> is"
	line "hurt by its burn!"
	prompt
; 0x8080e

LeechSeedSapsText: ; 0x8080e
	text "Leech Seed saps"
	line "<USER>!"
	prompt
; 0x80822

HurtByCurseText: ; 0x80836
	text "<USER> is"
	line "hurt by the curse!"
	prompt
; 0x8084d

SandstormHitsText: ; 0x8084d
	text "<USER> is"
	line "buffeted by"
	cont "the sandstorm!"
	prompt
; 0x80864

HailHitsText:
	text "<USER> is"
	line "buffeted by"
	cont "the hail!"
	prompt

PerishCountText: ; 0x80864
	text "<USER> is"
	line "Perish count is @"
	deciram wd265, 1, 1
	text "!"
	prompt
; 0x80880

BattleText_UserLostSomeOfItsHP:
	text "<USER>"
	line "lost some of its"
	cont "HP!"
	prompt

BattleText_UserRecoveredWithItem:
	text "<USER>"
	line "recovered with"
	cont "@"
	text_from_ram StringBuffer1
	text "."
	prompt

BattleText_UserHurtByItem:
	text "<USER>"
	line "was hurt by"
	cont "@"
	text_from_ram StringBuffer1
	text "."
	prompt

BattleText_UserItemLetItMoveFirst::
	text "<USER>'s"
	line "@"
	text_from_ram StringBuffer1
	text " let it"
	cont "move first."
	prompt

BattleText_UserRecoveredPPUsing:
	text "<USER>"
	line "recovered PP using"
	cont "@"
	text_from_ram StringBuffer1
	text "."
	prompt

BattleText_ItemRaised:
	text "The @"
	text_from_ram StringBuffer1
	text ""
	line "raised"
	cont "<USER>'s"
	cont "@"
	text_from_ram StringBuffer2
	text "!"
	prompt

BattleText_ItemSharplyRaised:
	text "The @"
	text_from_ram StringBuffer1
	text ""
	line "sharply raised"
	cont "<USER>'s"
	cont "@"
	text_from_ram StringBuffer2
	text "!"
	prompt

BattleText_UserChargedWithItem:
	text "<USER>"
	line "became charged"
	cont "using @"
	text_from_ram StringBuffer1
	text "!"
	prompt

BattleText_TargetWasHitByFutureSight: ; 0x808b6
	text "<TARGET>"
	line "was hit by Future"
	cont "Sight!"
	prompt
; 0x808d2

BattleText_SafeguardFaded: ; 0x808d2
	text "<USER>'s"
	line "Safeguard faded!"
	prompt
; 0x808e7

BattleText_PkmnLightScreenFell: ; 0x808e7
	text_from_ram StringBuffer1
	text " #mon's"
	line "Light Screen fell!"
	prompt
; 0x80905

BattleText_PkmnReflectFaded: ; 0x80905
	text_from_ram StringBuffer1
	text " #mon's"
	line "Reflect faded!"
	prompt
; 0x8091f

BattleText_RainContinuesToFall: ; 0x8091f
	text "Rain continues to"
	line "fall."
	prompt
; 0x80938

BattleText_TheSunlightIsStrong: ; 0x80938
	text "The sunlight is"
	line "strong."
	prompt
; 0x80951

BattleText_TheSandstormRages: ; 0x80951
	text "The sandstorm"
	line "rages."
	prompt
; 0x80967

BattleText_TheHailContinuesToFall:
	text "The hail continues"
	line "to fall."
	prompt

BattleText_TheRainStopped: ; 0x80967
	text "The rain stopped."
	prompt
; 0x8097a

BattleText_TheSunlightFaded: ; 0x8097a
	text "The sunlight"
	line "faded."
	prompt
; 0x8098f

BattleText_TheSandstormSubsided: ; 0x8098f
	text "The sandstorm"
	line "subsided."
	prompt
; 0x809a8

BattleText_TheHailStopped:
	text "The hail stopped."
	prompt

BattleText_EnemyPkmnFainted: ; 0x809a8
	text "The foe @"
	text_from_ram EnemyMonNick
	text ""
	line "fainted!"
	prompt
; 0x809be

GotMoneyForWinningText:
	text "<PLAYER> got ¥@"
	deciram wBattleReward, 3, 6
	text ""
	line "for winning!"
	prompt

BattleText_EnemyWasDefeated: ; 0x809da
	text "<ENEMY>"
	line "was defeated!"
	prompt
; 0x809eb

BattleText_EnemyWereDefeated:
	text "<ENEMY>"
	line "were defeated!"
	prompt

TiedAgainstText: ; 0x809eb
	text "Tied against"
	line "<ENEMY>!"
	prompt
; 0x809fc

SentSomeToMomText:
	text "<PLAYER> got ¥@"
	deciram wBattleReward, 3, 6
	text ""
	line "for winning!"
	cont "Sent some to Mom!"
	prompt

SentHalfToMomText:
	text "Sent half to Mom!"
	prompt

SentAllToMomText:
	text "Sent all to Mom!"
	prompt

BattleText_PkmnFainted: ; 0x80a75
	text_from_ram BattleMonNick
	text ""
	line "fainted!"
	prompt
; 0x80a83

BattleText_UseNextMon: ; 0x80a83
	text "Use next #mon?"
	done
; 0x80a93

LostAgainstText: ; 0x80ab9
	text "Lost against"
	line "<ENEMY>!"
	prompt
; 0x80aca

BattleText_EnemyIsAboutToUseWillPlayerSwitchPkmn: ; 0x80aca
	text "<ENEMY>"
	line "is about to use"
	cont "@"
	text_from_ram EnemyMonNick
	text "."

	para "Will you switch"
	line "your #mon?"
	done
; 0x80af8

BattleText_EnemyAreAboutToUseWillPlayerSwitchPkmn:
	text "<ENEMY>"
	line "are about to use"
	cont "@"
	text_from_ram EnemyMonNick
	text "."

	para "Will you switch"
	line "your #mon?"
	done

BattleText_EnemyIsAboutToSwitchWillPlayerSwitchPkmn:
	text "<ENEMY>"
	line "is about to switch"
	cont "#mon."

	para "Will you switch"
	line "your #mon?"
	done
; 0x80af8

BattleText_EnemyAreAboutToSwitchWillPlayerSwitchPkmn:
	text "<ENEMY>"
	line "are about to"
	cont "switch #mon."

	para "Will you switch"
	line "your #mon?"
	done

BattleText_EnemySentOut: ; 0x80af8
	text "<ENEMY>"
	line "sent out"
	cont "@"
	text_from_ram EnemyMonNick
	text "!"
	done
; 0x80b0b

BattleText_TheresNoWillToBattle: ; 0x80b0b
	text "There's no will to"
	line "battle!"
	prompt
; 0x80b26

BattleText_AnEGGCantBattle: ; 0x80b26
	text "An Egg can't"
	line "battle!"
	prompt
; 0x80b3b

BattleText_CantEscape: ; 0x80ba0
	text "Can't escape!"
	prompt
; 0x80bae

BattleText_TheresNoEscapeFromTrainerBattle: ; 0x80b49
	text "No! There's no"
	line "running from a"
	cont "trainer battle!"
	prompt

BattleText_GotAwaySafely: ; 0x80b77
	text "Got away safely!"
	prompt

BattleText_UserFledUsingAStringBuffer1: ; 0x80b89
	text "<USER>"
	line "fled using a"
	cont "@"
	text_from_ram StringBuffer1
	text "!"
	prompt
; 0x80ba0

BattleText_UserHurtBySpikes: ; 0x80bae
	text "<USER> is"
	line "hurt by spikes!"
	prompt
; 0x80bc2

RecoveredUsingText: ; 0x80bc2
	text "<USER>"
	line "recovered using a"
	cont "@"
	text_from_ram StringBuffer1
	text "!"
	prompt
; 0x80bde

AirBalloonPoppedText:
	text "<TARGET>'s"
	line "Air Balloon"
	cont "popped!"
	prompt

BattleText_UsersStringBuffer1Activated: ; 0x80bde
	text "<USER>'s"
	line "@"
	text_from_ram StringBuffer1
	text ""
	cont "activated!"
	prompt
; 0x80bf3

BattleText_ItemsCantBeUsedHere: ; 0x80bf3
	text "Items can't be"
	line "used here."
	prompt
; 0x80c0d

BattleText_PkmnIsAlreadyOut: ; 0x80c0d
	text_from_ram BattleMonNick
	text ""
	line "is already out."
	prompt
; 0x80c22

BattleText_PkmnCantBeRecalled: ; 0x80c22
	text_from_ram BattleMonNick
	text ""
	line "can't be recalled!"
	prompt
; 0x80c39

BattleText_PkmnCantBeRecalledAbility: ; 0x80c22
	text_from_ram EnemyMonNick
	text "'s"
	line "@"
	text_from_ram StringBuffer1
	text ""
	cont "prevents escape!"
	prompt

BattleText_TheresNoPPLeftForThisMove: ; 0x80c39
	text "There's no PP left"
	line "for this move!"
	prompt
; 0x80c5b

BattleText_ItemOnlyAllowsMove: ; choice items
	text "The @"
	text_from_ram StringBuffer1
	text ""
	line "only allows use"
	cont "of @"
	text_from_ram StringBuffer2
	text "!"
	prompt

BattleText_ItemPreventsStatusMoves: ; assault vest
	text "The @"
	text_from_ram StringBuffer1
	text ""
	line "prevents usage"
	cont "of status moves!"
	prompt

BattleText_TheMoveIsDisabled: ; 0x80c5b
	text "The move is"
	line "disabled!"
	prompt
; 0x80c72

BattleText_PkmnHasNoMovesLeft: ; 0x80c72
	text_from_ram BattleMonNick
	text ""
	line "has no moves left!"
	done
; 0x80c8a

BattleText_TargetsEncoreEnded: ; 0x80c8a
	text "<TARGET>'s"
	line "encore ended!"
	prompt
; 0x80c9c

BattleText_StringBuffer1GrewToLevel: ; 0x80c9c
	text_from_ram StringBuffer1
	text " grew to"
	line "level @"
	deciram CurPartyLevel, 1, 3
	text "!@"
	sound_dex_fanfare_50_79
	db "@@"
; 0x80cb9

BattleText_WildPkmnIsEating: ; 0x80cba
	text "Wild @"
	text_from_ram EnemyMonNick
	text ""
	line "is eating!"
	prompt
;; 0x80cd1

BattleText_WildPkmnIsAngry: ; 0x80cd1
	text "Wild @"
	text_from_ram EnemyMonNick
	text ""
	line "is angry!"
	prompt
;; 0x80ce7

BattleText_ThrewRock:
	text "<PLAYER> threw a"
	line "rock."
	prompt

BattleText_ThrewBait:
	text "<PLAYER> threw"
	line "some bait."
	prompt

FastAsleepText: ; 0x80ce7
	text "<USER>"
	line "is fast asleep!"
	prompt
; 0x80cfa

WokeUpText: ; 0x80cfa
	text "<USER>"
	line "woke up!"
	prompt
; 0x80d06

FrozenSolidText: ; 0x80d06
	text "<USER>"
	line "is frozen solid!"
	prompt
; 0x80d1a

FlinchedText: ; 0x80d1a
	text "<USER>"
	line "flinched!"
	prompt
; 0x80d27

MustRechargeText: ; 0x80d27
	text "<USER>"
	line "must recharge!"
	prompt
; 0x80d39

DisabledNoMoreText: ; 0x80d39
	text "<USER> is"
	line "disabled no more!"
	prompt
; 0x80d4f

IsConfusedText: ; 0x80d4f
	text "<USER>"
	line "is confused!"
	prompt
; 0x80d5f

HurtItselfText: ; 0x80d5f
	text "It hurt itself in"
	line "its confusion!"
	prompt
; 0x80d81

ConfusedNoMoreText: ; 0x80d81
	text "<USER> is"
	line "confused no more!"
	prompt
; 0x80d97

BecameConfusedText: ; 0x80d97
	text "<TARGET>"
	line "became confused!"
	prompt
; ItemHealedConfusion

BattleText_ItemHealedConfusion: ; ItemHealedConfusion
	text "A @"
	text_from_ram StringBuffer1
	text " rid"
	line "<USER>"
	cont "of its confusion."
	prompt
; 0x80dcc

AlreadyConfusedText: ; 0x80dcc
	text "<TARGET> is"
	line "already confused!"
	prompt
; 0x80de2

BattleText_UsersHurtByStringBuffer1: ; 0x80de2
	text "<USER> is"
	line "hurt by"
	cont "@"
	text_from_ram StringBuffer1
	text "!"
	prompt
; 0x80df5

BattleText_UserWasReleasedFromStringBuffer1: ; 0x80df5
	text "<USER>"
	line "was released from"
	cont "@"
	text_from_ram StringBuffer1
	text "!"
	prompt
; 0x80e11

WhirlpoolTrapText: ; 0x80e24
	text "<TARGET>"
	line "was trapped!"
	prompt
; 0x80e34

FireSpinTrapText: ; 0x80e34
	text "<TARGET>"
	line "was trapped!"
	prompt
; 0x80e44

WrappedByText: ; 0x80e44
	text "<TARGET>"
	line "was wrapped by"
	cont "<USER>!"
	prompt
; 0x80e59

HungOnText: ; 0x80e99
	text "<TARGET>"
	line "hung on with"
	cont "@"
	text_from_ram StringBuffer1
	text "!"
	prompt
; 0x80eb0

EnduredText: ; 0x80eb0
	text "<TARGET>"
	line "endured the hit!"
	prompt
; 0x80ec4

InLoveWithText: ; 0x80ec4
	text "<USER>"
	line "is in love with"
	cont "<TARGET>!"
	prompt
; 0x80eda

InfatuationText:
	text "<USER>'s"
	line "infatuation kept"
	cont "it from attacking!"
	prompt

ObliviousPreventedDestinyKnot:
	text "<USER>'s"
	line "@"
	text_from_ram StringBuffer1
	text ""
	cont "prevents"
	cont "@"
	text_from_ram StringBuffer2
	text ""
	cont "infatuating it!"
	prompt


DestinyKnotInfatuatedUser:
	text "<TARGET>'s"
	line "@"
	text_from_ram StringBuffer1
	text ""
	cont "infatuated"
	para "<USER>!"
	prompt

DisabledMoveText: ; 0x80f02
	text "<USER>'s"
	line "@"
	text_from_ram StringBuffer1
	text " is"
	cont "disabled!"
	prompt
; 0x80f19

UsedMoveText:
	text "<USER>"
	line "used @"
	text_from_ram StringBuffer2
	text "!"
	done

UsedMoveInsteadText:
	text "<USER>"
	line "used @"
	text_from_ram StringBuffer2
	text ""
	cont "instead!"
	done

LoafingAroundText: ; 0x80f19
	text_from_ram BattleMonNick
	text " is"
	line "loafing around."
	prompt
; 0x80f31

BeganToNapText: ; 0x80f31
	text_from_ram BattleMonNick
	text " began"
	line "to nap!"
	prompt
; 0x80f44

WontObeyText: ; 0x80f44
	text_from_ram BattleMonNick
	text " won't"
	line "obey!"
	prompt
; 0x80f54

TurnedAwayText: ; 0x80f54
	text_from_ram BattleMonNick
	text " turned"
	line "away!"
	prompt
; 0x80f66

IgnoredOrdersText: ; 0x80f66
	text_from_ram BattleMonNick
	text " ignored"
	line "orders!"
	prompt
; 0x80f7b

IgnoredSleepingText: ; 0x80f7b
	text_from_ram BattleMonNick
	text " ignored"
	line "orders…sleeping!"
	prompt
; 0x80f99

NoPPLeftText: ; 0x80f99
	text "But no PP is left"
	line "for the move!"
	prompt
; 0x80fba

HasNoPPLeftText: ; 0x80fba
	text "<USER>"
	line "has no PP left for"
	cont "@"
	text_from_ram StringBuffer2
	text "!"
	prompt
; 0x80fd7

WentToSleepText: ; 0x80fd7
	text "<USER>"
	line "went to sleep!"
	done
; 0x80fe9

RestedText: ; 0x80fe9
	text "<USER>"
	line "fell asleep and"
	cont "became healthy!"
	done
; 0x8100c

RegainedHealthText: ; 0x8100c
	text "<USER>"
	line "regained health!"
	prompt
; 0x81020

AttackMissedText: ; 0x81020
	text "<USER>'s"
	line "attack missed!"
	prompt
; 0x81033

CrashedText: ; 0x81046
	text "<USER>"
	line "kept going and"
	cont "crashed!"
	prompt
; 0x81061

UnaffectedText: ; 0x81061
	text "<TARGET> is"
	line "unaffected!"
	prompt
; 0x81071

DoesntAffectText: ; 0x81071
	text "It doesn't affect"
	line "<TARGET>!"
	prompt
; 0x81086

CriticalHitText: ; 0x81086
	text "A critical hit!"
	prompt
; 0x81097

SuperEffectiveText: ; 0x810aa
	text "It's super-"
	line "effective!"
	prompt
; 0x810c1

NotVeryEffectiveText: ; 0x810c1
	text "It's not very"
	line "effective…"
	prompt
; 0x810da

TookDownWithItText: ; 0x810da
	text "<TARGET>"
	line "took <USER>"
	cont "down with it!"
	prompt
; 0x810f3

RageBuildingText: ; 0x810f3
	text "<USER>'s"
	line "rage is building!"
	prompt
; 0x81109

GotAnEncoreText: ; 0x81109
	text "<TARGET>"
	line "got an encore!"
	prompt
; 0x8111b

SharedPainText:
	text "The battlers"
	line "shared pain!"
	prompt

SwappedAbilitiesText:
	text "The battlers"
	line "swapped abilities!"
	prompt

SwappedItemsText:
	text "The battlers"
	line "swapped items!"
	prompt

SketchedText: ; 0x81143
	text "<USER>"
	line "sketched"
	cont "@"
	text_from_ram StringBuffer1
	text "!"
	prompt
; 0x81156

DestinyBondEffectText: ; 0x81156
	text "<USER> is"
	line "trying to take its"
	cont "opponent with it!"
	prompt
; 0x8117f

BellChimedText: ; 0x811a0
	text "A bell chimed!"
	line ""
	prompt
; 0x811b1

FellAsleepText: ; 0x811b1
	text "<TARGET>"
	line "fell asleep!"
	prompt
; 0x811c1

AlreadyAsleepText: ; 0x811c1
	text "<TARGET> is"
	line "already asleep!"
	prompt
; 0x811d5

WasPoisonedText: ; 0x811d5
	text "<TARGET>"
	line "was poisoned!"
	prompt
; 0x811e6

BadlyPoisonedText: ; 0x811e6
	text "<TARGET> is"
	line "badly poisoned!"
	prompt
; 0x811fa

AlreadyPoisonedText: ; 0x811fa
	text "<TARGET> is"
	line "already poisoned!"
	prompt
; 0x81210

SuckedHealthText: ; 0x81210
	text "Sucked health from"
	line "<TARGET>!"
	prompt
; 0x81227

DreamEatenText: ; 0x81227
	text "<TARGET>'s"
	line "dream was eaten!"
	prompt
; 0x8123c

WasBurnedText: ; 0x8123c
	text "<TARGET>"
	line "was burned!"
	prompt
; 0x8124b

DefrostedOpponentText: ; 0x8124b
	text "<TARGET>"
	line "was defrosted!"
	prompt
; 0x8125d

AlreadyBurnedText:
	text "<TARGET> is"
	line "already burned!"
	prompt

WasFrozenText: ; 0x8125d
	text "<TARGET>"
	line "was frozen solid!"
	prompt
; 0x81272

WontRiseAnymoreText: ; 0x81272
	text "<USER>'s"
	line "@"
	text_from_ram StringBuffer2
	text " won't go"
	cont "any higher!"
	prompt
; 0x8128f

WontDropAnymoreText: ; 0x8128f
	text "<TARGET>'s"
	line "@"
	text_from_ram StringBuffer2
	text " won't go"
	cont "any lower!"
	prompt
; 0x812ac

FledFromBattleText:: ; 0x812ac
	text "<USER>"
	line "fled from battle!"
	prompt
; 0x812c1

FledInFearText: ; 0x812c1
	text "<TARGET>"
	line "fled in fear!"
	prompt
; 0x812d2

PlayerHitTimesText: ; 0x812e5
	text "Hit @"
	deciram PlayerDamageTaken, 1, 1
	text " times!"
	prompt
; 0x812f8

EnemyHitTimesText: ; 0x812f8
	text "Hit @"
	deciram EnemyDamageTaken, 1, 1
	text " times!"
	prompt
; 0x8130b

ProtectedByMistText: ; 0x81321
	text "<TARGET> is"
	line "protected by mist."
	prompt
; 0x81338

GettingPumpedText: ; 0x81338
	interpret_data
	text "<USER> is"
	line "getting pumped!"
	prompt
; 0x8134d

RecoilText: ; 0x8134d
	text "<USER> is"
	line "hit with recoil!"
	prompt
; 0x81362

MadeSubstituteText: ; 0x81362
	text "<USER>"
	line "made a substitute!"
	prompt
; 0x81378

HasSubstituteText: ; 0x81378
	text "<USER>"
	line "has a substitute!"
	prompt
; 0x8138d

TooWeakSubText: ; 0x8138d
	text "Too weak to make"
	line "a substitute!"
	prompt
; 0x813ad

SubTookDamageText: ; 0x813ad
	text "The substitute"
	line "took damage for"
	cont "<TARGET>!"
	prompt
; 0x813d0

SubFadedText: ; 0x813d0
	text "<TARGET>'s"
	line "substitute faded!"
	prompt
; 0x813e6

WasSeededText: ; 0x813f8
	text "<TARGET>"
	line "was seeded!"
	prompt
; 0x81407

EvadedText: ; 0x81407
	text "<TARGET>"
	line "evaded the attack!"
	prompt
; 0x8141d

WasDisabledText: ; 0x8141d
	text "<TARGET>'s"
	line "@"
	text_from_ram StringBuffer1
	text " was"
	cont "disabled!"
	prompt
; 0x81435

CoinsScatteredText: ; 0x81435
	text "Coins scattered"
	line "everywhere!"
	prompt
; 0x81452

TransformedTypeText: ; 0x81452
	text "<USER>"
	line "became the"
	cont "@"
	text_from_ram StringBuffer1
	text "-type!"
	prompt
; 0x81476

EliminatedStatsText: ; 0x81476
	text "All stat changes"
	line "were eliminated!"
	prompt
; 0x81499

TransformedText: ; 0x81499
	text "<USER>"
	line "transformed into"
	cont "@"
	text_from_ram StringBuffer1
	text "!"
	prompt
; 0x814b4

LightScreenEffectText: ; 0x814b4
	text "<USER>'s"
	line "Spcl.Def rose!"
	prompt
; 0x814c7

ReflectEffectText: ; 0x814c7
	text "<USER>'s"
	line "Defense rose!"
	prompt
; 0x814d9

NothingHappenedText: ; 0x814d9
	text "But nothing"
	line "happened."
	prompt
; 0x814f0

ButItFailedText: ; 0x814f0
	text "But it failed!"
	prompt
; 0x81500

ItFailedText: ; 0x81500
	text "It failed!"
	prompt
; 0x8150c

DidntAffect1Text: ; 0x8150c
	text "It didn't affect"
	line "<TARGET>!"
	prompt
; 0x81520

DidntAffect2Text: ; 0x81520
	text "It didn't affect"
	line "<TARGET>!"
	prompt
; 0x81534

HPIsFullText: ; 0x81534
	text "<USER>'s"
	line "HP is full!"
	prompt
; 0x81544

DraggedOutText: ; 0x81544
	text "<USER>"
	line "was dragged out!"
	prompt
; 0x81558

ParalyzedText: ; 0x81558
	text "<TARGET> is"
	line "paralyzed! It"
	cont "might not attack!"
	prompt
; 0x8157d

FullyParalyzedText: ; 0x8157d
	text "<USER> is"
	line "fully paralyzed!"
	prompt
; 0x81592

AlreadyParalyzedText: ; 0x81592
	text "<TARGET> is"
	line "already paralyzed!"
	prompt
; 0x815a9

ProtectedByText:
	text "<TARGET> is"
	line "protected by"
	cont "@"
	text_from_ram StringBuffer1
	text "!"
	prompt

RegainedStatsWithItem:
	text "<USER>"
	line "regained stats"
	cont "with @"
	text_from_ram StringBuffer1
	text "!"
	prompt

CuredInfatuationWithItem:
	text "<USER>"
	line "cured infatuation"
	cont "with @"
	text_from_ram StringBuffer1
	text "!"
	prompt

CuredEncoreWithItem:
	text "<USER>"
	line "cured Encore"
	cont "with @"
	text_from_ram StringBuffer1
	text "!"
	prompt

CuredDisableWithItem:
	text "<USER>"
	line "cured Disable"
	cont "with @"
	text_from_ram StringBuffer1
	text "!"
	prompt

StoleText:
	text "<USER>"
	line "stole @"
	text_from_ram StringBuffer1
	text ""
	cont "from its foe!"
	prompt

KnockedOffItemText:
	text "<USER>"
	line "knocked off"
	cont "@"
	text_from_ram StringBuffer1
	text "!"
	prompt

CantEscapeNowText: ; 0x815f7
	text "<TARGET>"
	line "can't escape now!"
	prompt
; 0x8160b

WasDefrostedText: ; 0x8162b
	text "<USER>"
	line "was defrosted!"
	prompt
; 0x8163d

PutACurseText: ; 0x8163d
	text "<USER>"
	line "cut its own HP and"

	para "put a curse on"
	line "<TARGET>!"
	prompt
; 0x81665

ProtectedItselfText: ; 0x81665
	text "<USER>"
	line "protected itself!"
	prompt
; 0x8167a

ProtectingItselfText: ; 0x8167a
	text "<TARGET> is"
	line "protecting itself!"
	done
; 0x81691

SpikesText:
	text "Spikes scattered"
	line "all around"
	cont "<TARGET>!"
	prompt

ToxicSpikesText:
	text "Toxic spikes"
	line "scattered around"
	cont "<TARGET>!"
	prompt

IdentifiedText: ; 0x816b1
	text "<USER>"
	line "identified"
	cont "<TARGET>!"
	prompt
; 0x816c2

StartPerishText: ; 0x816c2
	text "Both #mon will"
	line "faint in 3 turns!"
	prompt
; 0x816e4

SandstormBrewedText: ; 0x816e4
	text "A sandstorm"
	line "brewed!"
	prompt
; 0x816f9

HailStartedText:
	text "It started to"
	line "hail!"
	prompt

BracedItselfText: ; 0x816f9
	text "<USER>"
	line "braced itself!"
	prompt
; 0x8170b

FellInLoveText: ; 0x8170b
	text "<TARGET>"
	line "fell in love!"
	prompt
; 0x8171c

CoveredByVeilText: ; 0x8171c
	text "<USER> is"
	line "covered by a veil!"
	prompt
; 0x81733

SafeguardProtectText: ; 0x81733
	text "<TARGET>"
	line "is protected by"
	cont "Safeguard!"
	prompt
; 0x81751

MagnitudeText: ; 0x81751
	text "Magnitude @"
	deciram wd265, 1, 1
	text "!"
	prompt
; 0x81764

ReleasedByText: ; 0x81764
	text "<USER>"
	line "was released by"
	cont "<TARGET>!"
	prompt
; 0x8177a

ShedLeechSeedText: ; 0x8177a
	text "<USER>"
	line "shed Leech Seed!"
	prompt
; 0x8178e

BlewSpikesText:
	text "<USER>"
	line "blew away Spikes!"
	prompt

BlewToxicSpikesText:
	text "<USER>"
	line "blew away Toxic"
	cont "Spikes!"
	prompt

DownpourText: ; 0x817a3
	text "It started"
	line "to rain!"
	prompt
; 0x817b8

SunGotBrightText: ; 0x817b8
	text "The sunlight"
	line "turned harsh!"
	prompt
; 0x817d2

BellyDrumText: ; 0x817d2
	text "<USER>"
	line "cut its HP and"
	cont "maximized Attack!"
	prompt
; 0x817f6

ForesawAttackText: ; 0x81817
	text "<USER>"
	line "foresaw an attack!"
	prompt
; 0x8182d

IgnoredOrders2Text: ; 0x81850
	text "<USER>"
	line "ignored orders!"
	prompt
; 0x81863

BecameHealthyText:
	text "<USER>"
	line "became healthy!"
	prompt

NotifyAirBalloonText:
	text "<USER>"
	line "floats in the air"
	cont "with @"
	text_from_ram StringBuffer1
	text "!"
	prompt

TraceActivationText:
	text "<USER>"
	line "traced"
	cont "@"
	text_from_ram StringBuffer1
	text "!"
	prompt

TraceFailureText:
	text "<USER>"
	line "failed to trace"
	cont "<TARGET>!"
	prompt

NotifyCloudNine:
	text "The weather was"
	line "suppressed!"
	prompt

NotifyPressure:
	text "<USER> is"
	line "exerting its"
	cont "Pressure!"
	prompt

NotifyMoldBreaker:
	text "<USER>"
	line "breaks the mold!"
	prompt

NotifyUnnerve:
	text "<TARGET> is"
	line "too afraid to eat"
	cont "Berries!"
	prompt

FriskedItemText:
	text "<USER>"
	line "frisked its foe"

	para "and found a"
	line "@"
	text_from_ram StringBuffer1
	text "!"
	prompt

PickedItemText:
	text "<USER>"
	line "harvested"
	cont "@"
	text_from_ram StringBuffer1
	text "!"
	prompt

HarvestedItemText:
	text "<USER>"
	line "harvested"
	cont "@"
	text_from_ram StringBuffer1
	text "!"
	prompt

PoisonHealText:
	text "<USER>'s"
	line "Poison Heal"
	cont "restored health!"
	prompt

FirePoweredUpText:
	text "<USER>'s"
	line "Fire-type moves"
	cont "were powered up!"
	prompt

AngerPointMaximizedAttackText:
	text "<USER>"
	line "maximized Attack"
	cont "with Anger Point!"
	prompt

DampAbilityText:
	text "<USER>'s"
	line "Damp prevented"
	cont "the explosion!"
	prompt

ShudderedText:
; since the ability works with the opponent move data,
; it is on the opponent turn mostly
	text "<TARGET>"
	line "shuddered!"
	prompt

ForewarnText: ; 0x80f02
	text "<TARGET>"
	line "has @"
	text_from_ram StringBuffer1
	text "!"
	prompt

BattleText_WentBackToPlayer:
	text "<USER> went"
	line "back to <PLAYER>!"
	prompt

BattleText_WentBackToEnemy:
	text "<USER>"
	line "went back to"
	cont "<ENEMY>!"
	prompt

ScaredText:
	text "<USER> is too"
	line "scared to move!"
	prompt

GetOutText:
	text "Ghost: Get out…"
	line "Get out…"
	prompt

CarrieFinalPkmnText:
CalFinalPkmnText:
	text "I still have one"
	line "#mon!"
	prompt

FalknerFinalPkmnText:
	text "The wind is"
	line "finally with us!"
	prompt

BugsyFinalPkmnText:
	text "Even though it's"
	line "my last #mon,"

	para "Bug #mon are"
	line "tough!"
	prompt

WhitneyFinalPkmnText:
	text "H-hey! Just one"
	line "left? But…"

	para "I ain't losin',"
	line "you hear?"
	prompt

MortyFinalPkmnText:
	text "I still believe"
	line "we can do it!"
	prompt

ChuckFinalPkmnText:
	text "We haven't lost"
	line "yet!"
	prompt

JasmineFinalPkmnText:
	text "Well-tempered"
	line "steel will hang on"
	cont "to the very last!"
	prompt

PryceFinalPkmnText:
	text "Humph… You are"
	line "quite the Trainer."
	prompt

ClairFinalPkmnText:
	text "One last #mon?"
	line "This is where the"
	cont "real fight begins!"
	prompt

WillFinalPkmnText:
	text "We Psychics don't"
	line "give up until we"
	cont "reach zero!"
	prompt

KogaFinalPkmnText:
	text "Fwahaha! I've been"
	line "counting on this"

	para "one from the very"
	line "beginning!"
	prompt

BrunoFinalPkmnText:
	text "Fight as hard as"
	line "you can 'til you"
	cont "faint!"
	prompt

KarenFinalPkmnText:
	text "This is far from"
	line "being backed into"
	cont "a corner!"
	prompt

ChampionFinalPkmnText:
	text "All right! I"
	line "thought this would"
	cont "never happen!"
	prompt

BrockFinalPkmnText:
	text "Ah ha ha!"
	line "It itches!"
	prompt

MistyFinalPkmnText:
	text "Hmm… You're"
	line "pretty good…"
	prompt

LtSurgeFinalPkmnText:
	text "It's not over yet."
	line "It's just getting"
	cont "started!"
	prompt

ErikaFinalPkmnText:
	text "Don't go easy on"
	line "me. Give me every-"
	cont "thing you've got!"
	prompt

JanineFinalPkmnText:
	text "You've got a great"
	line "battle technique!"
	prompt

SabrinaFinalPkmnText:
	text "What will happen"
	line "after this?"
	cont "I already know."
	prompt

BlaineFinalPkmnText:
	text "I'll show you the"
	line "spirit of my cave"
	cont "Gym!"
	prompt

BlueFinalPkmnText:
	text "Heh heh heh…"
	line "You're unprepared"

	para "for this. We'll"
	line "knock you down!"
	prompt

RedFinalPkmnText:
LeafFinalPkmnText:
	text "………………"
	prompt

Rival1_1FinalPkmnText:
	text "…Humph!"
	line "You're doing OK"
	cont "for someone weak."
	prompt

Rival1_2FinalPkmnText:
	text "Say, you've got a"
	line "lot of nerve,"
	cont "coming here…"
	prompt

Rival1_3FinalPkmnText:
	text "Out of despera-"
	line "tion, weak people"

	para "sometimes do OK"
	line "at fighting back."
	prompt

Rival1_4FinalPkmnText:
	text "Hey, hey!"
	line "Why so serious?"
	prompt

Rival1_5FinalPkmnText:
	text "I see. Seems like"
	line "it wasn't just luck"

	para "that's gotten you"
	line "this far."
	prompt

Rival2_1FinalPkmnText:
	text "I see. You weren't"
	line "coming to Kanto"
	cont "just to show off…"
	prompt

Rival2_2FinalPkmnText:
	text "Why?! I've still"
	line "got one left!"
	prompt

Lyra1_1FinalPkmnText:
	text "You've never had a"
	line "#mon battle"
	cont "before, have you?"

	para "I could explain,"
	line "but you'll learn"

	para "more from exper-"
	line "ience."

	para "Do your best,"
	line "<PLAYER>!"
	prompt

Lyra1_2FinalPkmnText:
	text "You're learning"
	line "quickly, <PLAYER>!"
	prompt

Lyra1_3FinalPkmnText:
	text "OK! Time for my"
	line "last #mon!"
	prompt

Lyra1_4FinalPkmnText:
	text "Whether I win or"
	line "lose, this has"
	cont "been fun!"
	prompt

Lyra2_1FinalPkmnText:
	text "You've brought me"
	line "down to my last"
	cont "#mon…"
	prompt

Proton1FinalPkmnText:
	text "Seriously, you'd"
	line "chase me this far?"
	prompt

Proton2FinalPkmnText:
	text "Everywhere we go,"
	line "someone always"
	cont "disagrees with us…"
	prompt

Petrel1FinalPkmnText:
	text "What? Am I"
	line "losing?"
	prompt

Petrel2FinalPkmnText:
	text "Hey, you're good!"
	prompt

Archer1FinalPkmnText:
	text "We can't have you"
	line "getting in the way"

	para "before Giovanni"
	line "rejoins us!"
	prompt

Archer2FinalPkmnText:
	text "Ah, you are indeed"
	line "strong, but…"
	cont "I wonder…"
	prompt

Ariana1FinalPkmnText:
	text "Wh… Wha… Why are"
	line "you so strong?!"
	prompt

Ariana2FinalPkmnText:
	text "Hey, what do you"
	line "think you're"
	cont "doing?!"
	prompt

Giovanni1FinalPkmnText:
	text "My #mon is"
	line "invincible!"
	prompt

Giovanni2FinalPkmnText:
	text "Don't tell me some"
	line "inexperienced kid"

	para "can possibly be"
	line "that strong!"
	prompt

ProfOakFinalPkmnText:
	text "Hm! Excellent!"
	line "But we aren't"
	cont "done yet!"
	prompt

ProfElmFinalPkmnText:
	text "It's almost"
	line "over…"
	prompt

ProfIvyFinalPkmnText:
	text "I'm down, but"
	line "not out!"
	prompt

MysticalManFinalPkmnText:
	text "Time for a dra-"
	line "matic comeback!"
	prompt

KarateKingFinalPkmnText:
	text "Yaaarggh!"
	prompt

PalmerFinalPkmnText:
	text "Bravo!"
	prompt

JessieJamesFinalPkmnText:
	text "We have a proud"
	line "tradition of fail-"
	cont "ure to uphold!"
	prompt

LoreleiFinalPkmnText:
	text "You only got a"
	line "taste of my power!"
	prompt

AgathaFinalPkmnText:
	text "Don't assume that"
	line "you've won, child!"
	prompt

StevenFinalPkmnText:
	text "I knew you would"
	line "be strong…"
	prompt

CynthiaFinalPkmnText:
	text "I won't let this"
	line "end yet!"
	prompt

InverFinalPkmnText:
	text "You're getting the"
	line "hang of this!"
	prompt

CherylFinalPkmnText:
	text "I can't keep up"
	line "with healing…"
	prompt

RileyFinalPkmnText:
	text "Your team! I sense"
	line "your strong aura!"
	prompt

BuckFinalPkmnText:
	text "Now this! This is"
	line "a smoking-hot sit-"
	cont "uation!"
	prompt

MarleyFinalPkmnText:
	text "…My time with you"
	line "is drawing to a"
	cont "close."
	prompt

MiraFinalPkmnText:
	text "Oh, no! You're"
	line "too much for me!"
	prompt

AnabelFinalPkmnText:
	text "Your talent…"
	line "It's real."
	prompt

DarachFinalPkmnText:
	text "My last stand!"
	line "Allez!"
	prompt

CaitlinFinalPkmnText:
	text "Even at this time,"
	line "I should stay cool"
	cont "and collected…"
	prompt

CandelaFinalPkmnText:
	text "Down to the wire!"
	line "How exciting!"
	prompt

BlancheFinalPkmnText:
	text "I am certainly"
	line "impressed so far."
	prompt

SparkFinalPkmnText:
	text "You're good!"
	line "No doubt about it!"
	prompt

FlanneryFinalPkmnText:
	text "Um… what should"
	line "I do now?"
	prompt

MayleneFinalPkmnText:
	text "This isn't the"
	line "end, my friend!"
	prompt

SkylaFinalPkmnText:
	text "This is my last"
	line "#mon…"

	para "But I'll never"
	line "give up hope!"
	prompt

ValerieFinalPkmnText:
	text "Oh my…"
	prompt

KukuiFinalPkmnText:
	text "My soul burns hot,"
	line "yeah!"
	prompt

BillFinalPkmnText:
	text "Yeehah!"
	line "What a battle!"
	prompt

YellowFinalPkmnText:
	text "My last #mon…"
	line "Lend me your"
	cont "power!"
	prompt

WalkerFinalPkmnText:
	text "We can still fly!"
	prompt

ImakuniFinalPkmnText:
	text "I'm running away!"
	line "…I can't?"
	prompt

LawrenceFinalPkmnText:
	text "Inconceivable!"
	prompt

ReiFinalPkmnText:
	text "I'm not done yet."
	prompt
