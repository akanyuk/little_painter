	jp interruptsAddr ; возвращает адрес процедуры на прерываниях
	jp main
	; $+6 fade
	; b - delay between fading regions
	push bc
	ld hl, #5810 : ld a, %01111111 : call fillAttr8x8	
	pop bc : push bc : halt : djnz $-1
	ld hl, #5808 : ld a, %01111111 : call fillAttr8x8	
	pop bc : push bc : halt : djnz $-1
	ld hl, #5800 : ld a, %01111111 : call fillAttr8x8	
	pop af : sra a : ld b, a : halt : djnz $-1
	ld hl, #5818 : ld a, %01111111 : call fillAttr8x8	
	ret

main	ld hl, BG1 : ld de, #4000 : ld a, 160 : call dispBG
	ld de, #5800 : ld bc, 32*20 : ldir

	; ld b, 120 : halt : djnz $-1

	ld a, 2 : ld bc, 0*256 + 1 : call PLAYER + 3
	; ld b, 160 : halt : djnz $-1
	ld a, 2 + 12 : ld bc, 1*256 + 1 : call PLAYER + 3

	; ld b, 160 : halt : djnz $-1

	; phase 2

	ld hl, RND1
1	push hl
	push hl
	push hl
	push hl
	ld a, (hl)
	call rndPhase2_0
	halt 
	pop hl
	ld a, 10 : add l : ld l, a
	ld a, (hl)
	call rndPhase2_1
	halt 
	pop hl
	ld a, 20 : add l : ld l, a
	ld a, (hl)
	call rndPhase2_2
	halt 
	pop hl
	ld a, 30 : add l : ld l, a
	ld a, (hl)
	call rndPhase2_3
	halt 
	pop hl : inc hl
	ld a, l : cp 64 : jr nz, 1b

	ld b, 40 : halt : djnz $-1

	ld hl, #5800 : ld a, %01111000 : call fillAttr8x8
	ld hl, #4000 : call clear8x8

	ld b, 40 : halt : djnz $-1

	ld hl, #4018 : call clear8x8
	ld hl, #5818 : ld a, %01111000 : call fillAttr8x8

	ld b, 80 : halt : djnz $-1

	; di : halt

	ld a, 3 : ld bc, 0*256 + 1 : call PLAYER + 3
	ld a, 3 + 12 : ld bc, 1*256 + 1 : call PLAYER + 3

	ld b, 160 : halt : djnz $-1

	; phase 3

	ld hl, #5800 : ld a, %01111000 : call fillAttr8x8	
	ld hl, #5800 + 24 : ld a, %01111000 : call fillAttr8x8	
	ld hl, #4000 : call clear8x8
	ld hl, #4000 + 24 : call clear8x8
	ld hl, BG3 : ld de, #4800 : ld a, 96 : call dispBG
	ld de, #5900 : ld bc, 32*12 : ldir

	ld a, 0 : ld bc, 0*256 + 1 : call PLAYER + 3
	ld a, 0 + 12 : ld bc, 1*256 + 1 : call PLAYER + 3

	ld a, 1 : ld bc, 0*256 + 1 : call PLAYER + 3
	ld a, 1 + 12 : ld bc, 1*256 + 1 : call PLAYER + 3

	ld b, 160 : halt : djnz $-1

	ld a, 2 + 12 : ld bc, 5*256 + 1 : call PLAYER + 3
	ld a, 1 + 12 : ld bc, 4*256 + 1 : call PLAYER + 3
	ld a, 3 + 12 : ld bc, 6*256 + 1 : call PLAYER + 3
	ld a, 0 + 12 : ld bc, 5*256 + 1 : call PLAYER + 3

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
BG3	incbin "res/bg3.bin"

rndPhase2_0	push af
	push af
	ld hl, PHS2_R0
	ld de, #4800
	call lineRND
	pop af 
	ld c, a
	and %0000111 : ld e, a
	ld a, c 
	and %11111000
	rl a : rl a
	add e : ld e, a
	ld hl, #5900
	ld d, 0 : add hl, de : ex de, hl
	pop af
	ld hl, PHS2_R0_ATTR
	ld b, 0 : ld c, a
	add hl, bc
	ldi
	ret

rndPhase2_1	push af
	push af
	ld hl, PHS2_R1
	ld de, #4008
	call lineRND
	pop af 
	ld c, a
	and %0000111 : ld e, a
	ld a, c 
	and %11111000
	rl a : rl a
	add e : ld e, a
	ld hl, #5808
	ld d, 0 : add hl, de : ex de, hl
	pop af
	ld hl, PHS2_R1_ATTR
	ld b, 0 : ld c, a
	add hl, bc
	ldi
	ret

rndPhase2_2	push af
	push af
	ld hl, PHS2_R2
	ld de, #4808
	call lineRND
	pop af 
	ld c, a
	and %0000111 : ld e, a
	ld a, c 
	and %11111000
	rl a : rl a
	add e : ld e, a
	ld hl, #5908
	ld d, 0 : add hl, de : ex de, hl
	pop af
	ld hl, PHS2_R2_ATTR
	ld b, 0 : ld c, a
	add hl, bc
	ldi
	ret

rndPhase2_3	push af
	push af
	ld hl, PHS2_R3
	ld de, #4818
	call lineRND
	pop af 
	ld c, a
	and %0000111 : ld e, a
	ld a, c 
	and %11111000
	rl a : rl a
	add e : ld e, a
	ld hl, #5918
	ld d, 0 : add hl, de : ex de, hl
	pop af
	ld hl, PHS2_R3_ATTR
	ld b, 0 : ld c, a
	add hl, bc
	ldi
	ret

	; hl - px data
	; bc - attr data
	; de - scr addr
lineRND	push af
	; down de by rnd lines
1	or a : jr z, 2f
	push af
	call lib.DownDE
	pop af 
	dec a
	jr 1b
2	ld a, e : ld (_lrndDE + 1), a
	ld a, d : ld (_lrndDE + 2), a
	pop af
	ld de, #0008
1	or a : jr z, 2f
	add hl, de
	dec a
	jr 1b
2	
_lrndDE	ld de, #0000
	ld bc, 8
	ldir
	ret
	align #100
RND1	include "rnd1.asm"		

	; hl - attr data
	; de - attr addr
phs64x64attr	ld a, 8
1	ld bc, 8
	ldir
	push hl
	ld hl, 24 : add hl, de : ex de, hl
	pop hl
	dec a : jr nz, 1b
	ret

	; hl - px data
	; bc - attr data
	; de - scr addr
phase66x64	push de
	ld a, c : ld (_phs64x64addr + 1), a
	ld a, b : ld (_phs64x64addr + 2), a
	ld a, 64
1	push af
	push de
	ld bc, 8
	ldir
	pop de
	call lib.DownDE
	pop af : dec a : jr nz, 1b
	; attrs
_phs64x64addr	ld hl, PHS2_R1_ATTR
	pop de
	ld  a, d : rrca : rrca : rrca : and 3 : or #58 : ld d, a ; scr -> attr
	ld a, 8
1	ld bc, 8
	ldir
	dup 24 : inc de : edup
	dec a : jr nz, 1b
	ret

PHS2_R0_ATTR	equ $+512 + 64
PHS2_R0	incbin "res/phase2-reg0.bin", 512

PHS2_R2_ATTR	equ $+1024 + 64
PHS2_R2	equ $+512
PHS2_R1_ATTR	equ $+1024
PHS2_R1	incbin "res/phase2-reg1.bin"

PHS2_R3_ATTR	equ $+512
PHS2_R3	incbin "res/phase2-reg2.bin"
