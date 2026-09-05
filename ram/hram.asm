SECTION "HRAM", HRAM

hScriptVar:: dw

hROMBank:: db
hROMBankBackup:: db

hScriptBank:: db
hScriptPos:: dw

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
NEXTU
; PrintNum scratch space
hPrintNum:: ds 5
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

hBGMapCopyNRows:: ; How many rows the `_OFS` modes (in hBGMapMode) ought to copy
hNbRowsToCopy::   ; Temporary counter for `CopyTilemapInHBlank`
hNbTilesToCopy::  ; Temporary counter for the `gfx.asm` functions
	db
hBGMapMode::    db ; See `ram_constants.asm`
hBGMapHalf::    db ; Either 0 (top half), or 1 (bottom half)
hBGMapAddress:: dw

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

UNION
; 0 - player
; 1 - opponent trainer
hBattleTurn:: db
hBattlePalFadeMode:: db
hTimeOfDayPalOffset:: db
NEXTU
hChartScreen:: db ; $00 = EVs, $FF = IVs
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

hUsedWeatherSpriteIndex:: db
hUsedOAMIndex:: db


SECTION "HRAM tail", HRAM

hLCDInterruptFunction::
hLCDInterruptFunctionJump::     db ; $c3 jp
hLCDInterruptFunctionTarget::
hLCDInterruptFunctionTargetLo:: db ; LOW(target)
hLCDInterruptFunctionTargetHi:: db ; HIGH(target)

; functions used by Judge Machine

hBitwiseFunction:: ; also used by ObjectFlags1Step
hBitwiseFunctionPrefix:: db ; $cb prefix
hBitwiseFunctionOpcode:: db ; opcode
hBitwiseFunctionRet::    db ; $c9 ret

hSingleFunction::
hSingleFunctionOpcode:: db ; opcode
hSingleFunctionRet::    db ; $c9 ret

hJumpFunction::
hJumpFunctionJump::     db ; $c3 jp
hJumpFunctionTarget::
hJumpFunctionTargetLo:: db ; LOW(target)
hJumpFunctionTargetHi:: db ; HIGH(target)

; The variables above need to be within `jr` range of some code in early ROM0, so we place them
; at the very end of HRAM to help with that.
	align 16, $ffff
