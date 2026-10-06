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
INCBIN "gfx/overworld/cable_car.bin.lzp"
; Some of `cable_car.2bpp.lzp`'s dependency `.2bpp` files get `READFILE()`'d below,
; as part of length checks; they are ordered after this to be robust to dependency ordering / scanning.


;; Tunables.

def TOPMOST_CABLE_Y_POS equ 10
def BLANKED_PLAYER_ROWS equ 6
; How many steps of the cliff get drawn to the tilemap,
; and thus indirectly how much on-screen space it should take.
def NB_CLIFF_STEPS equ 9
def NB_CLIFF_FINE_Y_SCROLL equ 2 ; Keep this between 0 and 7, but between the two "breaks the grid" more.
	def CLIFF_BASE_SCANLINE equ (SCREEN_HEIGHT - NB_CLIFF_STEPS) * 8 + NB_CLIFF_FINE_Y_SCROLL


SECTION "Cable Car", ROMX

Special_CableCar::
	; At this point, music is faded out and the screen is faded.
	ld e, MUSIC_MAGNET_TRAIN
	call PlayMusic
	; Disable map anim processing, to save on a lot of VBlank time.
	; This command is always followed by some `warp*` script command,
	; which sets up a new map, and *that* runs `ActivateMapAnims`.
	xor a
	ldh [hMapAnims], a
; Init some cutscene vars. (TODO: many may be unnecessary!)
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
	ld de, wBGPals1 palette PAL_BASE_IDX
	ld bc, NB_PALETTES palettes
	call FarCopyColorWRAM


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
	assert OBPAL_WHITE == OBPAL_CAR + 1
	ld l, LOW(wShadowOAMSprite00Attributes + OBJ_SIZE * (OBJ_CAR_RIGHT + 1))
	inc [hl] ; Don't write static values! This preserves the X flip bit.
	ld l, LOW(wShadowOAMSprite00Attributes + OBJ_SIZE * (OBJ_CAR_RIGHT - 2))
	inc [hl]
	ld l, LOW(wShadowOAMSprite00Attributes + OBJ_SIZE * (OBJ_CAR_RIGHT - 5))
	inc [hl]
.SetUpStaticOamPositions
	ld l, LOW(wShadowOAMSprite00YCoord + OBJ_SIZE * OBJ_CABLE)
	ld a, OAM_Y_OFS + TOPMOST_CABLE_Y_POS
	ld [hli], a
	ld [hl], SCREEN_WIDTH_PX - 4 + OAM_X_OFS


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
; downRightToRoute4:
	; Invert all vars considered direction-dependent (basically, the speed vectors).
	; This does give a one-unit difference between each direction,
	; but each of these variables uses sub-pixels, so it'll be negligible.
	ld hl, wCableCar.dirDependentVars
	ld c, wCableCar.dirDependentVars_End - wCableCar.dirDependentVars_End
.negate
	ld a, [hl]
	cpl
	ld [hli], a
	dec c
	jr nz, .negate
.upLeftToMountMoonSquare


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
	ld a, STAT_MODE_0 ; TODO: once the handler's logic is written, consider using LYC (and Mode 1 for reset?)
	ldh [rSTAT], a


.WriteWindowMaps
	ld hl, wTilemap
.writeTilemap
	ld a, TILE_BG_ROCK_SLOPE_PARTIAL
	ld [hli], a
	inc a ; TILE_BG_ROCK_SLOPE_FULL
	ld [hli], a
	inc a ; TILE_BG_ROCK
	ld bc, SCREEN_WIDTH - 2
	rst ByteFill
	ld a, l
	cp LOW(wAttrmap)
	jr nz, .writeTilemap
; The attrmap now...
	; hl == wAttrmap
	ld a, BGPAL_ROCK
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	rst ByteFill
; Commit both.
	call ApplyAttrAndTilemapInVBlank
	xor a ; Stop further transfers.
	ldh [hBGMapMode], a


	farcall FadeInPalettes

	; TODO: add random chance for Pokémon to fly in the sky?
	; TODO: allow player to move around in the car with d-pad?

	; TODO: allow this wait to be skipped by pressing a button (A? B?)
	ld c, 0
	call DelayFrames

	farcall FadeOutPalettes


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


def PAL_BASE_IDX equ 5
.palettes: const_def PAL_BASE_IDX

const BGPAL_TREELINE
	RGB  9, 23, 29 ; Sky. Must be first for priority effects.
	RGB 12, 25,  1
	RGB  5, 14,  0
	RGB  7,  7,  7

const BGPAL_TREES
	RGB 22, 31, 10
	RGB 12, 25,  1
	RGB  5, 14,  0
	RGB  7,  7,  7

const BGPAL_ROCK
	RGB 27, 31, 27
	RGB 24, 18,  7
	RGB 20, 15,  3
	RGB  7,  7,  7

assert const_value == 8, "Not at OBJ pal boundary! (pal #{d:const_value})"
const_def 0

const OBPAL_HANDLE ; Also used for the cable.
	RGB 27, 31, 27 ; Ignored.
	RGB 21, 21, 21
	RGB 13, 13, 13
	RGB  7,  7,  7

const OBPAL_CAR
	RGB 27, 31, 27 ; Ignored.
	RGB 29, 26, 10
	RGB 17, 15, 10
	RGB  7,  7,  7

const OBPAL_WHITE ; A copy of the car, but with one colour replaced with the white backdrop.
	RGB 27, 31, 27 ; Ignored.
	RGB 29, 26, 10
	RGB 31, 31, 31 ; Backdrop for the car. (TODO: consider some darker, desaturated colour?)
	RGB  7,  7,  7

def NB_PALETTES equ const_value + (8 - PAL_BASE_IDX)

const OBPAL_PLAYER
	; Filled in dynamically depending on player gender.
	; (Thus, must be last.)


; We now define constants for tile indices.
; Some `assert`s act as sanity checks that the tile layout *should* be what we expect;
; this has already caught a mistake in the `.2bpp` file during development
; (one tile was unique and it shouldn't have been), so this seems worth the trouble.
; (And, even after I'm done, keep in mind that other people may want to tweak all this later!)
rsset $00
def PLAYER_BASE_TILE rb TILES_PER_CEL * CELS_PER_OBJECT * 2 ; One set for standing, another for walkies!
def PLAYER_NB_TILES  equ _RS - PLAYER_BASE_TILE

def BASE_TILE        equ $80 ; For `DecompressRequest2bpp`.
static_assert _RS <= BASE_TILE, "Player tiles overflowing into cable car area! ({_RS})"
rsset BASE_TILE

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
	rb_skip 2 ; The bottom 12 pixels are never shown. Room for something?
def CABLE_TILE_DATA equs READFILE("gfx/overworld/cable_car/cable.2bpp")
assert BYTELEN(#CABLE_TILE_DATA) / TILE_SIZE == _RS - CABLE_BASE_TILE, \
	STRFMT("%u != %u", BYTELEN(#CABLE_TILE_DATA) / TILE_SIZE, _RS - CABLE_BASE_TILE)

; Tiles from `cable_car/trees.png`:
def TREES_BASE_TILE        equ _RS
	def TILE_BG_SKY                rb 1
	def TILE_BG_TREELINE           rb 1 ; Has a bit of the sky peeking through.
	def TILE_BG_FAR_TREES          rb 1 ; Mostly the same.
	def TILE_BG_FAR_TO_MED         rb 1 ; Transition. 🏳️‍⚧️
	def TILE_BG_MED_TREES          rb 2 ; Each tile is offset horizontally by 4 pixels.
	def TILE_BG_MED_TO_NEAR        rb 2 ; Transition. 🏳️‍⚧️ Did you know that there are two ways to make people laugh? The first is running gags, and the second is running gags.
	def TILE_BG_NEAR_TREES_MID     rb 2
	def TILE_BG_NEAR_TREES_BOTTOM  rb 2 ; Doubles as the top of the next row of trees.
def TREES_TILE_DATA equs READFILE("gfx/overworld/cable_car/trees.2bpp")
assert BYTELEN(#TREES_TILE_DATA) / TILE_SIZE == _RS - TREES_BASE_TILE, \
	STRFMT("%u != %u", BYTELEN(#TREES_TILE_DATA) / TILE_SIZE, _RS - TREES_BASE_TILE)

; Tiles from `cable_car/rocks.png`: (Note that they are all distorted by the WXzardry!)
def ROCKS_BASE_TILE        equ _RS
	def TILE_BG_ROCK_SLOPE_PARTIAL rb 1
	def TILE_BG_ROCK_SLOPE_FULL    rb 1
	def TILE_BG_ROCK               rb 1
def ROCKS_TILE_DATA equs READFILE("gfx/overworld/cable_car/rocks.2bpp")
assert BYTELEN(#ROCKS_TILE_DATA) / TILE_SIZE == _RS - ROCKS_BASE_TILE, \
	STRFMT("%u != %u", BYTELEN(#ROCKS_TILE_DATA) / TILE_SIZE, _RS - ROCKS_BASE_TILE)

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
	obj_block OBJ_CAR_WIN_RIGHT, 1,     CAR_WIN_BASE_TILE, OBPAL_WHITE,  0
	obj_block OBJ_CAR_WIN_LEFT,  1,     CAR_WIN_BASE_TILE, OBPAL_WHITE,  1
	obj_block OBJ_PLAYER,        2,      PLAYER_BASE_TILE, OBPAL_PLAYER, 0 ; Partially hidden via raster effects.
	obj_block OBJ_HANDLE,        2, HANDLE_SIDE_BASE_TILE, OBPAL_HANDLE, 0
	obj_block OBJ_HANDLE_RIGHT,  1, HANDLE_SIDE_BASE_TILE, OBPAL_HANDLE, 1
	obj_block OBJ_CAR,   2 + 3 + 3,    CAR_LEFT_BASE_TILE, OBPAL_CAR,    0
	obj_block OBJ_CAR_RIGHT, 3 + 2,    CAR_LEFT_BASE_TILE, OBPAL_CAR,    1
def OBJ_CAR_END equ _RS
	obj_block OBJ_CABLE,         1,       CABLE_BASE_TILE, OBPAL_HANDLE, 0
	obj_block OBJ_UNUSED,       19, 42, 0, 0 ; TODO: try 8x8 mode
.objTileBlocksEnd: static_assert _RS == OAM_COUNT, "{d:_RS} != {d:OAM_COUNT}"


.ramBlock ; FIXME: in principle, we could add this to the asset blob, and copy it to WRAM0...
LOAD UNION "Misc 1300", WRAM0
wCableCar:

MACRO obj_col_relative_pos ; <count>, <y>, <x>
	IF (\1) >= 0
		FOR i, (\1)
			db OAM_Y_OFS + (\2) + i * 16, OAM_X_OFS + (\3)
		ENDR

	ELSE ; Row was flipped, thus its OBJs are upside down.
		FOR i, -(\1) - 1, -1, -1 ; Iterate through the same positions, but in reverse.
			db OAM_Y_OFS + (\2) + i * 16, OAM_X_OFS + (\3)
		ENDR
	ENDC
ENDM
.carObjPosOfs ; Keep in sync with `obj_block`!
	obj_col_relative_pos 1, 16, 8   ; Right window.
	obj_col_relative_pos-1, 16, -16 ; Left window.

.playerPosOfs ; Player's position relative to the car's attachment point. Modified at runtime.
	obj_col_relative_pos 1, 15 + BLANKED_PLAYER_ROWS, -8  ; Player left half.
	obj_col_relative_pos 1, 15 + BLANKED_PLAYER_ROWS,  0  ; Player left half.

	obj_col_relative_pos 1,  0, -12 ; Left handle.
	obj_col_relative_pos 1, -1, -4  ; Middle handle.
	obj_col_relative_pos-1,  0, 4   ; Right handle.

	obj_col_relative_pos 2,  8, -20 ; Body column #1.
	obj_col_relative_pos 3,  0, -12 ; Body column #2.
	obj_col_relative_pos 3,  0, -4  ; Body column #3.
	obj_col_relative_pos-3,  0, 4   ; Body column #4.
	obj_col_relative_pos-2,  8, 12  ; Body column #5.
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

	; Note that we check for the target scanline rather than always moving the OBJ every N scanlines,
	; so that we behave correctly even if the cable begins further down the screen.
	ld hl, oamSprite{02d:OBJ_CABLE}YCoord ; Y position below the cable OBJ.
	ldh a, [rLY]
	ldh [hLY], a ; Use a consistent value throughout, since the HW reg will change after HBlank.
	add 14 + 1 ; The bottom 14 rows are blank (must not be shown), plus 1 because we are *after* the scanline.
	cp [hl]
	jr nz, .noCableMultiplex
	add a, TILE_HEIGHT * 2 - 14 ; Move it down by however many rows aren't blank.
	ld [hli], a ; Y pos
	ld a, [hl]
	sub 4 ; Move it left by 4 pixels.
	jr c, .noCableMultiplex ; ...unless that would cause it to wrap around the screen.
	ld [hl], a
.noCableMultiplex

; Skip some of the Window's rows near the top of the screen, to scroll it vertically.
	; L = row at which to start the window (<base scanline> - <Y scroll>)
	ld a, [.cliffFirstScanline]
	ld l, a
	; WY will have been set to 9 - <nb rows to skip>, so make sure it's not displayed after scanline 8.
	ldh a, [hLY]
	cp 8
	jr nz, .notResettingWindow
	ld hl, rLCDC
	res B_LCDC_WIN_MAP, [hl] ; Switch it back to the cliff tilemap.
	; Use 5-bit horizontal scrolling.
	ld a, [.bgXScroll]
	cpl ; SCX and WX directions are opposite, so invert the meaning.
	rra
	rra
	rra
	and $0F ; The pattern repeats after 16 pixels, so we don't need extra range.
	add SCREEN_WIDTH_PX + WX_OFS ; Set the Window just off-screen.
	jr .setWx ; ...and skip the code below.
.notResettingWindow
; Move the window left every scanline it's active.
; This distorts it so that it looks more like a separate layer, without any OBJs!
	sub l
	jr c, .noWindowShift
	and 7 ; This repeats for every tile.
	; Index into the offset table.
	add LOW(.wxOffsets)
	ld l, a
	adc HIGH(.wxOffsets)
	sub l
	ld h, a
	ldh a, [rWX]
	sub a, [hl]
.setWx
	ldh [rWX], a
.noWindowShift

	; TODO: raster splits

	; Regrettably, we want the scrolling to change even during `Fade*Palettes`,
	; but those functions are blocking.
	; So the scrolling update logic is here, instead of in the main loop where it belongs.  :(
	ldh a, [hLY]
	and a ; Do this near the top of the screen...
	call z, .UpdateScrolling ; ... where all the variables this updates haven't been read yet.

	pop hl
	pop af
	reti

.wxOffsets ; How much to move the Window by *to* render this pixel row. (Because it starts off-screen, the Y counter is not ticked on the first scanline.)
	db 1, 2, 1, 1, 0, 1, 1, 9
.wyTable ; This has been manually determined; it can be computed as `9 - <number of extra non-blank pixels compared to the previous scanline>`.
	db 8, 7, 7, 6, 5, 3, 2, 1
	db 9, 9, 9, 9, 9, 9, 9, 9


.UpdateScrolling
	ei ; This process takes more than a scanline, so enable nested interrupts to not delay the next one.

	push bc

; Update background scrolling.
	ld hl, .bgScrollSpeed
	ld a, [hld]
	ld c, a
	sra a ; Halved (using signed division here!)
	add [hl] ; Our slope is 2:1, so Y scroll speed is halved.
	ld [hld], a ; .bgYScroll
	ld a, c ; X scroll is unscaled.
	add [hl]
	ld [hld], a ; .bgXScroll
	swap a ; No need to mask off the upper bits, since the pattern repeats every 16 pixels.
	ldh [hSCX], a
; Set up the cliff's vertical scrolling.
; This involves a two-step process: the Window must first be on-screen to "skip" some of its lines,
; and then begin being shown further down the screen.
; Note that this is derived from X scroll so that it remains precisely tied to its own X scroll;
; and it is also inverted (full negation is not strictly necessary) as increasing SCX scrolls the BG *left*,
; but increasing WX scrolls the Window *right*.
	cpl
	push af
	rlca ; The cliff scrolls horizontally twice as fast.
	and $0F ; The Window pattern repeats after 16 pixels.
	; Set up to skip the appropriate number of lines also.
	add a, LOW(.wyTable)
	ld l, a
	adc a, HIGH(.wyTable)
	sub l
	ld h, a
	ld a, [hl]
	ldh [rWY], a
	ld hl, rLCDC
	set B_LCDC_WIN_MAP, [hl] ; Use the main tilemap, since its top scanlines are a solid colour.
	; Cache the scanline at which to start showing the Window.
	pop af
	and $07 ; The pattern repeats after 8 pixels.
	cpl ; Subtract that from the base scanline.
	add a, CLIFF_BASE_SCANLINE + 1
	ld [.cliffFirstScanline], a

; Update OAM last, since the other variables may be read for real soon,
; whereas shadow OAM will only get read on the next VBlank.

; Update cable car's position.
	ld hl, .carSpeed
	ld a, [hli]
	ld b, a ; Cache pixels for later. (The speed is big-endian.)
	ld a, [hli]
	add a, [hl]
	ld [hli], a ; Subpixels.
	ld a, b
	adc a, [hl]
	ld [hli], a ; Pixels.
	ld c, a
	; The car's position is derived from its X position.
	; This is odd / unusual vs. giving the Y axis its own speed and position,
	; but it ensures that the two axes do not drift apart due to accumulated fixed-point imprecision.
	cpl ; Invert, since the two axes grow in different directions.
	srl a ; Unsigned division by 2, which is the cable's slope.
	add a, TOPMOST_CABLE_Y_POS - $30 ; Some offset is necessary to adjust the negation.
	; TODO: occasionally bump the car by one pixel!
	ld b, a

	push de

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


; TODO: consider moving some of those into SMC?
; TODO: make more of those initial values into tunables.

; These are Q.4 fixed-point: the extra precision enables extra smoothness,
;                            and the pattern repeats after 16 pixels anyway.
	.bgXScroll: db 0
	.bgYScroll: db 0
.dirDependentVars ; These variables get negated in bulk depending on direction.
	.bgScrollSpeed: db $0A ; Less visual than a fixed-point literal, but bit 0 must remain clear...
; These are Q.8 OAM-space, and the coords are roughly the attachment point's.
	.carSpeed: db $00, $AA
	.carXPos: db $00, $97
.dirDependentVars_End
	.cliffFirstScanline: db 42 ; (Dummy value.)

.end
ENDL
.ramBlockEnd
