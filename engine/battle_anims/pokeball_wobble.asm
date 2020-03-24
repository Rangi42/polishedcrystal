GetPokeBallWobble:
; Returns whether a Poke Ball will wobble in the catch animation.
; Whether a Pokemon is caught is determined beforehand.
	ld a, BANK(wBuffer2)
	call StackCallInWRAMBankA
.Function:
; Wobble up to 3 times.
	; Check for critical capture flag
	ld a, [wBuffer2]
	and $10
	jr z, .no_critical

	; skip the first 3 checks
	ld a, 3
	ld c, 0
	jr .critical_shake

.no_critical
	ld hl, .WobbleProbabilities
	ld a, [wBuffer1]

	; If a is 255, always capture
	inc a
	jr z, .ok
	dec a
	ld b, a
.loop
	ld a, [hli]
	cp b
	jr z, .checkwobble
	jr nc, .use_previous
	inc hl
	jr .loop

.use_previous
	dec hl
	dec hl

.checkwobble
	ld b, [hl]
	call Random
	cp b
	ld c, 2 ; escaped
	ret nc

.ok
	; Check how many wobbles we've done so far. If this would've been our 4th,
	; we've successfully caught the Pokémon.
	ld c, 0 ; shake
	ld a, [wBuffer2]
	inc a
.critical_shake
	ld [wBuffer2], a
	cp 4
	ret c

	inc c ; captured
	ret

.WobbleProbabilities:
; With a catch rate of a, each wobble is calculated
; as happening if a random number 0-255 <= b.
; b is 256/(255/a)^0.1875, so use a lookup table.
;        a,   b
	db   1,  90
	db   2, 103
	db   3, 111
	db   4, 117
	db   5, 122
	db   6, 126
	db   7, 130
	db   8, 133
	db   9, 136
	db  10, 139
	db  11, 141
	db  12, 144
	db  13, 146
	db  14, 148
	db  15, 150
	db  16, 152
	db  17, 154
	db  18, 155
	db  19, 157
	db  20, 158
	db  21, 160
	db  22, 161
	db  23, 163
	db  24, 164
	db  25, 165
	db  26, 166
	db  27, 168
	db  28, 169
	db  29, 170
	db  30, 171
	db  31, 172
	db  32, 173
	db  33, 174
	db  34, 175
	db  35, 176
	db  36, 177
	db  37, 178
	db  38, 179
	db  39, 180
	db  41, 181
	db  42, 182
	db  43, 183
	db  44, 184
	db  46, 185
	db  47, 186
	db  48, 187
	db  50, 188
	db  51, 189
	db  52, 190
	db  54, 191
	db  55, 192
	db  57, 193
	db  59, 194
	db  60, 195
	db  62, 196
	db  64, 197
	db  65, 198
	db  67, 199
	db  69, 200
	db  71, 201
	db  73, 202
	db  75, 203
	db  76, 204
	db  78, 205
	db  81, 206
	db  83, 207
	db  85, 208
	db  87, 209
	db  89, 210
	db  91, 211
	db  94, 212
	db  96, 213
	db  99, 214
	db 101, 215
	db 104, 216
	db 106, 217
	db 109, 218
	db 111, 219
	db 114, 220
	db 117, 221
	db 120, 222
	db 123, 223
	db 126, 224
	db 129, 225
	db 132, 226
	db 135, 227
	db 138, 228
	db 141, 229
	db 145, 230
	db 148, 231
	db 151, 232
	db 155, 233
	db 158, 234
	db 162, 235
	db 166, 236
	db 170, 237
	db 173, 238
	db 177, 239
	db 181, 240
	db 185, 241
	db 189, 242
	db 194, 243
	db 198, 244
	db 202, 245
	db 207, 246
	db 211, 247
	db 216, 248
	db 220, 249
	db 225, 250
	db 230, 251
	db 235, 252
	db 240, 253
	db 245, 254
	db 250, 255
	db 255, 255
