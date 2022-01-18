BattleText::

LinkBattleErrorText::
	ctxt "There was a link"
	line "error."

	para "The game will now"
	line "be reset."
	prompt

BattleText_PlayerPickedUpPayDayMoney:
	ctxt "<PLAYER> picked up"
	line "¥"
	text_decimal wPayDayMoney, 3, 6
	text "!"
	prompt

WildPokemonAppearedText:
	ctxt "A wild "
LegendaryAppearedText:
	text_ram wEnemyMonNickname
	ctxt ""
	line "appeared!"
	prompt

HookedPokemonAttackedText:
	ctxt "The hooked"
	line ""
	text_ram wEnemyMonNickname
	ctxt ""
	cont "attacked!"
	prompt

PokemonFellFromTreeText:
	text_ram wEnemyMonNickname
	ctxt " fell"
	line "out of the tree!"
	prompt

WantsToBattleText::
	ctxt "<ENEMY>"
	line "wants to battle!"
	prompt

WantToBattleText::
	ctxt "<ENEMY>"
	line "want to battle!"
	prompt

BattleText_WildFled:
	text "Wild "
BattleText_LegendaryFled:
	text_ram wEnemyMonNickname
	ctxt ""
	line "fled!"
	prompt

BattleText_EnemyFled:
	ctxt "The foe "
	text_ram wEnemyMonNickname
	ctxt ""
	line "fled!"
	prompt

BattleText_EnemyCantEscape:
	ctxt "<USER>"
	line "can't escape!"
	prompt

if DEF(DEBUG)
DealtXDamageText:
	ctxt "Dealt "
	text_decimal wCurDamage, 2, 5
	ctxt " dmg"
	line "before roll."
	prompt
endc

HurtByPoisonText:
	ctxt "<USER> is"
	line "hurt by poison!"
	prompt

HurtByBurnText:
	ctxt "<USER> is"
	line "hurt by its burn!"
	prompt

LeechSeedSapsText:
	ctxt "Leech Seed saps"
	line "<USER>!"
	prompt

HurtByCurseText:
	ctxt "<USER> is"
	line "hurt by the curse!"
	prompt

SandstormHitsText:
	ctxt "<USER> is"
	line "buffeted by"
	cont "the sandstorm!"
	prompt

HailHitsText:
	ctxt "<USER> is"
	line "buffeted by"
	cont "the hail!"
	prompt

PerishCountText:
	ctxt "<USER>'s"
	line "Perish count is "
	text_decimal wTextDecimalByte, 1, 1
	text "!"
	prompt

BattleText_UserLostSomeOfItsHP:
	ctxt "<USER>"
	line "lost some of its"
	cont "HP!"
	prompt

BattleText_PickedUpItem:
	; assumes player (enemy might overflow text-wise)
	ctxt "<USER> picked"
	line "up "
	text_ram wStringBuffer2
	text "."
	prompt

BattleText_UserRecoveredWithItem:
	ctxt "<USER>"
	line "recovered with"
	cont ""
	text_ram wStringBuffer1
	text "."
	prompt

BattleText_UserAteItem:
	text "<USER>"
	line "ate "
	text_ram wStringBuffer1
	text "!"
	prompt

BattleText_UserHurtByItem:
	ctxt "<USER>"
	line "was hurt by"
	cont ""
	text_ram wStringBuffer1
	text "."
	prompt

BattleText_UserItemLetItMoveFirst::
	text "<USER>'s"
	line ""
	text_ram wStringBuffer1
	ctxt " let"
	cont "it move first."
	prompt

BattleText_UserRecoveredPPUsing:
	ctxt "<USER>"
	line "restored PP of"
	cont ""
	text_ram wStringBuffer2
	ctxt " using"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

BrokeLightScreenText:
	ctxt "<USER>"
	line "broke the target's"
	cont "Light Screen!"
	prompt

BrokeReflectText:
	ctxt "<USER>"
	line "broke the target's"
	cont "Reflect!"
	prompt

BattleText_ItemLowered:
	text "The "
	text_ram wStringBuffer1
	ctxt ""
	line "lowered"
	cont "<USER>'s"
	cont ""
	text_ram wStringBuffer2
	text "!"
	prompt

BattleText_ItemHarshlyLowered:
	text "The "
	text_ram wStringBuffer1
	ctxt ""
	line "sharply lowered"
	cont "<USER>'s"
	cont ""
	text_ram wStringBuffer2
	text "!"
	prompt

BattleText_ItemSeverelyLowered:
	text "The "
	text_ram wStringBuffer1
	ctxt ""
	line "severely lowered"
	cont "<USER>'s"
	cont ""
	text_ram wStringBuffer2
	text "!"
	prompt

BattleText_ItemRaised:
	text "The "
	text_ram wStringBuffer1
	ctxt ""
	line "raised"
	cont "<USER>'s"
	cont ""
	text_ram wStringBuffer2
	text "!"
	prompt

BattleText_ItemSharplyRaised:
	text "The "
	text_ram wStringBuffer1
	ctxt ""
	line "sharply raised"
	cont "<USER>'s"
	cont ""
	text_ram wStringBuffer2
	text "!"
	prompt

BattleText_ItemDrasticallyRaised:
	text "The "
	text_ram wStringBuffer1
	ctxt ""
	line "drastically raised"
	cont "<USER>'s"
	cont ""
	text_ram wStringBuffer2
	text "!"
	prompt

BattleText_ItemRaisedCrit:
	text "<USER>"
	line "used "
	text_ram wStringBuffer1
	ctxt ""
	cont "to get pumped!"
	prompt

BattleText_UserChargedWithItem:
	ctxt "<USER>"
	line "became charged"
	cont "using "
	text_ram wStringBuffer1
	text "!"
	prompt

BattleText_UsersFutureSightMissed:
; used when Future Sight can't hit anything because there was
; no target (so <TARGET> is undefined)
	ctxt "The Future Sight"
	line "arrived!"

	para "But it failed!"
	prompt

BattleText_TargetWasHitByFutureSight:
	ctxt "<TARGET>"
	line "took the"
	cont "Future Sight!"
	prompt

BattleText_MistFaded:
	text_ram wStringBuffer1
	ctxt " #mon's"
	line "mist faded!"
	prompt

BattleText_SafeguardFaded:
	text_ram wStringBuffer1
	ctxt " #mon's"
	line "Safeguard faded!"
	prompt

BattleText_LightScreenFell:
	text_ram wStringBuffer1
	ctxt " #mon's"
	line "Light Screen fell!"
	prompt

BattleText_ReflectFaded:
	text_ram wStringBuffer1
	ctxt " #mon's"
	line "Reflect faded!"
	prompt

BattleText_TheRainStopped:
	ctxt "The rain stopped."
	prompt

BattleText_TheSunlightFaded:
	ctxt "The sunlight"
	line "faded."
	prompt

BattleText_TheSandstormSubsided:
	ctxt "The sandstorm"
	line "subsided."
	prompt

BattleText_TheHailStopped:
	ctxt "The hail stopped."
	prompt

BattleText_EnemyPkmnFainted:
	ctxt "The foe "
	text_ram wEnemyMonNickname
	ctxt ""
	line "fainted!"
	prompt

GotMoneyForWinningText:
	text "<PLAYER> got ¥"
	text_decimal wBattleReward, 3, 6
	ctxt ""
	line "for winning!"
	prompt

BattleText_EnemyWasDefeated:
	ctxt "<ENEMY>"
	line "was defeated!"
	prompt

BattleText_EnemyWereDefeated:
	ctxt "<ENEMY>"
	line "were defeated!"
	prompt

TiedAgainstText:
	ctxt "Tied against"
	line "<ENEMY>!"
	prompt

SentSomeToMomText:
	text "<PLAYER> got ¥"
	text_decimal wBattleReward, 3, 6
	ctxt ""
	line "for winning!"
	cont "Sent some to Mom!"
	prompt

SentHalfToMomText:
	ctxt "Sent half to Mom!"
	prompt

SentAllToMomText:
	ctxt "Sent all to Mom!"
	prompt

BattleText_PkmnFainted:
	text_ram wBattleMonNickname
	ctxt ""
	line "fainted!"
	prompt

BattleText_UseNextMon:
	ctxt "Use next #mon?"
	done

LostAgainstText:
	ctxt "Lost against"
	line "<ENEMY>!"
	prompt

BattleText_EnemyIsAboutToUseWillPlayerSwitchPkmn:
	ctxt "<ENEMY>"
	line "is about to use"
	cont ""
	text_ram wEnemyMonNickname
	ctxt "."

	para "Will you switch"
	line "your #mon?"
	done

BattleText_EnemyAreAboutToUseWillPlayerSwitchPkmn:
	ctxt "<ENEMY>"
	line "are about to use"
	cont ""
	text_ram wEnemyMonNickname
	ctxt "."

	para "Will you switch"
	line "your #mon?"
	done

BattleText_EnemyIsAboutToSwitchWillPlayerSwitchPkmn:
	ctxt "<ENEMY>"
	line "is about to switch"
	cont "#mon."

	para "Will you switch"
	line "your #mon?"
	done

BattleText_EnemyAreAboutToSwitchWillPlayerSwitchPkmn:
	ctxt "<ENEMY>"
	line "are about to"
	cont "switch #mon."

	para "Will you switch"
	line "your #mon?"
	done

BattleText_EnemySentOut:
	ctxt "<ENEMY>"
	line "sent out"
	cont ""
	text_ram wEnemyMonNickname
	text "!"
	done

BattleText_TheresNoWillToBattle:
	ctxt "There's no will to"
	line "battle!"
	prompt

BattleText_AnEGGCantBattle:
	ctxt "An Egg can't"
	line "battle!"
	prompt

BattleText_CantEscape:
	ctxt "Can't escape!"
	prompt

BattleText_AskForfeitTrainerBattle:
	ctxt "Are you sure you"
	line "want to forfeit?"
	done

BattleText_GotAwaySafely:
	ctxt "Got away safely!"
	prompt

BattleText_UserFledUsingAStringBuffer1:
	ctxt "<USER>"
	line "fled using a"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

BattleText_UserHurtBySpikes:
	ctxt "<USER> is"
	line "hurt by spikes!"
	prompt

RecoveredUsingText:
	ctxt "<USER>"
	line "recovered using a"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

AirBalloonPoppedText:
	ctxt "<TARGET>'s"
	line "Air Balloon"
	cont "popped!"
	prompt

BattleText_UsersStringBuffer1Activated:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer1
	ctxt ""
	cont "activated!"
	prompt

BattleText_ItemsCantBeUsedHere:
	ctxt "Items can't be"
	line "used here."
	prompt

BattleText_PkmnIsAlreadyOut:
	text_ram wBattleMonNickname
	ctxt ""
	line "is already out."
	prompt

BattleText_PkmnCantBeRecalled:
	text_ram wBattleMonNickname
	ctxt ""
	line "can't be recalled!"
	prompt

BattleText_PkmnCantBeRecalledAbility:
	text_ram wEnemyMonNickname
	text "'s"
	line ""
	text_ram wStringBuffer1
	ctxt ""
	cont "prevents escape!"
	prompt

BattleText_TheresNoPPLeftForThisMove:
	ctxt "There's no PP left"
	line "for this move!"
	prompt

BattleText_ItemOnlyAllowsMove: ; choice items
	text "The "
	text_ram wStringBuffer1
	ctxt ""
	line "only allows use"
	cont "of "
	text_ram wStringBuffer2
	text "!"
	prompt

BattleText_MonCanOnlyUseMove:
	ctxt "<USER> can"
	line "only use"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

BattleText_ItemPreventsStatusMoves: ; assault vest
	text "The "
	text_ram wStringBuffer1
	ctxt ""
	line "prevents usage"
	cont "of status moves!"
	prompt

BattleText_TheMoveIsDisabled:
	ctxt "The move is"
	line "disabled!"
	prompt

BattleText_PkmnHasNoMovesLeft:
	text_ram wBattleMonNickname
	ctxt ""
	line "has no moves left!"
	done

BattleText_UserEncoreEnded:
	ctxt "<USER>'s"
	line "encore ended!"
	prompt

BattleText_StringBuffer1GrewToLevel:
	text_ram wStringBuffer1
	ctxt " grew to"
	line "level "
	text_decimal wCurPartyLevel, 1, 3
	text "!"
	text_sound SFX_DEX_FANFARE_50_79
	text_end

BattleText_WildPkmnIsEating:
	text "Wild "
	text_ram wEnemyMonNickname
	ctxt ""
	line "is eating!"
	prompt

BattleText_WildPkmnIsAngry:
	text "Wild "
	text_ram wEnemyMonNickname
	ctxt ""
	line "is angry!"
	prompt

BattleText_ThrewRock:
	ctxt "<PLAYER> threw a"
	line "rock."
	prompt

BattleText_ThrewBait:
	ctxt "<PLAYER> threw"
	line "some bait."
	prompt

FastAsleepText:
	ctxt "<USER>"
	line "is fast asleep!"
	prompt

WokeUpText:
	ctxt "<USER>"
	line "woke up!"
	prompt

FrozenSolidText:
	ctxt "<USER>"
	line "is frozen solid!"
	prompt

FlinchedText:
	ctxt "<USER>"
	line "flinched!"
	prompt

MustRechargeText:
	ctxt "<USER>"
	line "must recharge!"
	prompt

DisabledNoMoreText:
	ctxt "<USER> is"
	line "disabled no more!"
	prompt

IsConfusedText:
	ctxt "<USER>"
	line "is confused!"
	prompt

HurtItselfText:
	ctxt "It hurt itself in"
	line "its confusion!"
	prompt

ConfusedNoMoreText:
	ctxt "<USER> is"
	line "confused no more!"
	prompt

BecameConfusedText:
	ctxt "<TARGET>"
	line "became confused!"
	prompt

BecameConfusedDueToFatigueText:
	ctxt "<TARGET>"
	line "became confused"
	cont "due to fatigue!"
	prompt

BattleText_ItemHealedConfusion: ; ItemHealedConfusion
	text "A "
	text_ram wStringBuffer1
	ctxt " rid"
	line "<USER>"
	cont "of its confusion."
	prompt

AlreadyConfusedText:
	ctxt "<TARGET> is"
	line "already confused!"
	prompt

BattleText_UsersHurtByStringBuffer1:
	ctxt "<USER> is"
	line "hurt by"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

BattleText_UserWasReleasedFromStringBuffer1:
	ctxt "<USER>"
	line "was released from"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

WhirlpoolTrapText:
	ctxt "<TARGET>"
	line "was trapped!"
	prompt

FireSpinTrapText:
	ctxt "<TARGET>"
	line "was trapped!"
	prompt

WrappedByText:
	ctxt "<TARGET>"
	line "was wrapped by"
	cont "<USER>!"
	prompt

HungOnText:
	ctxt "<TARGET>"
	line "hung on with"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

EnduredText:
	ctxt "<TARGET>"
	line "endured the hit!"
	prompt

InLoveWithText:
	ctxt "<USER>"
	line "is in love with"
	cont "<TARGET>!"
	prompt

InfatuationText:
	ctxt "<USER>'s"
	line "infatuation kept"
	cont "it from attacking!"
	prompt

NoLongerInfatuatedText:
	ctxt "<USER>'s"
	line "no longer"
	cont "infatuated!"
	prompt

ObliviousPreventedDestinyKnot:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer1
	ctxt ""
	cont "prevents"
	cont ""
	text_ram wStringBuffer2
	ctxt ""
	cont "infatuating it!"
	prompt

DestinyKnotInfatuatedUser:
	text "<TARGET>'s"
	line ""
	text_ram wStringBuffer1
	ctxt ""
	cont "infatuated"

	para "<USER>!"
	prompt

DisabledMoveText:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer1
	ctxt " is"
	cont "disabled!"
	prompt

UsedMoveText:
	text "<USER>"
	line "used "
	text_ram wStringBuffer2
	text "!"
	done

UsedMoveInsteadText:
	text "<USER>"
	line "used "
	text_ram wStringBuffer2
	ctxt ""
	cont "instead!"
	done

LoafingAroundText:
	text_ram wBattleMonNickname
	ctxt " is"
	line "loafing around."
	prompt

BeganToNapText:
	text_ram wBattleMonNickname
	ctxt " began"
	line "to nap!"
	prompt

WontObeyText:
	text_ram wBattleMonNickname
	ctxt " won't"
	line "obey!"
	prompt

TurnedAwayText:
	text_ram wBattleMonNickname
	ctxt " turned"
	line "away!"
	prompt

IgnoredOrdersText:
	text_ram wBattleMonNickname
	ctxt " ignored"
	line "orders!"
	prompt

IgnoredSleepingText:
	text_ram wBattleMonNickname
	ctxt " ignored"
	line "orders…sleeping!"
	prompt

NoPPLeftText:
	ctxt "But no PP is left"
	line "for the move!"
	prompt

HasNoPPLeftText:
	ctxt "<USER>"
	line "has no PP left for"
	cont ""
	text_ram wStringBuffer2
	text "!"
	prompt

WentToSleepText:
	ctxt "<USER>"
	line "went to sleep!"
	done

RestedText:
	ctxt "<USER>"
	line "fell asleep and"
	cont "became healthy!"
	done

RegainedHealthText:
	ctxt "<USER>"
	line "regained health!"
	prompt

IsHurtText:
	ctxt "<USER>"
	line "is hurt!"
	prompt

AttackMissedText:
	ctxt "<USER>'s"
	line "attack missed!"
	prompt

CrashedText:
	ctxt "<USER>"
	line "kept going and"
	cont "crashed!"
	prompt

UnaffectedText:
	ctxt "<TARGET> is"
	line "unaffected!"
	prompt

DoesntAffectText:
	ctxt "It doesn't affect"
	line "<TARGET>!"
	prompt

CriticalHitText:
	ctxt "A critical hit!"
	prompt

SuperEffectiveText:
	ctxt "It's super"
	line "effective!"
	prompt

NotVeryEffectiveText:
	ctxt "It's not very"
	line "effective…"
	prompt

TookDownWithItText:
	ctxt "<TARGET>"
	line "took <USER>"
	cont "down with it!"
	prompt

RageBuildingText:
	ctxt "<USER>'s"
	line "rage is building!"
	prompt

GotAnEncoreText:
	ctxt "<TARGET>"
	line "got an encore!"
	prompt

SharedPainText:
	ctxt "The battlers"
	line "shared pain!"
	prompt

SwappedAbilitiesText:
	ctxt "The battlers"
	line "swapped abilities!"
	prompt

SwappedItemsText:
	ctxt "The battlers"
	line "swapped items!"
	prompt

ChangeIntoTypeText:
	ctxt "Change into what"
	line "move's type?"
	prompt

InvalidTypeChangeText:
	ctxt "You can't choose"
	line "that move's type!"
	prompt

SketchedText:
	ctxt "<USER>"
	line "sketched"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

DestinyBondEffectText:
	ctxt "<USER> is"
	line "trying to take its"
	cont "opponent with it!"
	prompt

BellChimedText:
	ctxt "A bell chimed!"
	line ""
	prompt

FellAsleepText:
	ctxt "<TARGET>"
	line "fell asleep!"
	prompt

AlreadyAsleepText:
	ctxt "<TARGET> is"
	line "already asleep!"
	prompt

WasPoisonedText:
	ctxt "<TARGET>"
	line "was poisoned!"
	prompt

BadlyPoisonedText:
	ctxt "<TARGET> is"
	line "badly poisoned!"
	prompt

AlreadyPoisonedText:
	ctxt "<TARGET> is"
	line "already poisoned!"
	prompt

SuckedHealthText:
	ctxt "Sucked health from"
	line "<TARGET>!"
	prompt

DreamEatenText:
	ctxt "<TARGET>'s"
	line "dream was eaten!"
	prompt

WasBurnedText:
	ctxt "<TARGET>"
	line "was burned!"
	prompt

DefrostedOpponentText:
	ctxt "<TARGET>"
	line "was defrosted!"
	prompt

AlreadyBurnedText:
	ctxt "<TARGET> is"
	line "already burned!"
	prompt

WasFrozenText:
	ctxt "<TARGET>"
	line "was frozen solid!"
	prompt

WontRiseAnymoreText:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	ctxt " won't go"
	cont "any higher!"
	prompt

WontDropAnymoreText:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	ctxt " won't go"
	cont "any lower!"
	prompt

StatRoseText:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	ctxt " rose!"
	prompt

StatRoseSharplyText:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	ctxt " rose"
	cont "sharply!"
	prompt

StatRoseDrasticallyText:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	ctxt " rose"
	cont "drastically!"
	prompt

StatFellText:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	ctxt " fell!"
	prompt

StatHarshlyFellText:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	ctxt " harshly"
	cont "fell!"
	prompt

StatSeverelyFellText:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	ctxt " severely"
	cont "fell!"
	prompt

FledFromBattleText::
	ctxt "<USER>"
	line "fled from battle!"
	prompt

FledInFearText:
	ctxt "<TARGET>"
	line "fled in fear!"
	prompt

Hit1TimeText:
	text "Hit "
	text_decimal wStringBuffer1, 1, 1
	ctxt " time!"
	prompt

HitNTimesText:
	text "Hit "
	text_decimal wStringBuffer1, 1, 1
	ctxt " times!"
	prompt

MistText:
	ctxt "<USER>'s"
	line "shrouded in mist!"
	prompt

ProtectedByMistText:
	ctxt "<TARGET> is"
	line "protected by mist."
	prompt

GettingPumpedText:
	text_pause
	ctxt "<USER> is"
	line "getting pumped!"
	prompt

RecoilText:
	ctxt "<USER> is"
	line "hit with recoil!"
	prompt

MadeSubstituteText:
	ctxt "<USER>"
	line "made a substitute!"
	prompt

HasSubstituteText:
	ctxt "<USER>"
	line "has a substitute!"
	prompt

TooWeakSubText:
	ctxt "Too weak to make"
	line "a substitute!"
	prompt

SubTookDamageText:
	ctxt "The substitute"
	line "took damage for"
	cont "<TARGET>!"
	prompt

SubFadedText:
	ctxt "<TARGET>'s"
	line "substitute faded!"
	prompt

WasSeededText:
	ctxt "<TARGET>"
	line "was seeded!"
	prompt

EvadedText:
	ctxt "<TARGET>"
	line "evaded the attack!"
	prompt

WasDisabledText:
	text "<TARGET>'s"
	line ""
	text_ram wStringBuffer2
	ctxt " was"
	cont "disabled!"
	prompt

CoinsScatteredText:
	ctxt "Coins scattered"
	line "everywhere!"
	prompt

TransformedTypeText:
	ctxt "<USER>"
	line "became the"
	cont ""
	text_ram wStringBuffer1
	ctxt "-type!"
	prompt

EliminatedStatsText:
	ctxt "All stat changes"
	line "were eliminated!"
	prompt

TransformedText:
	ctxt "<USER>"
	line "transformed into"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

TrickRoomText:
	ctxt "<USER>"
	line "twisted the"
	cont "dimensions!"
	prompt

TrickRoomEndedText:
	ctxt "The twisted"
	line "dimensions"

	para "returned to"
	line "normal!"
	prompt

LightScreenEffectText:
	ctxt "<USER>'s"
	line "Spcl.Def rose!"
	prompt

ReflectEffectText:
	ctxt "<USER>'s"
	line "Defense rose!"
	prompt

NothingHappenedText:
	ctxt "But nothing"
	line "happened."
	prompt

ButItFailedText:
	ctxt "But it failed!"
	prompt

ItFailedText:
	ctxt "It failed!"
	prompt

DidntAffectText:
	ctxt "It didn't affect"
	line "<TARGET>!"
	prompt

HPIsFullText:
	ctxt "<USER>'s"
	line "HP is full!"
	prompt

DraggedOutText:
	ctxt "<USER>"
	line "was dragged out!"
	prompt

ParalyzedText:
	ctxt "<TARGET> is"
	line "paralyzed! It"
	cont "might not attack!"
	prompt

FullyParalyzedText:
	ctxt "<USER> is"
	line "fully paralyzed!"
	prompt

AlreadyParalyzedText:
	ctxt "<TARGET> is"
	line "already paralyzed!"
	prompt

ProtectedByText:
	ctxt "<TARGET> is"
	line "protected by"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

RegainedStatsWithItem:
	ctxt "<USER>"
	line "regained stats"
	cont "with "
	text_ram wStringBuffer1
	text "!"
	prompt

CuredInfatuationWithItem:
	ctxt "<USER>"
	line "cured infatuation"
	cont "with "
	text_ram wStringBuffer1
	text "!"
	prompt

CuredEncoreWithItem:
	ctxt "<USER>"
	line "cured Encore"
	cont "with "
	text_ram wStringBuffer1
	text "!"
	prompt

CuredDisableWithItem:
	ctxt "<USER>"
	line "cured Disable"
	cont "with "
	text_ram wStringBuffer1
	text "!"
	prompt

StoleText:
	ctxt "<USER>"
	line "stole "
	text_ram wStringBuffer1
	ctxt ""
	cont "from its foe!"
	prompt

KnockedOffItemText:
	ctxt "<USER>"
	line "knocked off"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

CantEscapeNowText:
	ctxt "<TARGET>"
	line "can't escape now!"
	prompt

WasDefrostedText:
	ctxt "<USER>"
	line "was defrosted!"
	prompt

PutACurseText:
	ctxt "<USER>"
	line "cut its own HP and"

	para "put a curse on"
	line "<TARGET>!"
	prompt

ProtectedItselfText:
	ctxt "<USER>"
	line "protected itself!"
	prompt

ProtectingItselfText:
	ctxt "<TARGET> is"
	line "protecting itself!"
	done

SpikesText:
	ctxt "Spikes scattered"
	line "all around"
	cont "<TARGET>!"
	prompt

ToxicSpikesText:
	ctxt "Toxic spikes"
	line "scattered around"
	cont "<TARGET>!"
	prompt

IdentifiedText:
	ctxt "<USER>"
	line "identified"
	cont "<TARGET>!"
	prompt

StartPerishSongText:
	ctxt "#mon that heard"
	line "the song will"
	cont "faint in 3 turns!"
	prompt

StartPerishBodyText:
	ctxt "Both #mon will"
	line "faint in 3 turns!"
	prompt

SandstormBrewedText:
	ctxt "A sandstorm"
	line "brewed!"
	prompt

HailStartedText:
	ctxt "It started to"
	line "hail!"
	prompt

BracedItselfText:
	ctxt "<USER>"
	line "braced itself!"
	prompt

FellInLoveText:
	ctxt "<TARGET>"
	line "fell in love!"
	prompt

CoveredByVeilText:
	ctxt "<USER> is"
	line "covered by a veil!"
	prompt

SafeguardProtectText:
	ctxt "<TARGET>"
	line "is protected by"
	cont "Safeguard!"
	prompt

MagnitudeText:
	ctxt "Magnitude "
	text_decimal wTextDecimalByte, 1, 2
	text "!"
	prompt

ReleasedByText:
	ctxt "<USER>"
	line "was released by"
	cont "<TARGET>!"
	prompt

ShedLeechSeedText:
	ctxt "<USER>"
	line "shed Leech Seed!"
	prompt

BlewSpikesText:
	ctxt "<USER>"
	line "blew away Spikes!"
	prompt

BlewToxicSpikesText:
	ctxt "<USER>"
	line "blew away Toxic"
	cont "Spikes!"
	prompt

DownpourText:
	ctxt "It started"
	line "to rain!"
	prompt

SunGotBrightText:
	ctxt "The sunlight"
	line "turned harsh!"
	prompt

BellyDrumText:
	ctxt "<USER>"
	line "cut its HP and"
	cont "maximized Attack!"
	prompt

BellyDrumContraryText:
	ctxt "<USER>"
	line "cut its HP and"
	cont "minimized Attack!"
	prompt

ForesawAttackText:
	ctxt "<USER>"
	line "foresaw an attack!"
	prompt

IgnoredOrders2Text:
	ctxt "<USER>"
	line "ignored orders!"
	prompt

BecameHealthyText:
	ctxt "<USER>"
	line "became healthy!"
	prompt

NotifyAirBalloonText:
	ctxt "<USER>"
	line "floats in the air"
	cont "with "
	text_ram wStringBuffer1
	text "!"
	prompt

TraceActivationText:
	ctxt "<USER>"
	line "traced"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

TraceFailureText:
	ctxt "<USER>"
	line "failed to trace"
	cont "<TARGET>!"
	prompt

BattleText_IntimidateResisted:
	text "<TARGET>'s"
	line ""
	text_ram wStringBuffer1
	ctxt ""

	para "protects it from"
	line "Intimidate!"
	prompt

NotifyCloudNine:
	ctxt "The weather was"
	line "suppressed!"
	prompt

NotifyPressure:
	ctxt "<USER> is"
	line "exerting its"
	cont "pressure!"
	prompt

NotifyMoldBreaker:
	ctxt "<USER>"
	line "breaks the mold!"
	prompt

NotifyUnnerve:
	ctxt "<TARGET> is"
	line "too afraid to eat"
	cont "Berries!"
	prompt

NotifyNeutralizingGas:
	ctxt "Neutralizing gas"
	line "filled the area!"
	prompt

FriskedItemText:
	ctxt "<USER>"
	line "frisked its foe"

	para "and found a"
	line ""
	text_ram wStringBuffer1
	text "!"
	prompt

PickedItemText:
	ctxt "<USER>"
	line "picked up"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

HarvestedItemText:
	ctxt "<USER>"
	line "harvested"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

FirePoweredUpText:
	ctxt "<USER>'s"
	line "Fire-type moves"
	cont "were powered up!"
	prompt

AngerPointMaximizedAttackText:
	ctxt "<USER>"
	line "maxed its Attack!"
	prompt

CannotUseText:
	ctxt "<TARGET>"
	line "cannot use"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

ShudderedText:
; since the ability works with the opponent move data,
; it is on the opponent turn mostly
	ctxt "<TARGET>"
	line "shuddered!"
	prompt

ForewarnText:
	text "<TARGET>"
	line "has "
	text_ram wStringBuffer1
	text "!"
	prompt

BouncedBackText:
	ctxt "<USER>"
	line "bounced the"
	cont ""
	text_ram wStringBuffer1
	ctxt " back!"
	prompt

ItemCantBeStolenText:
	ctxt "<TARGET>'s"
	line "item cannot be"
	cont "stolen!"
	prompt

SuckedUpOozeText:
	ctxt "<USER>"
	line "sucked up the"
	cont "liquid ooze!"
	prompt

BattleText_EnemyWithdrew::
	ctxt "<ENEMY>"
	line "withdrew"
	cont ""
	text_ram wEnemyMonNickname
	text "!"
	prompt

BattleText_WentBackToPlayer:
	ctxt "<USER> went"
	line "back to <PLAYER>!"
	prompt

BattleText_WentBackToEnemy:
	ctxt "<USER>"
	line "went back to"
	cont "<ENEMY>!"
	prompt

ScaredText:
	ctxt "<USER> is too"
	line "scared to move!"
	prompt

GetOutText:
	ctxt "Ghost: Get out…"
	line "Get out…"
	prompt

CarrieFinalPkmnText:
CalFinalPkmnText:
	ctxt "I still have one"
	line "#mon!"
	prompt

FalknerFinalPkmnText:
	ctxt "The wind is"
	line "finally with us!"
	prompt

BugsyFinalPkmnText:
	ctxt "Even though it's"
	line "my last #mon,"

	para "Bug #mon are"
	line "tough!"
	prompt

WhitneyFinalPkmnText:
	ctxt "H-hey! Just one"
	line "left? But…"

	para "I ain't losin',"
	line "you hear?"
	prompt

MortyFinalPkmnText:
	ctxt "I still believe"
	line "we can do it!"
	prompt

ChuckFinalPkmnText:
	ctxt "We haven't lost"
	line "yet!"
	prompt

JasmineFinalPkmnText:
	ctxt "Well-tempered"
	line "steel will hang on"
	cont "to the very last!"
	prompt

PryceFinalPkmnText:
	ctxt "Humph… You are"
	line "quite the Trainer."
	prompt

ClairFinalPkmnText:
	ctxt "One last #mon?"
	line "This is where the"
	cont "real fight begins!"
	prompt

WillFinalPkmnText:
	ctxt "We Psychics don't"
	line "give up until we"
	cont "reach zero!"
	prompt

KogaFinalPkmnText:
	ctxt "Fwahaha! I've been"
	line "counting on this"

	para "one from the very"
	line "beginning!"
	prompt

BrunoFinalPkmnText:
	ctxt "Fight as hard as"
	line "you can 'til you"
	cont "faint!"
	prompt

KarenFinalPkmnText:
	ctxt "This is far from"
	line "being backed into"
	cont "a corner!"
	prompt

ChampionFinalPkmnText:
	ctxt "All right! I"
	line "thought this would"
	cont "never happen!"
	prompt

BrockFinalPkmnText:
	ctxt "Ah ha ha!"
	line "It itches!"
	prompt

MistyFinalPkmnText:
	ctxt "Hmm… You're"
	line "pretty good…"
	prompt

LtSurgeFinalPkmnText:
	ctxt "It's not over yet."
	line "It's just getting"
	cont "started!"
	prompt

ErikaFinalPkmnText:
	ctxt "Don't go easy on"
	line "me. Give me every-"
	cont "thing you've got!"
	prompt

JanineFinalPkmnText:
	ctxt "You've got a great"
	line "battle technique!"
	prompt

SabrinaFinalPkmnText:
	ctxt "What will happen"
	line "after this?"
	cont "I already know."
	prompt

BlaineFinalPkmnText:
	ctxt "I'll show you the"
	line "spirit of my cave"
	cont "Gym!"
	prompt

BlueFinalPkmnText:
	ctxt "Heh heh heh…"
	line "You're unprepared"

	para "for this. We'll"
	line "knock you down!"
	prompt

RedFinalPkmnText: ; ctxt > text
LeafFinalPkmnText:
	text "………………"
	prompt

Rival1_1FinalPkmnText:
	ctxt "…Humph!"
	line "You're doing OK"
	cont "for someone weak."
	prompt

Rival1_2FinalPkmnText:
	ctxt "Say, you've got a"
	line "lot of nerve,"
	cont "coming here…"
	prompt

Rival1_3FinalPkmnText:
	ctxt "Out of despera-"
	line "tion, weak people"

	para "sometimes do OK"
	line "at fighting back."
	prompt

Rival1_4FinalPkmnText:
	ctxt "Hey, hey!"
	line "Why so serious?"
	prompt

Rival1_5FinalPkmnText:
	ctxt "I see. Seems like"
	line "it wasn't just luck"

	para "that's gotten you"
	line "this far."
	prompt

Rival2_1FinalPkmnText:
	ctxt "I see. You weren't"
	line "coming to Kanto"
	cont "just to show off…"
	prompt

Rival2_2FinalPkmnText:
	ctxt "Why?! I've still"
	line "got one left!"
	prompt

Lyra1_1FinalPkmnText:
	ctxt "You've never had a"
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
	ctxt "You're learning"
	line "quickly, <PLAYER>!"
	prompt

Lyra1_3FinalPkmnText:
	ctxt "OK! Time for my"
	line "last #mon!"
	prompt

Lyra1_4FinalPkmnText:
	ctxt "Whether I win or"
	line "lose, this has"
	cont "been fun!"
	prompt

Lyra2_1FinalPkmnText:
	ctxt "You've brought me"
	line "down to my last"
	cont "#mon…"
	prompt

Proton1FinalPkmnText:
	ctxt "Seriously, you'd"
	line "chase me this far?"
	prompt

Proton2FinalPkmnText:
	ctxt "Everywhere we go,"
	line "someone always"
	cont "disagrees with us…"
	prompt

Petrel1FinalPkmnText:
	ctxt "What? Am I"
	line "losing?"
	prompt

Petrel2FinalPkmnText:
	ctxt "Hey, you're good!"
	prompt

Archer1FinalPkmnText:
	ctxt "We can't have you"
	line "getting in the way"

	para "before Giovanni"
	line "rejoins us!"
	prompt

Archer2FinalPkmnText:
	ctxt "Ah, you are indeed"
	line "strong, but…"
	cont "I wonder…"
	prompt

Ariana1FinalPkmnText:
	ctxt "Wh… Wha… Why are"
	line "you so strong?!"
	prompt

Ariana2FinalPkmnText:
	ctxt "Hey, what do you"
	line "think you're"
	cont "doing?!"
	prompt

Giovanni1FinalPkmnText:
	ctxt "My #mon is"
	line "invincible!"
	prompt

Giovanni2FinalPkmnText:
	ctxt "Don't tell me some"
	line "inexperienced kid"

	para "can possibly be"
	line "that strong!"
	prompt

ProfOakFinalPkmnText:
	ctxt "Hm! Excellent!"
	line "But we aren't"
	cont "done yet!"
	prompt

ProfElmFinalPkmnText:
	ctxt "It's almost"
	line "over…"
	prompt

ProfIvyFinalPkmnText:
	ctxt "I'm down, but"
	line "not out!"
	prompt

MysticalManFinalPkmnText:
	ctxt "Time for a dra-"
	line "matic comeback!"
	prompt

KarateKingFinalPkmnText:
	ctxt "Yaaarggh!"
	prompt

PalmerFinalPkmnText:
	ctxt "Bravo!"
	prompt

JessieJamesFinalPkmnText:
	ctxt "We have a proud"
	line "tradition of fail-"
	cont "ure to uphold!"
	prompt

LoreleiFinalPkmnText:
	ctxt "You only got a"
	line "taste of my power!"
	prompt

AgathaFinalPkmnText:
	ctxt "Don't assume that"
	line "you've won, child!"
	prompt

StevenFinalPkmnText:
	ctxt "I knew you would"
	line "be strong…"
	prompt

CynthiaFinalPkmnText:
	ctxt "I won't let this"
	line "end yet!"
	prompt

InverFinalPkmnText:
	ctxt "You're getting the"
	line "hang of this!"
	prompt

CherylFinalPkmnText:
	ctxt "I can't keep up"
	line "with healing…"
	prompt

RileyFinalPkmnText:
	ctxt "Your team! I sense"
	line "your strong aura!"
	prompt

BuckFinalPkmnText:
	ctxt "Now this! This is"
	line "a smoking-hot sit-"
	cont "uation!"
	prompt

MarleyFinalPkmnText:
	ctxt "…My time with you"
	line "is drawing to a"
	cont "close."
	prompt

MiraFinalPkmnText:
	ctxt "Oh, no! You're"
	line "too much for me!"
	prompt

AnabelFinalPkmnText:
	ctxt "Your talent…"
	line "It's real."
	prompt

DarachFinalPkmnText:
	ctxt "My last stand!"
	line "Allez!"
	prompt

CaitlinFinalPkmnText:
	ctxt "Even at this time,"
	line "I should stay cool"
	cont "and collected…"
	prompt

CandelaFinalPkmnText:
	ctxt "Down to the wire!"
	line "How exciting!"
	prompt

BlancheFinalPkmnText:
	ctxt "I am certainly"
	line "impressed so far."
	prompt

SparkFinalPkmnText:
	ctxt "You're good!"
	line "No doubt about it!"
	prompt

FlanneryFinalPkmnText:
	ctxt "Um… what should"
	line "I do now?"
	prompt

MayleneFinalPkmnText:
	ctxt "This isn't the"
	line "end, my friend!"
	prompt

SkylaFinalPkmnText:
	ctxt "This is my last"
	line "#mon…"

	para "But I'll never"
	line "give up hope!"
	prompt

ValerieFinalPkmnText:
	ctxt "Oh my…"
	prompt

KukuiFinalPkmnText:
	ctxt "My soul burns hot,"
	line "yeah!"
	prompt

BillFinalPkmnText:
	ctxt "Yeehah!"
	line "What a battle!"
	prompt

YellowFinalPkmnText:
	ctxt "My last #mon…"
	line "Lend me your"
	cont "power!"
	prompt

WalkerFinalPkmnText:
	ctxt "We can still fly!"
	prompt

ImakuniFinalPkmnText:
	ctxt "I'm running away!"
	line "…I can't?"
	prompt

LawrenceFinalPkmnText:
	ctxt "Inconceivable!"
	prompt

ReiFinalPkmnText:
	ctxt "I'm not done yet."
	prompt
