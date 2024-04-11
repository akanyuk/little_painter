	jp interruptsAddr ; возвращает адрес процедуры на прерываниях
	jp main
	; $+6 fade
	; b - delay between fading regions
	push bc
	ld hl, #5810 : ld a, %01111111 : call fillAttr8x8	
	pop bc : push bc : halt : djnz $-1
	ld hl, #5808 : ld a, %01111111 : call fillAttr8x8	
	pop bc : halt : djnz $-1
	ld hl, #5800 : ld a, %01111111 : call fillAttr8x8	
	ld hl, #5818 : ld a, %01111111 : call fillAttr8x8	
	ret

main	ld hl, BG1 : ld de, #4000 : ld a, 160 : call dispBG
	ld de, #5800 : ld bc, 32*20 : ldir

	ld b, 120 : halt : djnz $-1

	ld a, 2 : ld bc, 0*256 + 1 : call PLAYER + 3
	ld a, 2 + 12 : ld bc, 2*256 + 1 : call PLAYER + 3

	ld b, 160 : halt : djnz $-1
	ld b, 160 : halt : djnz $-1
	ld b, 160 : halt : djnz $-1

	; phase 2

	ld hl, BG2 : ld de, #4000 : ld a, 128 : call dispBG
	ld de, #5800 : ld bc, 32*16 : ldir

	ld a, 1 : ld bc, 0*256 + 1 : call PLAYER + 3
	ld a, 1 + 12 : ld bc, 2*256 + 1 : call PLAYER + 3

	ld b, 160 : halt : djnz $-1
	ld b, 160 : halt : djnz $-1

	; phase 3

	ld hl, #5800 : ld a, %01111000 : call fillAttr8x8	
	ld hl, #5800 + 24 : ld a, %01111000 : call fillAttr8x8	
	ld hl, #4000 : call clear8x8
	ld hl, #4000 + 24 : call clear8x8
	ld hl, BG3 : ld de, #4800 : ld a, 96 : call dispBG
	ld de, #5900 : ld bc, 32*12 : ldir

	ld a, 0 : ld bc, 0*256 + 1 : call PLAYER + 3
	ld a, 0 + 12 : ld bc, 2*256 + 1 : call PLAYER + 3

	ld a, 3 : ld bc, 0*256 + 1 : call PLAYER + 3
	ld a, 3 + 12 : ld bc, 2*256 + 1 : call PLAYER + 3
	ret

	; hl: screen address
clear8x8	ld a, 64
1	push af
	push hl
	ld d, h : ld e, l : inc e
	ld (hl), 0
	ld bc, 8
	ldir
	pop hl
	call lib.DownHL
	pop af : dec a : jr nz, 1b
	ret

	; hl: screen address
	; a: color
fillAttr8x8	ld de, #0020
	ld b, 8
1	push bc
	ld b, 8
	push hl
2	ld (hl), a
	inc hl
	djnz 2b
	pop hl
	add hl, de
	pop bc
	djnz 1b
	ret

interruptsAddr	ld hl, interr : ret
interr	ld a, 0 : inc a : and 1 : ld (interr + 1), a
	or a : ret z
PLAYER	include "player.asm"
	; showing background
dispBG	
1	push af
	push de
	ld bc, 32
	ldir
	pop de
	call lib.DownDE
	pop af : dec a : jr nz, 1b
	ret
BG1	incbin "res/bg1.bin"
BG2	incbin "res/bg2.bin"
BG3	incbin "res/bg3.bin"