GetTrademonFrontpic:
	ld a, [wOTTrademonSpecies]
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	ld a, [wOTTrademonForm]
	ld [wCurForm], a
	call GetBaseData
	ld de, vTiles2
	predef_jump FrontpicPredef

AnimateTrademonFrontpic:
	ld a, [wOTTrademonSpecies]
	call IsAPokemon
	ret c
	farcall ShowOTTrademonStats
	ld a, [wOTTrademonSpecies]
	ld [wCurPartySpecies], a
	ld a, [wOTTrademonPersonality]
	ld [wTempMonPersonality], a
	ld a, [wOTTrademonPersonality + 1]
	ld [wTempMonPersonality + 1], a
	ld a, CGB_PLAYER_OR_MON_FRONTPIC_PALS
	call GetCGBLayout
	ld a, %11100100 ; 3,2,1,0
	call DmgToCgbBGPals
	farcall TradeAnim_ShowGetmonFrontpic
	ld a, [wOTTrademonSpecies]
	ld [wCurPartySpecies], a
	hlcoord 7, 2
	lb de, $0, ANIM_MON_TRADE
	predef_jump AnimateFrontpic
