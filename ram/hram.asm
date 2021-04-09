SECTION "HRAM", HRAM

HRAM_START::

hPushOAM:: ds 5

hScriptVar:: db

hROMBankBackup:: db

; TODO: come up with other names for hBuffer
; related to home/audio.asm and home/decompress.asm
hTempBank::
hBuffer:: db
hLYOverrideStackCopyAmount:: db

hRTCDayHi::   db
hRTCDayLo::   db
hRTCHours::   db
hRTCMinutes:: db
hRTCSeconds:: db

hHours:: db
hMinutes:: db
hSeconds:: db

hVBlankCounter:: db

hVBlankOccurred:: db

hROMBank:: db
hVBlank:: db
hMapEntryMethod:: db
hMenuReturn:: db

hJoypadReleased:: db
hJoypadPressed::  db
hJoypadDown::     db
hJoypadSum::      db
hJoyReleased::    db
hJoyPressed::     db
hJoyDown::        db
hJoyLast::        db

hInMenu:: db

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

UNION
hFarCallSavedHL::
hFarCallSavedL:: db
hFarCallSavedH:: db
NEXTU
hLZAddress:: dw
ENDU

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
NEXTU
hChartValues::
hChartHP::  db
hChartAtk:: db
hChartDef:: db
hChartSpd:: db
hChartSat:: db
hChartSdf:: db
ENDU

hMoneyTemp:: ds 3

hLCDCPointer::     db
hLYOverrideStart:: db
hLYOverrideEnd::   db

hSerialReceivedNewData::     db
hSerialConnectionStatus::    db
hSerialIgnoringInitialData:: db
hSerialSend::                db
hSerialReceive::             db

hSCX:: db
hSCY:: db
hWX::  db
hWY::  db

hTilesPerCycle::
; 0 - no update
; 1 - vBGMap0 tiles
; 2 - vBGMap0 attributes
; 3 - vBGMap0 tiles
; 4 - vBGMap0 attributes
	db
hBGMapMode::
; 0 - top third
; 1 - middle third
; 2 - bottom third
	db
hBGMapHalf::     db
hBGMapAddress::  dw

hOAMUpdate:: db

hSPBuffer:: dw

hBGMapUpdate::    db
hBGMapTileCount:: db

hMapAnims::      db
hTileAnimFrame:: db

hLastTalked:: db

hRandom::
hRandomAdd:: db
hRandomSub:: db

hSecondsBackup:: db

UNION
; 0 - player
; 1 - opponent trainer
hBattleTurn:: db
hBattlePalFadeMode:: db
hTimeOfDayPalOffset:: db
NEXTU
hChartScreen:: db
hChartFillCoord:: db
hChartLineCoord:: db
ENDU

hCGBPalUpdate:: db
hCGB::          db

hDMATransfer:: db

hFarCallSavedA:: db

hDelayFrameLY:: db

hClockResetTrigger:: db

hMPState::  db
hMPBuffer:: db

hRequested2bpp::        db
hRequested1bpp::        db
hRequestedVTileDest::   dw
hRequestedVTileSource:: dw
hRequestOpaque1bpp::    db

UNION
hTmpd:: db
hTmpe:: db
	ds 1
NEXTU
hDX::  db
hDY::  db
hErr:: db
ENDU

hCrashCode:: db

	ds 8

hAppendVWFText:: ds 4

hLCDInterruptFunction::
hFunctionJump::     db ; $c3 jp
hFunctionTarget::
hFunctionTargetLo:: db ; LOW(target)
hFunctionTargetHi:: db ; HIGH(target)

hBitwiseOperation::
hBitwisePrefix:: db ; $cb prefix
hBitwiseOpcode:: db ; opcode
hBitwiseRet::    db ; $c9 ret

hSingleOperation::
hSingleOpcode:: db ; opcode
hSingleRet::    db ; $c9 ret

HRAM_END::
