	jp interruptsAddr ; возвращает адрес процедуры на прерываниях
	jp main
	; $+6 fade

	ld b, 24 : call fadeStage

	xor a : ld c, 0 : call PLAYER + 3
	ld a, 1 : ld c, 0 : call PLAYER + 3
	ld a, 2 : ld c, 0 : call PLAYER + 3
	ld a, 3 : ld c, 0 : call PLAYER + 3

	ld b, 8 : call fadeStage

	ld a, 0 + 12 : ld c, 0 : call PLAYER + 3
	ld a, 1 + 12 : ld c, 0 : call PLAYER + 3
	ld a, 2 + 12 : ld c, 0 : call PLAYER + 3
	ld a, 3 + 12 : ld c, 0 : call PLAYER + 3

	ld b, 1 : call fadeStage

	ld hl, #4000
	ld de, #4001
	ld bc, #07ff
	ld (hl), 0
	ldir

	ret

fadeStage	
2	push bc
fadeStageSeed	equ $+1
	ld hl, RND1
	ld a, 32
1	push af
	push hl
	push hl
	push hl
	push hl

	ld a, (hl)
	ld hl, #4000
	ld de, #5800
	call rndClear8x8

	pop hl
	ld a, 24 : add l : ld l, a
	ld a, (hl)
	ld hl, #4008
	ld de, #5808
	call rndClear8x8

	pop hl
	ld a, 27 : add l : ld l, a
	ld a, (hl)
	ld hl, #4010
	ld de, #5810
	call rndClear8x8

	pop hl
	ld a, 40 : add l : ld l, a
	ld a, (hl)
	ld hl, #4018
	ld de, #5818
	call rndClear8x8

	pop hl : inc hl
	pop af : dec a : jr nz, 1b

	halt 
	pop bc : djnz 2b

	ld a, l : ld (fadeStageSeed), a
	ret

main	
	ld a, 20
1	push af
	call bgUP2x
	halt
	call bgUP2x
	halt
	call bgUP2x
	call bgUpAttr
	halt
	call bgUP2x
	halt
	pop af
	dec a : jr nz, 1b

	ld b, 50 : halt : djnz $-1

	ld a, 2 : ld bc, 0*256 + 1 : call PLAYER + 3
	ld b, 160 : halt : djnz $-1
	ld a, 2 + 12 : ld bc, 1*256 + 1 : call PLAYER + 3

	ld b, 160 : halt : djnz $-1

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
	ld a, 8 : add l : ld l, a
	ld a, (hl)
	call rndPhase2_1
	halt 

	pop hl
	ld a, 16 : add l : ld l, a
	ld a, (hl)
	call rndPhase2_2
	halt 

	pop hl
	ld a, 32 : add l : ld l, a
	ld a, (hl)
	ld hl, #4000
	ld de, #5800
	call rndClear8x8
	halt 

	pop hl : inc hl
	ld a, l : cp 64 : jr nz, 1b

	ld b, 60 : halt : djnz $-1

	; phase 3

	ld a, 0 : ld bc, 0*256 + 1 : call PLAYER + 3
	ld a, 0 + 12 : ld bc, 1*256 + 1 : call PLAYER + 3

	ld b, 160 : halt : djnz $-1

	ld hl, RND1
1	push hl
	push hl
	push hl
	push hl
	ld a, (hl)
	call rndPhase3_0
	halt 

	pop hl
	ld a, 24 : add l : ld l, a
	ld a, (hl)
	call rndPhase2_3

	pop hl
	ld a, 27 : add l : ld l, a
	ld a, (hl)
	ld hl, #4008
	ld de, #5808
	call rndClear8x8
	halt 

	pop hl
	ld a, 40 : add l : ld l, a
	ld a, (hl)
	ld hl, #4018
	ld de, #5818
	call rndClear8x8
	halt 

	pop hl : inc hl
	ld a, l : cp 64 : jr nz, 1b

	ld b, 40 : halt : djnz $-1

	; finalle

	ld a, 1 : ld bc, 0*256 + 1 : call PLAYER + 3
	ld a, 1 + 12 : ld bc, 1*256 + 1 : call PLAYER + 3

	ld a, 3 : ld bc, 0*256 + 1 : call PLAYER + 3
	ld a, 3 + 12 : ld bc, 1*256 + 1 : call PLAYER + 3
	ret

interruptsAddr	ld hl, interr : ret
interr	ld a, 0 : inc a : and 1 : ld (interr + 1), a
	or a : ret z
PLAYER	include "player.asm"

BG1	incbin "res/bg1.bin"

bgUP2x	ld hl, BG1 + 160 * 32 - 32 * 2
_bgUP2DE	ld de, #5660
	push hl
	push de
	ld b, 2
1	push bc
	push de
	ld bc, 32
	ldir
	pop de
	call lib.DownDE
	pop bc
	djnz 1b
	pop hl
	call UpHL 
	call UpHL 
	ld (_bgUP2DE + 1), hl
	pop hl
	ld bc, 32*2
	sbc hl, bc
	ld (bgUP2x + 1), hl
	ret

bgUpAttr	ld hl, BG1 + 160 * 32 + 32 * 19
_bgUpAtDE	ld de, #5a60
	push hl
	push de
	ld bc, 32
	ldir
	pop hl
	ld de, 32
	sbc hl, de
	ld (_bgUpAtDE + 1), hl
	pop hl
	sbc hl, de
	ld (bgUpAttr + 1), hl
	ret

UpHL	dec h : ld a, h : cpl : and #07 : ret nz : ld a, l : sub #20 : ld l, a : ret c : ld a, h : add a, #08 : ld h,a : ret

	; hl - screen
	; de - attr
	; a - rnd
rndClear8x8	push de
	push af
1	or a : jr z, 2f
	push af
	call lib.DownHL
	pop af 
	dec a
	jr 1b
2	ld d, h : ld e, l : inc de
	ld (hl), 0
	ld bc, 7
	ldir

	pop af 
	ld c, a
	and %0000111 : ld e, a
	ld a, c 
	and %11111000
	rl a : rl a
	add e : ld e, a
	pop hl
	ld d, 0 : add hl, de
	ld (hl), %01111000
	ret

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

rndPhase3_0	push af
	push af
	ld hl, PHS3_R0
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
	ld hl, PHS3_R0_ATTR
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

PHS2_R0_ATTR	equ $+512 + 64
PHS2_R0	incbin "res/phase2-reg0.bin", 512

PHS2_R2_ATTR	equ $+1024 + 64
PHS2_R2	equ $+512
PHS2_R1_ATTR	equ $+1024
PHS2_R1	incbin "res/phase2-reg1.bin"

PHS2_R3_ATTR	equ $+512
PHS2_R3	incbin "res/phase2-reg2.bin"

PHS3_R0_ATTR	equ $+512
PHS3_R0	incbin "res/phase3-reg0.bin"
