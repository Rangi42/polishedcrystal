SECTION "HRAM", HRAM

hScriptVar:: dw

hROMBank:: db
hROMBankBackup:: db
	ds 1 ; unused

hHours:: db
hMinutes:: db
hSeconds:: db

hVBlank:: db
hVBlankCounter:: db
hVBlankOccurred:: db

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
hIsMapObject:: db ; 0 = object, 1 = mapobject
hMapObjectIndexBuffer:: db
hObjectStructIndexBuffer:: db
NEXTU
hMapBorderBlock:: db
hMapWidthPlus6:: db
hConnectionStripLength:: db
hConnectedMapWidth:: db
NEXTU
	ds 1
hMoveMon:: db
ENDU

hPrinter:: db

	ds 2 ; unused

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

UNION
hMathBuffer:: ds 5

NEXTU
; FacingPlayerDistance scratch space
hLineOfSightXLo:: db
hLineOfSightXHi:: db
hLineOfSightYLo:: db
hLineOfSightYHi:: db
hTrainerSeeing::  db
ENDU

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
hChartSpe:: db
hChartSat:: db
hChartSdf:: db
ENDU

hMoneyTemp:: ds 3

hLCDCPointer::     db
hLYOverrideStart:: db
hLYOverrideEnd::   db
hLYOverrideStackCopyAmount:: db

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

hBGMapUpdate::    db
hBGMapTileCount:: db

hOAMUpdate:: db

hMapAnims::      db
hTileAnimFrame:: db

hLastTalked:: db

hRandom::
hRandomAdd:: db
hRandomSub:: db

hSerialReceivedNewData::     db
hSerialConnectionStatus::    db
	vc_assert hSerialConnectionStatus == $ffcb, \
		"hSerialConnectionStatus is no longer located at 00:ffcb."
hSerialIgnoringInitialData:: db
hSerialSend::                db
hSerialReceive::             db

hSPBuffer:: dw

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
NEXTU
hPokedexAreaMode:: ; %xyyyzzzz, x: area unknown, y: region, z: location type
hPokedexStatsCurAbil:: db
hPokedexROMBankBackup:: db
	ds 1
ENDU

hCGBPalUpdate:: db
hCGB::          db

hDMATransfer:: db

hDelayFrameLY:: db

hClockResetTrigger:: db

	ds 2

hRequested2bpp::        db
hRequested1bpp::        db
hRequestedVTileDest::   dw
hRequestedVTileSource:: dw
hRequestOpaque1bpp::    db

UNION
; PrintMagikarpLength
hTmpd:: db
hTmpe:: db
	ds 1
NEXTU
; Judge Machine
hDX::  db
hDY::  db
hErr:: db
NEXTU
; Music Player
hMPState::  db
hNextMPState:: db
ENDU

hCrashCode:: db

hStopPrintingString:: db

UNION
; vwf
hAppendVWFText:: ds 4
NEXTU
; ctxt
hPlaceStringCoords:: dw
hCompressedTextBuffer:: ds 2 ; one character and "@"
ENDU

hScriptBank:: db
hScriptPos:: dw

hUsedWeatherSpriteIndex:: db
hUsedOAMIndex:: db

	ds 7 ; unused

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
