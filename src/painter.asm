Init	ld a, %00000101 : call SetScreenAttr
                ; ld iy, TRANSITION0_DATA : call transition
	ld a, %00101101 : call SetScreenAttr

	; TEMPORARY! Full bg
	ld hl, FULL_BG
	ld de, #5080
	ld a, 32
1	push af
	push de
	ld bc, 32
	ldir
	pop de
	call lib.DownDE
	pop af : dec a : jr nz, 1b

	ld a, %00101000 : call SetScreenAttr

	ld hl, #4000 : ld de, #c000 : ld bc, #1b00 : ldir
	ret

End	xor a : call lib.SetScreen
	ld a, %00101101 : call SetScreenAttr
	ld a, #ff : ld (FillScreen), a : call ClearScreen
	ld a, %00000101 : call SetScreenAttr
	ld iy, TRANSITION1_DATA : call transition
	ret

ClearScreen	ld hl, #5080
	ld a, 32
1	push af
	push hl
	ld d, h : ld e, l : inc e
	ld bc, #001f 
FillScreen	equ $+1
	ld (hl), 0
	ldir
	pop hl
	call lib.DownHL
	pop af : dec a : jr nz, 1b
	ret

SetScreenAttr
	ld hl, #5a80 : ld de, #5a81 : ld bc, #007f : ld (hl), a : ldir
	ret

transition	include "src/painter_transitions.asm"

	; Процедура на прерываниях
Interrupts	
_is	ld a, 0 : inc a : and 7 : ld (_is + 1), a : or a : ret nz

rrSpriteStage	equ $+1
	ld a, 7 : inc a : and 7 : ld (rrSpriteStage), a
	or a : jr nz, 1f
	call fillSpriteBuf
	jr 2f
1	call rrSpriteBuf
2	call dispSpriteBuf
	ret

fillSpriteBuf	ld hl, SPRITE1
	ld de, SPRITE_BUF
	ld bc, 32*6
	ldir
	ret

rrSpriteBuf	
	ld hl, SPRITE_BUF
	ld a, 32
1	scf : ccf ; reset carry
	dup 3
	rr (hl) : inc hl
	edup
	scf : ccf ; reset carry
	dup 3
	rr (hl) : inc hl
	edup
	dec a : jr nz, 1b
	ret

dispSpriteBuf	ld a, (_dispSprAddr) : res 7, a : ld (_dispSprAddr), a
	call _dispSpriteBuf
	ld a, (_dispSprAddr) : set 7, a : ld (_dispSprAddr), a
_dispSpriteBuf	ld hl, SPRITE_BUF
_dispSprAddr	equ $+2
	ld de, #5280
	ld a, 30
1	push af
	push de	
	ldi : ldi : ldi
	inc hl : inc hl : inc hl
	pop de 
	call lib.DownDE
	pop af
	dec a
	jr nz, 1b

SPRITE_BUF	block 32*6

FULL_BG	incbin "res/picasso/bg_full.bin"
SPRITE1	incbin "res/picasso/sprite1.bin"
