SECTION "HRAM", HRAM

HRAM_START::

hPushOAM:: ds 5

hScriptVar:: db

	ds 4

hROMBankBackup:: db
hBuffer:: db
hLYOverrideStackCopyAmount:: db

hRTCDayHi::   db
hRTCDayLo::   db
hRTCHours::   db
hRTCMinutes:: db
hRTCSeconds:: db

	ds 2

hHours:: db
	ds 1
hMinutes:: db
	ds 1
hSeconds:: db
	ds 1

	ds 1

hVBlankCounter:: db

	ds 1

hROMBank:: db
hVBlank:: db
hMapEntryMethod:: db
hMenuReturn:: db

	ds 1

hJoypadReleased:: db
hJoypadPressed::  db
hJoypadDown::     db
hJoypadSum::      db
hJoyReleased::    db
hJoyPressed::     db
hJoyDown::        db
hJoyLast::        db

hInMenu:: db

	ds 2

UNION
hGraphicStartTile:: db
hMoveMon:: db
hMapObjectIndexBuffer:: db
hObjectStructIndexBuffer:: db
NEXTU
hMapBorderBlock:: db
hMapWidthPlus6:: db
hConnectionStripLength:: db
hConnectedMapWidth:: db
ENDU

; can only use the bytes reserved for hPredefTemp in contained functions,
; unless you know what you're doing
hPredefTemp::
hLZAddress::
	dw

UNION
; math-related values

UNION
; inputs to Multiply
	ds 1
hMultiplicand:: ds 3
hMultiplier::   db
NEXTU
; result of Multiply
hProduct::      ds 4
NEXTU
; inputs to Divide
hDividend::     ds 4
hDivisor::      db
NEXTU
; results of Divide
	ds 1
hQuotient::     ds 3
hRemainder::    db
ENDU

hMathBuffer:: ds 5

NEXTU
; PrintNum scratch space
hPrintNum:: ds 5
ENDU

UNION
hUsedSpriteIndex:: db
hUsedSpriteTile::  db
	ds 4
NEXTU
hCurSpriteXCoord::   db
hCurSpriteYCoord::   db
hCurSpriteXPixel::   db
hCurSpriteYPixel::   db
hCurSpriteTile::     db
hCurSpriteOAMFlags:: db
ENDU

hMoneyTemp:: ds 3

hLCDCPointer::     db
hLYOverrideStart:: db
hLYOverrideEnd::   db

	ds 1

hSerialReceivedNewData::     db
hSerialConnectionStatus::    db
hSerialIgnoringInitialData:: db
hSerialSend::                db
hSerialReceive::             db

hSCX:: db
hSCY:: db
hWX::  db
hWY::  db

hTilesPerCycle:: db
; 0 - no update
; 1 - vBGMap0 tiles
; 2 - vBGMap0 attributes
; 3 - vBGMap0 tiles
; 4 - vBGMap0 attributes
hBGMapMode::     db
; 0 - top third
; 1 - middle third
; 2 - bottom third
hBGMapHalf::     db
hBGMapAddress::  dw

hOAMUpdate:: db

hSPBuffer:: dw

hBGMapUpdate::    db
hBGMapTileCount:: db

	ds 1

hMapAnims::      db
hTileAnimFrame:: db

hLastTalked:: db

hRandom::
hRandomAdd:: db
hRandomSub:: db

hSecondsBackup:: db

; 0 - player
; 1 - opponent trainer
hBattleTurn:: db

hCGBPalUpdate:: db
hCGB::          db

	ds 1

hDMATransfer:: db

hFarCallSavedA:: db

hDelayFrameLY:: db

hClockResetTrigger:: db

	ds 1

hMPState::  db
hMPBuffer:: db

	ds 2

hRequested2bpp::        db
hRequested1bpp::        db
hRequestedVTileDest::   dw
hRequestedVTileSource:: dw

hTmpd:: db
hBattlePalFadeMode::
hTmpe:: db

hRequestOpaque1bpp:: db

hTimeOfDayPalOffset:: db

	ds 4

HRAM_END::
