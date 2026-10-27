; I have put a boatload of comments in this file so that its logic and rationale can be followed by
; others; I am not expecting all of them to stay within the final.
;
; (I am also not expecting all of my style to make it either.
;  I just hope that it can show a different way of doing things,
;  because I promise that I am not needlessly making things complicated.
;  Though part of that is that I'd rather have my assumptions checked at build time,
;  rather than needing to do very thorough play-testing and being paranoid
;  about whether I've missed some fringe edge case...)
;
; Still, enjoy the read! ^w^ ~ISSOtm


; FIXME: feels like those should be defined and used more globally... `map_object_constants.asm`?
;        They still make some magic numbers below disappear, so I've kept them.
def TILES_PER_CEL equ 4
def CELS_PER_OBJECT equ 3 ; Down, Up, Left/Right (shared, mirrored).


SECTION "Cable car asset blob", ROMX

CableCarAssets:
INCBIN "gfx/overworld/cable_car/cable_car.bin.lzp"
; Some of `cable_car.2bpp.lzp`'s dependency `.2bpp` files get `READFILE()`'d below,
; as part of length checks; they are ordered after this to be robust to dependency ordering / scanning.


;; Tunables.

def FADE_NB_STEPS equ 10 ; Number of frames to fade in, *and* then to fade out.
def FADE_LAG_FACTOR equ 2 ; Turns out the palette fader is SUPER CPU-heavy, and the raster effects make it lag a lot.
	def NB_FRAMES_FADES equ FADE_NB_STEPS * FADE_LAG_FACTOR
def NB_FRAMES_MAIN equ 600 ; Roughly the length of the music.

def TOPMOST_CABLE_Y_POS equ 10

def BLANKED_PLAYER_ROWS equ 6


; How much on-screen space the cliff should take.
def CLIFF_ROWS_TO_SHOW equ 70
	def CLIFF_BASE_SCANLINE equ SCREEN_HEIGHT * 8 - CLIFF_ROWS_TO_SHOW

def CLIFF_PATTERN_WIDTH equ 24
	def CLIFF_PATTERN_HEIGHT equ CLIFF_PATTERN_WIDTH / 2


; Each of the layers' speeds are defined individually, and thus they will accumulate imprecision
; at different rates and thus not be in perfect lockstep.
; This may actually be an aesthetic improvement, so we're sticking with that.
def SCROLL_SPEED_CLOUDS_NEAR  equ 0.2q8 ; px/frame, all of them.
def SCROLL_SPEED_CLOUDS_FAR_0 equ 0.05q8
def SCROLL_SPEED_CLOUDS_FAR_1 equ 0.014q8
def SCROLL_SPEED_HORIZON      equ 0.025q8
def SCROLL_SPEED_TREES_FAR_0  equ 0.3q8
def SCROLL_SPEED_TREES_FAR_1  equ 0.35q8
def SCROLL_SPEED_TREES_FAR_2  equ 0.4q8
def SCROLL_SPEED_TREES_FAR_3  equ 0.45q8
def SCROLL_SPEED_TREES_MED_0  equ 0.5q8
def SCROLL_SPEED_TREES_MED_1  equ 0.58q8
def SCROLL_SPEED_TREES_MED_2  equ 0.66q8
def SCROLL_SPEED_TREES_MED_3  equ 0.73q8
def SCROLL_SPEED_TREES_NEAR_0 equ 0.8q8
def SCROLL_SPEED_TREES_NEAR_1 equ 0.9q8
def SCROLL_SPEED_CLIFF        equ 1.1q8 ; X scroll speed only; the Y position is always half of the X pos.

def CUMULUS_X_SPEED equ 0.4q8 ; px/frame. No subpixels because lazy.
def CUMULUS_Y_POS equ 1

def CAR_X_SPEED equ SCROLL_SPEED_CLIFF

; Whenever the car's bump timer has all of these bits equal to 0, the car gets bumped up or down by 1 pixel.
def CAR_BUMP_TRIGGER_MASK equ $38
; If bit 6 is set, the car gets bumped up; otherwise, if bit 7 is reset, the car get bumped down.
; This gives the following sequence: UDU-UDU- etc.
def CAR_BUMP_TIMER_INCREMENT equ $01 ; By how much the bump timer gets increased each frame.

def PLAYER_MOVEMENT_RADIUS equ 4 ; Otherwise cels can clip out of the transparency.


SECTION "Cable Car", ROMX

Special_CableCar::
	; At this point, music is faded out and the screen is faded.
	ld e, MUSIC_CABLE_CAR_RSE
	call PlayMusic
	; Disable map anim processing, to save on a lot of VBlank time.
	; This command is always followed by some `warp*` script command,
	; which sets up a new map, and *that* runs `ActivateMapAnims`.
	xor a
	ldh [hMapAnims], a
; Init some cutscene vars.
	; a == 0.
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, SCREEN_WIDTH_PX - 1 + WX_OFS ; 1 pixel on-screen, used to skip rows near the top.
	ldh [hWX], a
	ld a, LCDC_ON | LCDC_WIN_9800 | LCDC_WIN_ON | LCDC_BG_9C00 | LCDC_OBJ_16 | LCDC_OBJ_ON | LCDC_PRIO_ON
	ldh [rLCDC], a


.LoadPlayerPalette
	ld a, BANK(wPlayerGender)
	ldh [rWBK], a
	ld a, [wPlayerGender]
	assert PLAYER_MALE   == PAL_OW_RED
	assert PLAYER_FEMALE == PAL_OW_BLUE
	assert PLAYER_ENBY   == PAL_OW_GREEN
	assert PLAYER_BETA   == PAL_OW_PURPLE
	farcall LookupOBPalette
	ld de, wOBPals1 palette OBPAL_PLAYER
	ld bc, 1 palettes
	rst FarCall
	dwb FarCopyColorWRAM, BANK(LookupOBPalette) ; Copy from that function's bank, since that's where the palettes are.

.LoadPlayerTiles
	farcall GetPlayerIcon ; This reads `wPlayerGender`, and expects its bank to be loaded.
	ld a, BANK(wDecompressScratch)
	ldh [rWBK], a
	; Shuffle each cel from row-first to column-first, for 8x16 OAM friendliness. (Grr.)
	; This "only" requires swapping tiles 1 and 2 of each cel, though!
	ld hl, wDecompressScratch tile -2
	ld b, PLAYER_NB_TILES / TILES_PER_CEL ; How many cels to process?
.shufflePlayerCel
	ld de, 3 tiles
	add hl, de
	; Make `de` point at the next tile. (This cannot overflow.)
	ld a, l
	add a, 1 tiles
	ld e, a
	ld d, h
.swapByte
	ld c, [hl] ; Read from tile 1...
	ld a, [de] ; Read from tile 2...
	ld [hli], a ; ...overwrite tile 1.
	ld a, c
	ld [de], a ; ...overwrite tile 2.
	inc e ; This won't overflow, since `wDecompressScratch` is ALIGN[8].
	bit 5, l ; Check if `hl` is now pointing into tile 2. (Again, alignment.)
	jr z, .swapByte
	dec b
	jr nz, .shufflePlayerCel
	; Blank out the bottom rows of the player's tiles, so they seem to be behind the car.
	ld hl, wDecompressScratch
	ld e, PLAYER_NB_TILES / 2
.blankOutTiles
	ld a, l
	add a, (16 - BLANKED_PLAYER_ROWS) * 2
	ld l, a
	xor a
	ld c, BLANKED_PLAYER_ROWS * 2 ; b == 0 right now.
	rst ByteFill
	dec e
	jr nz, .blankOutTiles
	; Done! Just need to commit this to VRAM :)
	ld de, wDecompressScratch
	ld hl, vTiles0 tile PLAYER_BASE_TILE
	ld c, PLAYER_NB_TILES
	call Request2bpp.Function ; Screen is on and the right banks are loaded: take a shortcut.


.LoadCutsceneAssets
	ld b, BANK(CableCarAssets)
	ld hl, CableCarAssets
	ld de, vTiles0 tile BASE_TILE
	ld c, NB_TILES
	assert NB_TILES + 2 * SCREEN_HEIGHT * 2 <= 256, "Too much stuff for the decompression buffer!"
	call DecompressRequest2bpp

.LoadCutscenePalettes
	ld hl, .palettes ; TODO: load a time-of-day palette
	ld de, wBGPals1
	ld bc, NB_PALETTES palettes
	call FarCopyColorWRAM


.WriteMainMaps
	; Since they are wider than the WRAM tilemaps, VRAM must be accessed directly;
	; there is enough room in the decompression buffer to hold them, too!
def MAP_SIZE_IN_TILES equ SCREEN_HEIGHT * TILEMAP_WIDTH / TILE_SIZE
	ld de, wDecompressScratch tile NB_TILES ; The tilemap and attrmap are right after the tile data.
	ld hl, vBGMap1
	ld c, MAP_SIZE_IN_TILES
	call Request2bpp.Function ; Screen is on and the right banks are loaded: take a shortcut.
	ld a, 1
	ldh [rVBK], a
	ld de, wDecompressScratch tile (NB_TILES + MAP_SIZE_IN_TILES)
	ld hl, vBGMap3
	ld c, MAP_SIZE_IN_TILES
	call Request2bpp.Function ; Screen is on and the right banks are loaded: take a shortcut.
	xor a
	ldh [rVBK], a


; Most of the engine assumes that bank 1 is loaded.
	ld a, 1
	ldh [rWBK], a

; Init the cutscene's variables.
	ld hl, .ramBlock
	ld de, wCableCar
	ld bc, wCableCar.end - wCableCar
	rst CopyBytes

; Perform direction-dependent setup.
	assert GROUP_MOUNT_MOON_SQUARE != GROUP_ROUTE_4
	ld a, [wMapGroup] ; *Current* map, not target map.
	cp GROUP_MOUNT_MOON_SQUARE
	jr nz, .upLeftToMountMoonSquare
;.downRightToRoute4
	; Invert the car's speed vector (and one position subpixel, whatevs).
	; This is not true negation and thus gives a one-subpixel difference in speed between directions,
	; but that's negligible.
	; Actual negation of each byte is possible
	; (replace `ld a, [hl] :: cpl` with `xor a :: sub [hl]`)
	; but then e.g. `$00AA` gets turned into `$0056` instead of `$FF55`,
	; which is much further off from the correct `$FF56`.
	ld hl, wCableCar.cumulus_Xspeed_subpx
	assert wCableCar.cumulus_Xspeed_subpx + 4 == wCableCar.car_Xspeed_subpx
	ld c, 4 + 3 ; Cumulus X {speed,pos}x{subpx,px} + car X {speed.subpx, pos.subpx, speed.px}
.negate
	ld a, [hl]
	cpl
	ld [hli], a
	dec c
	jr nz, .negate
	ld [hl], (CAR_TARGET_X - NB_FRAMES_FADES * ~CAR_X_SPEED) / 1.0q8 ; This one cannot be merely complemented.
	; Also patch some code.
	ld a, $96 ; Opcode for `sub [hl]`.
	ld [wCableCar.cliffScrollInversion], a
	ld a, $2F ; Opcode for `cpl`.
	ld [wCableCar.xScrollInversion], a
.upLeftToMountMoonSquare


.SetUpOamTilesAndAttributes ; TODO: check if this does actually save space over a mere `CopyBytes`.
	; For now, only set up the tile and attributes; all positions will be written later.
	; Blocks are written backwards, but to keep the source code in OAM order, they are also read backwards.
	ld de, .objTileBlocksEnd
	ld hl, wShadowOAM + OAM_SIZE ; One past the end of shadow OAM.
.writeOamBlocks
	dec de
	ld a, [de] ; Bitfield %LLLL_LPPP: Length, Palette
	ld c, a ; The length will ignore the palette bits, so we can leave them there.
	and 7 ; Keep just the palette bits.
	ld b, a
	dec de
	ld a, [de] ; Bitfield %XTTT_TTTT: X flip, Tile ID (halved)
	add a, a ; Double the tile ID, shifting the X flip into carry.
	jr nc, .noXFlip
	set B_OAM_XFLIP, b
.noXFlip
	push de
	; OK, we are now ready to write the block to OAM.
.writeOamBlock  assert LOW(wShadowOAM) == 0 ; So that `dec l` cannot underflow.
	dec l
	ld [hl], b ; Write the attributes.
	dec l
	; Go to the next tile ID.
	sub 2 ; Unflipped blocks have increasing tile IDs (remember, we're writing backwards).
	bit B_OAM_XFLIP, b
	jr z, .increasingTileIDs ; Flipped blocks, however, are the opposite.
	add 2 + 2 ; Undo the `sub`, and then move in the other direction.
.increasingTileIDs
	ld [hld], a ; Write the new tile ID.
	; Tick the length.
	ld e, a
	ld a, c
	sub 1 << 3 ; This will underflow if we're done writing the block.
	ld c, a
	ld a, e ; `pop af` would overwrite carry.
	; Move the dest ptr from X pos to Y pos.
	dec l ; Note that this sets Z if OAM has been filled, and preserves carry!
	jr nc, .writeOamBlock ; Checks carry from the `sub`.
	pop de
	jr nz, .writeOamBlocks ; Checks Z from the `dec l`.

	; Patch the three middle OBJs' palettes.
	assert OBPAL_CAR_WHITE == OBPAL_CAR + 1
	ld l, LOW(wShadowOAMSprite00Attributes + OBJ_SIZE * (OBJ_CAR_RIGHT + 1))
	inc [hl] ; Don't write static values! This preserves the X flip bit.
	ld l, LOW(wShadowOAMSprite00Attributes + OBJ_SIZE * (OBJ_CAR_RIGHT - 2))
	inc [hl]
	ld l, LOW(wShadowOAMSprite00Attributes + OBJ_SIZE * (OBJ_CAR_RIGHT - 5))
	inc [hl]
.SetUpStaticOamPositions
	ld l, LOW(wShadowOAMSprite00YCoord + OBJ_SIZE * OBJ_CABLE)
	ld a, OAM_Y_OFS
	ld [hli], a
	ld a, OAM_X_OFS + SCREEN_WIDTH_PX + (TOPMOST_CABLE_Y_POS - 1) * 2 ; It will get moved by an extra 2px each scanline.
	ld [hli], a
	assert OBJ_CABLE + 1 == OBJ_CUMULUS
	ld a, [wCableCar.cumulus_Xpos_px]
	ld c, OBJ_CUMULUS_END - OBJ_CUMULUS
.setUpCumulus
	inc l ; Tile ID -> attrs.
	inc l ; Attrs -> next Y pos.
	ld [hl], CUMULUS_Y_POS + OAM_Y_OFS
	inc l ; Y pos -> X pos.
	add a, TILE_WIDTH ; ...which also happens to be `OAM_X_OFS` :)
	ld [hli], a ; X pos -> tile ID.
	dec c
	jr nz, .setUpCumulus


.WriteWindowMaps
	ld hl, wTilemap
.resetTileId
	ld a, CLIFF_BASE_TILE
.writeTilemapRow
REPT 4 ; The first four tiles of each row are unique...
	ld [hli], a
	inc a
ENDR
	ld c, (SCREEN_WIDTH - 4) / 2
.writeTilemapPair ; ...and the rest of the line is followed by a repeating pair.
	ld [hli], a
	inc a
	ld [hli], a
	dec a
	dec c
	jr nz, .writeTilemapPair
	add 2
	jr nz, .writeTilemapRow ; This is taken for two of the three repeating rows.
	static_assert SCREEN_HEIGHT % 3 == 0 ; So that we are sure to be here when it's time to exit.
	ld a, l
	cp LOW(wAttrmap)
	jr nz, .resetTileId
; The attrmap now...
	; hl == wAttrmap
	ld a, BGPAL_ROCK
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	rst ByteFill
; Commit both.
	call ApplyAttrAndTilemapInVBlank
	xor a ; Stop further transfers.
	ldh [hBGMapMode], a


.InstallStatIntHandler
; `ApplyAttrAndTilemapInVBlank` will have waited a few frames,
; so we can now be confident that OAM has been applied.
; Install the STAT handler so that the OAM starts getting multiplexed before we start fading in.
; Note however that `Request2bpp` does `di` and that screws up the handler.
	; Defang the STAT interrupt so it won't be requested during this setup.
	xor a
	ldh [rSTAT], a
	; Since the rest of the game keeps the STAT interrupt enabled at all times (just not the handler),
	; its bit in `IF` is certainly set right now.
	; This means that enabling the handler almost certainly will make it fire (out of HBlank, even!).
	; Resetting the bit in `IF` is dangerous, as any interrupts queued during the write instruction
	; will be lost (with particularly unlucky timing, this could be the VBlank handler...)
	; The safest solution is thus to enable the handler and let it run in a harmless way.
	; The generic handler will perform an errant write to hardware regs or HRAM;
	; if we make it write to the joypad register (whose address is in A right now),
	; then that write will be harmless.
	; A more proper solution is to never touch `IE` after init, and control the STAT interrupt directly,
	; by writing to `STAT` like I'm doing here. Two caveats, though:
	;  - `di` is subject to the same issue, since it effectively acts as a write to `IE`.
	;    Unfortunately, removing it from this engine seems like an even larger task.
	;  - One issue with writing to STAT is that, on monochrome consoles,
	;    doing so often spuriously queues the interrupt in `IF`.
	;    I do not expect that would be a problem for the GBC-only Polished,
	;    but even then it's sufficient to ensure that this errant handler behaves harmlessly.
	ldh [hLCDCPointer], a
	ld hl, rIE
	set B_IE_STAT, [hl] ; Enable the handler.
	; Since STAT has all its conditions disabled, we know it won't trigger right now.
	; Thus, non-atomically writing to the handler's trampoline is fine.
	ld a, LOW(wCableCar.LcdHandler)
	ldh [hLCDInterruptFunctionTargetLo], a
	ld a, HIGH(wCableCar.LcdHandler)
	ldh [hLCDInterruptFunctionTargetHi], a
	; OK, *now* we can enable the handler ^^'
.waitNotHblank
	ldh a, [rSTAT]
	and STAT_MODE
	jr z, .waitNotHblank ; Do not enable the interrupt during HBlank, it could trigger near its end instead of its beginning.
	ld a, STAT_MODE_0
	ldh [rSTAT], a


IF FADE_NB_STEPS == 10
	farcall FadeInPalettes
ELSE
	ld c, FADE_NB_STEPS
	call FadePalettes
ENDC

	; TODO: add random chance for Pokémon to fly in the sky?
	; TODO: allow player to move around in the car with d-pad?

def FRAME_QUANTUM equ 3
	ld hl, wCableCar.sequenceTimer
	ld [hl], NB_FRAMES_MAIN / FRAME_QUANTUM
.resetQuantum
	ld c, FRAME_QUANTUM
.mainSequence
	call DelayFrame
; Allow the scene to be skipped by pressing (not holding!) B or START.
	ldh a, [hJoypadPressed]
	and PAD_START | PAD_B
	jr nz, .abort
; Keep counting down.
	dec c
	jr nz, .mainSequence
	; This would normally be a race condition, but the variable is only read during `.UpdateScrolling`,
	; which always finishes before this point thanks to the VBlank handler being long.
	dec [hl]
	jr nz, .resetQuantum
.abort
	ld [hl], 0

IF FADE_NB_STEPS == 10
	farcall FadeOutPalettes
ELSE
	ld c, FADE_NB_STEPS
	call FadeToWhite
ENDC


.UninstallStatHandler
	ld hl, rIE
	res B_IE_STAT, [hl]
	ld a, LOW(LCDGeneric)
	ldh [hLCDInterruptFunctionTargetLo], a
	ld a, HIGH(LCDGeneric)
	ldh [hLCDInterruptFunctionTargetHi], a


.RestoreGlobalState ; :(
	ld a, STAT_MODE_0
	ldh [rSTAT], a
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a
	ld a, WX_OFS
	ldh [hWX], a
	ret


; Factored-out utilities.

.FillRowWithNextA:
	ld bc, SCREEN_WIDTH
.FillWithNextA:
	inc a
	rst ByteFill
	ret


.palettes:
INCLUDE "gfx/overworld/cable_car/cable_car.pal"

	const_def
	const BGPAL_TREES_CLOSEST         ; 0
	const BGPAL_TREES_MED_BOTTOM_HALF ; 1
	const BGPAL_TREES_MED_ROW_2       ; 2
	const BGPAL_TREES_MED_ROW_1       ; 3
	const BGPAL_TREES_FAR             ; 4
	const BGPAL_SKY                   ; 5
	const BGPAL_MOUNTAINS             ; 6
	const BGPAL_ROCK                  ; 7
assert const_value == 8, "Not at OBJ pal boundary! (pal #{d:const_value})"
	const_def
	const OBPAL_HANDLE    ; 0
	const OBPAL_CAR       ; 1
	const OBPAL_CAR_WHITE ; 2
	const OBPAL_CLOUD     ; 3
def NB_PALETTES equ const_value + 8
	; Filled in dynamically depending on player gender.
	; (Thus, must be last.)
	const OBPAL_PLAYER    ; 4


; We now define constants for tile indices.
; Some `assert`s act as sanity checks that the tile layout *should* be what we expect;
; this has already caught a mistake in the `.2bpp` file during development
; (one tile was unique and it shouldn't have been), so this seems worth the trouble.
; (And, even after I'm done, keep in mind that other people may want to tweak all this later!)
rsset $00
def PLAYER_BASE_TILE rb TILES_PER_CEL * CELS_PER_OBJECT * 2 ; One set for standing, another for walkies!
def PLAYER_NB_TILES  equ _RS - PLAYER_BASE_TILE

def BASE_TILE        equ $A0
static_assert _RS <= BASE_TILE, "Player tiles overflowing into cable car area! ({_RS})"
rsset BASE_TILE

; Tiles from `cable_car/cloud.2bpp`:
def CUMULUS_BASE_TILE      equ _RS
	rb_skip 2 * 6 ; 6 OBJs.
def CUMULUS_TILE_DATA equs READFILE("gfx/overworld/cable_car/cumulus.2bpp")
assert BYTELEN(#CUMULUS_TILE_DATA) / TILE_SIZE == _RS - CUMULUS_BASE_TILE, \
	STRFMT("%u != %u", BYTELEN(#CUMULUS_TILE_DATA) / TILE_SIZE, _RS - CUMULUS_BASE_TILE)

; Tiles from `cable_car/car_window.2bpp`:
def CAR_WIN_BASE_TILE      equ _RS
	rb_skip 2 ; Just one OBJ.
def CAR_WIN_TILE_DATA equs READFILE("gfx/overworld/cable_car/car_window.2bpp")
assert BYTELEN(#CAR_WIN_TILE_DATA) / TILE_SIZE == _RS - CAR_WIN_BASE_TILE, \
	STRFMT("%u != %u", BYTELEN(#CAR_WIN_TILE_DATA) / TILE_SIZE, _RS - CAR_WIN_BASE_TILE)

; Tiles from `cable_car/car_left.2bpp`:
def CAR_LEFT_BASE_TILE     equ _RS
	rb_skip 4 ; First column, also mirrored as the fifth.
def CAR_LEFT_TILE_DATA equs READFILE("gfx/overworld/cable_car/car_left.2bpp")
assert BYTELEN(#CAR_LEFT_TILE_DATA) / TILE_SIZE == _RS - CAR_LEFT_BASE_TILE, \
	STRFMT("%u != %u", BYTELEN(#CAR_LEFT_TILE_DATA) / TILE_SIZE, _RS - CAR_LEFT_BASE_TILE)

; Tiles from `cable_car/car.2bpp`:
def CAR_BASE_TILE          equ _RS
	rb_skip 2 * 6 ; Second and third column; the fourth mirrors the second.
def CAR_TILE_DATA equs READFILE("gfx/overworld/cable_car/car.2bpp")
assert BYTELEN(#CAR_TILE_DATA) / TILE_SIZE == _RS - CAR_BASE_TILE, \
	STRFMT("%u != %u", BYTELEN(#CAR_TILE_DATA) / TILE_SIZE, _RS - CAR_BASE_TILE)

; Tiles from `cable_car/handle_side.2bpp`:
def HANDLE_SIDE_BASE_TILE  equ _RS
	rb_skip 2
def HANDLE_SIDE_TILE_DATA equs READFILE("gfx/overworld/cable_car/handle_side.2bpp")
assert BYTELEN(#HANDLE_SIDE_TILE_DATA) / TILE_SIZE == _RS - HANDLE_SIDE_BASE_TILE, \
	STRFMT("%u != %u", BYTELEN(#HANDLE_SIDE_TILE_DATA) / TILE_SIZE, _RS - HANDLE_SIDE_BASE_TILE)

; Tiles from `cable_car/handle.2bpp`:
def HANDLE_BASE_TILE       equ _RS
	rb_skip 2
def HANDLE_TILE_DATA equs READFILE("gfx/overworld/cable_car/handle.2bpp")
assert BYTELEN(#HANDLE_TILE_DATA) / TILE_SIZE == _RS - HANDLE_BASE_TILE, \
	STRFMT("%u != %u", BYTELEN(#HANDLE_TILE_DATA) / TILE_SIZE, _RS - HANDLE_BASE_TILE)

; Tiles from `cable_car/cable.2bpp`:
def CABLE_BASE_TILE        equ _RS
	rb_skip 2 ; The bottom 14 pixel rows are never shown. Room for something?
def CABLE_TILE_DATA equs READFILE("gfx/overworld/cable_car/cable.2bpp")
assert BYTELEN(#CABLE_TILE_DATA) / TILE_SIZE == _RS - CABLE_BASE_TILE, \
	STRFMT("%u != %u", BYTELEN(#CABLE_TILE_DATA) / TILE_SIZE, _RS - CABLE_BASE_TILE)

; Tiles from `cable_car/bg.png`:
def BG_BASE_TILE           equ _RS
	static_assert BG_BASE_TILE == $C4, "Please re-generate `gfx/overworld/cable_car/bg.tilemap` with `-b {BG_BASE_TILE}` and update this"
	rb_skip 42
def BG_TILE_DATA equs READFILE("gfx/overworld/cable_car/bg.2bpp")
assert BYTELEN(#BG_TILE_DATA) / TILE_SIZE == _RS - BG_BASE_TILE, \
	STRFMT("%u != %u", BYTELEN(#BG_TILE_DATA) / TILE_SIZE, _RS - BG_BASE_TILE)

; Tiles from `cable_car/cliff.png`: (Note that they are all distorted by the WXzardry!)
def CLIFF_BASE_TILE        equ _RS
	rb_skip 18
	static_assert LOW(_RS) == 0, "Cliff tiles must end at 0, not {_RS}!"
def CLIFF_TILE_DATA equs READFILE("gfx/overworld/cable_car/cliff.2bpp")
assert BYTELEN(#CLIFF_TILE_DATA) / TILE_SIZE == _RS - CLIFF_BASE_TILE, \
	STRFMT("%u != %u", BYTELEN(#CLIFF_TILE_DATA) / TILE_SIZE, _RS - CLIFF_BASE_TILE)

def NB_TILES         equ _RS - BASE_TILE


.objTileBlocks: rsreset ; `const_def` would require awkward `const_skip`s.
MACRO obj_block ; <name>, <OBJ count>, <base tile>, <palette>, <X flip?>
	IF (\5) == 0
		db ((\3) / 2 + (\2)) ; Past-the-end tile ID (halved, since 8x16 mode requires alignment)
	ELSE
		db (\3) / 2 - 1 | $80 ; Tile ID just before the first one, and X flip flag.
	ENDC
	db ((\2) - 1) << 3 | (\4) ; Length (zero-indexed), and palette.
	; Use the name as-is to keep them greppable.
	def \1 rb (\2)
ENDM
	; Order matters here! Earlier OBJs have priority over later ones,
	; both in drawing order *and* in "10+ on the scanline" drop order.
	; Also, keep in sync with `obj_col_relative_pos`.
	obj_block OBJ_CAR_WIN_RIGHT, 1,     CAR_WIN_BASE_TILE, OBPAL_CAR_WHITE,  0
	obj_block OBJ_CAR_WIN_LEFT,  1,     CAR_WIN_BASE_TILE, OBPAL_CAR_WHITE,  1
	obj_block OBJ_PLAYER,        2,      PLAYER_BASE_TILE, OBPAL_PLAYER, 0 ; Partially hidden via raster effects.
	obj_block OBJ_HANDLE,        2, HANDLE_SIDE_BASE_TILE, OBPAL_HANDLE, 0
	obj_block OBJ_HANDLE_RIGHT,  1, HANDLE_SIDE_BASE_TILE, OBPAL_HANDLE, 1
	obj_block OBJ_CAR,   2 + 3 + 3,    CAR_LEFT_BASE_TILE, OBPAL_CAR,    0
	obj_block OBJ_CAR_RIGHT, 3 + 2,    CAR_LEFT_BASE_TILE, OBPAL_CAR,    1
def OBJ_CAR_END equ _RS
	obj_block OBJ_CABLE,         1,       CABLE_BASE_TILE, OBPAL_HANDLE, 0
	obj_block OBJ_CUMULUS,       6,       CUMULUS_BASE_TILE, OBPAL_CLOUD, 0
def OBJ_CUMULUS_END equ _RS
	obj_block OBJ_UNUSED,       13, 42, 0, 0
.objTileBlocksEnd: static_assert _RS == OAM_COUNT, "{d:_RS} != {d:OAM_COUNT}"


.ramBlock ; FIXME: in principle, we could add this to the asset blob, and copy it to WRAM0...
LOAD UNION "Misc 1300", WRAM0
wCableCar:


MACRO Q8pos_and_speed ; <name prefix>, <start pos>, <speed>
	\1speed_subpx: db LOW(\3)
	  \1pos_subpx: db LOW(\2)
	\1speed_px: db HIGH(\3)
	  \1pos_px: db HIGH(\2)
ENDM
.tickQ8Pos:
	ld a, [hli] ; Speed (subpx) -> pos (subpx).
	add a, [hl]
	ld [hli], a ; Pos (subpx) -> speed (px).
	ld a, [hli] ; Speed (px) -> pos (px).
	adc a, [hl]
	ld [hli], a ; Pos (px) -> one past struct.
	ret


MACRO parallax_layer ; <name prefix>, <first scanline>, <px modulo>, <speed>
	\1_scanline: db \2 - 1 ; Scrolling must be adjusted on the scanline *before*!
	; X pos is always incrementing, but gets written to SCX inverted if necessary.
	\1_XposPxModulo: db \3 ; `_Xpos_px` will remain between 0 and this (exclusive), assuming that the speed is no larger than this.
	Q8pos_and_speed \1_X, 0, \4
	; TODO: Y axis
ENDM
.parallaxLayers
	parallax_layer .nearClouds,  13, 255, SCROLL_SPEED_CLOUDS_NEAR
	parallax_layer .farClouds0,  30, 255, SCROLL_SPEED_CLOUDS_FAR_0
	parallax_layer .farClouds1,  40, 255, SCROLL_SPEED_CLOUDS_FAR_1
	parallax_layer .horizon,     48,  40, SCROLL_SPEED_HORIZON ; Mountains.
	parallax_layer .farTrees0,   64,   4, SCROLL_SPEED_TREES_FAR_0
	parallax_layer .farTrees1,   68,   4, SCROLL_SPEED_TREES_FAR_1
	parallax_layer .farTrees2,   72,   4, SCROLL_SPEED_TREES_FAR_2
	parallax_layer .farTrees3,   76,   4, SCROLL_SPEED_TREES_FAR_3
	parallax_layer .medTrees0,   80,   8, SCROLL_SPEED_TREES_MED_0
	parallax_layer .medTrees1,   89,   8, SCROLL_SPEED_TREES_MED_1
	parallax_layer .medTrees2,   97,   8, SCROLL_SPEED_TREES_MED_2
	parallax_layer .medTrees3,  105,   8, SCROLL_SPEED_TREES_MED_3
	parallax_layer .nearTrees0, 112,  16, SCROLL_SPEED_TREES_NEAR_0
	parallax_layer .nearTrees1, 130,  16, SCROLL_SPEED_TREES_NEAR_1
	db 0 ; Terminator.
.parallaxLayers_End


def ORIGIN_ON_RIGHT_OFS equ -24 ; Ensures that the car's origin wraps around after all of it is off-screen.
MACRO obj_col_relative_pos ; <count>, <x>, <y> (coords are relative to the middle of the attachment point)
	IF (\1) >= 0
		FOR i, (\1)
			db OAM_Y_OFS + (\3) + i * 16, OAM_X_OFS + (\2) + ORIGIN_ON_RIGHT_OFS
		ENDR

	ELSE ; Row was flipped, thus its OBJs are upside down.
		FOR i, -(\1) - 1, -1, -1 ; Iterate through the same positions, but in reverse.
			db OAM_Y_OFS + (\3) + i * 16, OAM_X_OFS + (\2) + ORIGIN_ON_RIGHT_OFS
		ENDR
	ENDC
ENDM
.carObjPosOfs ; Keep in sync with `obj_block`!
	obj_col_relative_pos  1,   8, 16 ; Right window.
	obj_col_relative_pos -1, -16, 16 ; Left window.

.playerPosOfs ; Player's position relative to the car's attachment point. Modified at runtime.
	obj_col_relative_pos  1,  -8, 15 + BLANKED_PLAYER_ROWS  ; Player left half.
	obj_col_relative_pos  1,   0, 15 + BLANKED_PLAYER_ROWS  ; Player left half.

	obj_col_relative_pos  1, -12, 0  ; Left handle.
	obj_col_relative_pos  1,  -4,-1  ; Middle handle.
	obj_col_relative_pos -1,   4, 0  ; Right handle.

	obj_col_relative_pos  2, -20, 8  ; Body column #1.
	obj_col_relative_pos  3, -12, 0  ; Body column #2.
	obj_col_relative_pos  3,  -4, 0  ; Body column #3.
	obj_col_relative_pos -3,   4, 0  ; Body column #4.
	obj_col_relative_pos -2,  12, 8  ; Body column #5.
.carObjPosOfsEnd


; Some instructions throughout this handler are on the same line as a label;
; this is used to highlight that the instruction and/or its operand(s) are modified
; throughout the animation.
; (This is possible since this code gets loaded into RAM.)
.LcdHandler:
	push hl

; Multiplex some of the OAM.
; Do this first so that we are sure we are in HBlank; Mode 2 doesn't cut it, unlike some later code.
; This is too much code to run in HBlank (even in double-speed mode!),
; so some of the checks have their scanline numbers stored inline, as self-modifying code,
; in order to fit within the HBlank budget even on the 10-OBJ scanlines.

	ld hl, oamSprite{02d:OBJ_CABLE}XCoord
	ld a, [hl]
	sub 2 ; Move it left by 2 pixels.
	jr c, .noWrappingAround ; Don't let it wrap around the screen.
	ld [hld], a
	inc [hl] ; Move it down by 1 pixel.
.noWrappingAround

; Split the horizontal scrolling between rows of trees.
	ldh a, [rLY]
	ldh [hLY], a ; Use a consistent value throughout the handler, since the HW reg will change after HBlank.
.parallaxPtr: ld hl, .parallaxLayers
	cp [hl]
	jr nz, .noXSplit
	ld a, l
	add a, LOW(.horizon_Xpos_px) - LOW(.horizon_scanline)
	ld l, a
	ld a, [hli]
	.xScrollInversion: nop ; Patched to `cpl` if scrolling is inverted.
	ldh [rSCX], a
	assert HIGH(.parallaxLayers) == HIGH(.parallaxLayers_End - 1), "Parallax buffer iteration would cost two writes!"
	ld a, l
	ld [.parallaxPtr + 1], a
.noXSplit

; Skip some of the Window's rows near the top of the screen, to scroll it vertically.
	; WY will have been set to CLIFF_PATTERN_HEIGHT - <nb rows to skip>, so make sure it's not displayed on scanline CLIFF_PATTERN_HEIGHT.
	ldh a, [hLY]
	cp CLIFF_PATTERN_HEIGHT - 1
	jr nz, .notResettingWindow
	ld hl, rLCDC
	res B_LCDC_WIN_MAP, [hl] ; Switch it back to the cliff tilemap.
	.cliffWxInitialOffset: ld a, 42
	add SCREEN_WIDTH_PX + WX_OFS ; Set the Window just off-screen.
	ldh [rWX], a
	jr .noWindowShift ; ...and skip the code below.
.notResettingWindow
; Move the window left every scanline it's active.
; This distorts it so that it looks more like a separate layer, without any OBJs!
	.cliffFirstScanline: cp $FF ; Dummy value, will get overwritten.
	jr c, .noWindowShift
.wxOfsPtr: ld hl, .wxOffsets
	ldh a, [rWX]
	sub a, [hl]
	ldh [rWX], a
	; Advance the pointer into the table.
	assert HIGH(.wxOffsets) == HIGH(.wyTable - 1), "Please realign wCableCar.wxOffsets" ; Let me work with only the low byte, please.
	ld a, l
	inc a
	cp LOW(.wyTable)
	jr nz, .noWxOfsWrap
	ld a, LOW(.wxOffsets)
.noWxOfsWrap
	ld [.wxOfsPtr + 1], a
.noWindowShift

	; Regrettably, we want the scrolling to change even during `Fade*Palettes`,
	; but those functions are blocking.
	; So the scrolling update logic is here, instead of in the main loop where it belongs.  :(
	ldh a, [hLY]
	and a ; Do this near the top of the screen...
	call z, .UpdateScrolling ; ... where all the variables this updates haven't been read yet.

	pop hl
	pop af
	reti


.UpdateScrolling
	ei ; This process takes more than a scanline, so enable nested interrupts to not delay the next one.

	push bc
	push de

; Set up the cliff's vertical scrolling.
; This involves a two-step process: the Window must first be on-screen to "skip" some of its lines,
; and then begin being properly shown further down the screen.
; Do this early, because WY must be written to before scanline 2 begins!
	ld hl, .sequenceTimer
	ld a, [hld]
	assert .sequenceTimer - 1 == .cliff_Xpos_px
	and a
	jr z, .gotCliffScroll ; Do not move the cliff if in a transition state.

	ld hl, .cliff_Xspeed_subpx
	call .tickQ8Pos
	dec hl ; We're going to read that again.
	jr c, .gotCliffScroll ; Since we are adding a negative speed, we know we must have underflowed if carry *isn't* set.
	add CLIFF_PATTERN_WIDTH ; Wrap back into the positives...
	ld [hl], a
.gotCliffScroll

	ld a, CLIFF_PATTERN_WIDTH - 1
	.cliffScrollInversion: ld a, [hl] ; Patched to `sub [hl]` if necessary.
	ld [.cliffWxInitialOffset + 1], a
	push af
	; Set up to skip the appropriate number of lines also.
	assert .wyTable_End - .wyTable == CLIFF_PATTERN_WIDTH
	add a, LOW(.wyTable)
	ld l, a
	assert HIGH(.wyTable_End - 1) == HIGH(.wyTable), "Cannot index WY table efficiently, pls realign"
	ld h, HIGH(.wyTable)
	ld a, [hl]
	ldh [rWY], a

	; Use the main tilemap, since its top scanlines are a solid colour.
	ld hl, rLCDC
	set B_LCDC_WIN_MAP, [hl]

	; Cache the scanline at which to start showing the Window.
	pop af
	inc a ; Make the halving round up, for a bit of extra visual variety.
	srl a ; Unsigned division by 2.
	cpl ; Subtract that from the base scanline, so that moving further right also moves further *up*.
	add a, CLIFF_BASE_SCANLINE + 1
	ld [.cliffFirstScanline + 1], a
	; Also reset this bit of self-modifying code.
	ld a, LOW(.wxOffsets)
	ld [.wxOfsPtr + 1], a

; Little easter egg!
	ldh a, [hJoypadDown]
	and PAD_CTRL_PAD
	jr z, .makePlayerStandStill
	ld c, a ; Direction mask.
	ld a, -4 ; Base tile.
.seekDir
	add a, 4
	sla c
	jr nc, .seekDir
	jr nz, .doneMoving ; Do not change direction or move.
	ld b, OBPAL_PLAYER
	cp PLAYER_NB_TILES / 2
	jr nz, .notRight ; Right-facing gfx reuse left-facing but flipped.
	ld a, 4 * 2 + 2
	set B_OAM_XFLIP, b
.notRight
	ld hl, wShadowOAMSprite{02d:OBJ_PLAYER}TileID
	ld [hli], a
	ld [hl], b
	ld l, LOW(wShadowOAMSprite{02d:OBJ_PLAYER}Attributes + OBJ_SIZE) ; The other tile ID will be set below.
	ld [hl], b
	; Move also!
	cp TILES_PER_CEL * 2
	jr c, .bump ; Down or up.
	ld hl, .playerPosOfs + 3
	ld a, [hl]
	jr nz, .right
	; Left.
	dec a
	cp OAM_X_OFS - PLAYER_MOVEMENT_RADIUS + ORIGIN_ON_RIGHT_OFS
	jr c, .bump
.movePlayer
	ld [hl], a
	sub TILE_WIDTH
	ld [.playerPosOfs + 1], a
	jr .doneMoving
.right
	inc a
	cp OAM_X_OFS + PLAYER_MOVEMENT_RADIUS + ORIGIN_ON_RIGHT_OFS + 1
	jr c, .movePlayer
.bump
	call CheckSFX
	jr nz, .doneMoving
	ld de, SFX_BUMP
	call PlaySFX
.doneMoving
	; Update the movement timer, and the player's cel accordingly.
	ld a, [.playerMovementTimer]
	sub $10 ; Toggles bit 7 every 8 frames.
.makePlayerStandStill ; a == 0 if jumping to here.
	ld [.playerMovementTimer], a
	add a, a ; Carry set iff should be walking.
	sbc a, a ; a == $FF iff should be walking, otherwise 0.
	and PLAYER_NB_TILES / 2 ; a == walking offset iff should be walking, otherwise 0.
	ld b, a
	; Enforce standing/walking cel.
	ld hl, wShadowOAMSprite{02d:OBJ_PLAYER}TileID
	ld a, [hl]
	sub PLAYER_NB_TILES / 2
	jr nc, .wasWalking
	ld a, [hl] ; Pretend nothing just happened~
.wasWalking
	add a, b ; Add the walking offset iff should be walking.
	ld [hl], a
	xor 2 ; Toggle between left and right half.
	ld [wShadowOAMSprite{02d:OBJ_PLAYER}TileID + OBJ_SIZE], a

; Update background scrolling.
	ld hl, .parallaxLayers
	ld a, l
	ld [.parallaxPtr + 1], a ; Reset that SMC.
	ld a, [.sequenceTimer]
	and a
	jr z, .bgDoesntMove

	inc l ; Scanline -> Max X (px).
.tickParallaxLayer
	ld a, [hli] ; Max X (px) -> X speed (subpx).
	ld c, a
	call .tickQ8Pos
	sub c ; Overflowed the wrap-around range?
	jr c, .noParallaxWrap
	dec hl ; Woops, undo!
	ld [hli], a ; NB: `a` may be non-zero if pixels increased by more than 1 this frame!
.noParallaxWrap
	ld a, [hli] ; Scanline -> Max X (px).
	and a ; Check for a zero terminator.
	jr nz, .tickParallaxLayer

; Move the cumulus also.
	ld hl, .cumulus_Xspeed_subpx
	call .tickQ8Pos
	ld hl, wShadowOAMSprite{02d:OBJ_CUMULUS}XCoord
	ld c, OBJ_CUMULUS_END - OBJ_CUMULUS
.moveCumulus
	add a, TILE_WIDTH ; ...which also happens to be `OAM_X_OFS` :)
	ld [hli], a ; X pos -> tile ID.
	inc l ; Tile ID -> attrs.
	inc l ; Attrs -> next Y pos.
	inc l ; Y pos -> X pos.
	dec c
	jr nz, .moveCumulus

	inc c ; The previous loop leaves c == 0, so this clears Z.
	ld a, [.car_Xpos_px] ; Where to draw the car.
.bgDoesntMove ; This gets jumped to with Z set.

; Update OAM last, since the other variables may be read for real soon,
; whereas shadow OAM will only get read on the next VBlank.

; Update cable car's position.
	ld hl, .car_Xspeed_subpx
	call z, .tickQ8Pos ; Only if BG wasn't moved.
	ld c, a
	; The car's Y position is derived from its X position.
	; This is odd / unusual vs. giving the Y axis its own speed and position,
	; but it ensures that the two axes do not drift apart due to accumulated fixed-point imprecision.
	cpl ; Invert, since the two axes grow in different directions.
	srl a ; Unsigned division by 2 (the cable's slope) because there are more than 128 pixels.
	add a, TOPMOST_CABLE_Y_POS - $24 ; Some offset is necessary to adjust the negation.
	ld b, a

; Occasionally bump the car by one pixel.
	assert .car_Xpos_px + 1 == .carBumpTimer
	ld a, [hl]
	add CAR_BUMP_TIMER_INCREMENT
	ld [hl], a
	and CAR_BUMP_TRIGGER_MASK
	jr nz, .noCarBump
	bit 6, [hl]
	jr nz, .bumpCarUp
	bit 7, [hl]
	jr nz, .noCarBump
	inc b
	inc b ; Counteract the upcoming `dec b`.
.bumpCarUp
	dec b
.noCarBump

; Draw the cable car in its new position.
	ld hl, wShadowOAMSprite{02d:OBJ_CAR_END}XCoord - OBJ_SIZE
	ld de, .carObjPosOfsEnd
.updateCarObjPos
	dec e ; (dec de)
	ld a, [de] ; Offset from cable car's origin.
	add a, c ; Origin's X pos.
	ld [hld], a
	dec e ; (dec de)
	ld a, [de]
	add a, b ; Origin's Y pos.
	ld [hld], a
	dec l ; Attrs -> Tile ID.
	dec l ; Tile ID -> X pos.
	ld a, e
	cp LOW(.carObjPosOfs)
	jr nz, .updateCarObjPos

	pop de
	pop bc
	ret


	Q8pos_and_speed .cumulus_X, SCREEN_WIDTH_PX * 1.0q8, -CUMULUS_X_SPEED ; The direction are inverted compared to SCX!

def CAR_TARGET_X equ (SCREEN_WIDTH_PX / 2 - ORIGIN_ON_RIGHT_OFS) * 1.0q8 ; Coordinate so that the car is centered on the screen.
	Q8pos_and_speed .car_X, CAR_TARGET_X - NB_FRAMES_FADES * CAR_X_SPEED, CAR_X_SPEED
	.carBumpTimer: db 0


	Q8pos_and_speed .cliff_X, 0, -SCROLL_SPEED_CLIFF

; While zero, the car moves and nothing else.
; While non-zero, this is inverted.
.sequenceTimer: db 0


.playerMovementTimer: db 0


.wxOffsets ; How much to move the Window by *to* render this pixel row. (Because it starts off-screen, the Y counter is not ticked on the first scanline.)
	db 7, 1, 1, 1, 0, 8, 1, 2, 1, 1, 1, 0
.wyTable
MACRO initial_wy ; Each arg is “how many blank pixels at the top of this column” (in the non-staggered version).
	FOR i, 1, _NARG + 1
		static_assert \<i> < CLIFF_PATTERN_HEIGHT
		; Ranges from 1 to CLIFF_PATTERN_HEIGHT (inclusive).
		db -\<i> % -CLIFF_PATTERN_HEIGHT + CLIFF_PATTERN_HEIGHT
	ENDR
ENDM
	initial_wy 0, 0, 0, 0, 0, 0, 0 ; Sanity check: the first entry in this list should always be zero!
	initial_wy 1, 2, 3
	initial_wy 5, 5, 5, 5, 5, 5, 5, 5 ; 8-column flat stretch.
	initial_wy 6, 7, 7, 8, 9, 10
.wyTable_End

.end
ENDL
.ramBlockEnd
