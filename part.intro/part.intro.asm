	define LOGO_WIDTH 16
	define LOGO_HEIGHT 5
	define LOGO_SPEED 4 ; Четное!

	ld a, %01000111
	ld hl, #5800 : ld de, #5801 : ld bc, #02ff : ld (hl), a : ldir

	; bottom line color
	ld hl, #5900 : ld de, #5901 : ld bc, #0020 : ld (hl), %00000111 : ldir
	ld bc, #001f : ld (hl), 0 : ldir

	; copying "CREATIVE MEDIA DEMOMAKING CREW" text
	ld hl, CMDC
	ld de, #4820
	ld b, 8
1	push bc
	push de
	ld bc, 32 : ldir
	pop de : call lib.DownDE
	pop bc : djnz 1b

	; sprite
	ld b, 16
1	push bc
	call moveSprite
	dup LOGO_SPEED: halt : edup
	pop bc
	djnz 1b

	; logo + sprite + bottom line + cmdc
	ld b, 180
1	push bc
	ld bc, 30000 : call lib.Delay
	call moveSprite 
	call moveLogo
	call bottomLine
	dup LOGO_SPEED / 2: halt : edup
	call bottomLine
	call dispCmdc
	dup LOGO_SPEED / 2: halt : edup	
	pop bc
	djnz 1b

	ret

	; display "CREATIVE MEDIA DEMOMAKING CREW"
dispCmdc	ld a, 147 : or a : jr z, cmdcIsDone : dec a :  ld (dispCmdc + 1), a : ret
cmdcIsDone	ld a, (cmdcA2 + 1) : cp #40 : ret z
cmdcA1	ld hl, ATTR1
cmdcA2	ld de, #5920
	ldi
	ld hl, cmdcA1 + 1 : inc (hl)
	ld hl, cmdcA2 + 1 : inc (hl)
	ret

bottomLine	ld a, 104 : or a : jr z, blIsDone : dec a :  ld (bottomLine + 1), a : ret
blIsDone	ld a, (blA + 1) : cp 32 : ret z
blStage	ld a, #ff : inc a : and 7 : ld (blStage + 1), a
blA	ld hl, #4800
	cp 7 : jr z, bl7
	cp 6 : jr z, bl6
	cp 5 : jr z, bl5
	cp 4 : jr z, bl4
	cp 3 : jr z, bl3
	cp 2 : jr z, bl2
	cp 1 : jr z, bl1
	ld (hl), %10000000 : ret
bl1	ld (hl), %11000000 : ret
bl2	ld (hl), %11100000 : ret
bl3	ld (hl), %11110000 : ret
bl4	ld (hl), %11111000 : ret
bl5	ld (hl), %11111100 : ret
bl6	ld (hl), %11111110 : ret
bl7	ld (hl), %11111111
	ld hl, blA + 1 : inc (hl)
	ret

moveLogo	ld a, 255 : inc a : ld (moveLogo+1), a
	cp LOGO_WIDTH * 8 : jr c, ml2
	and %00000111 : jr nz, msl_1
	call prepareBuf
	ld hl, msl_1 + 1 : inc (hl)
msl_1	ld de, #4060
	call dispBuff
	jp rrBuf
ml2	and %00000111 : jr nz, ml2_1
	call prepareBuf 
	call prepDispBuff
ml2_1	ld de, #4060
	call dispBuff
	jp rrBuf

moveSprite	ld a, 255 : inc a : ld (moveSprite+1), a
	cp 24 : jr c, ms2
	and %00000111 : jr nz, ms1_1
	call prepareSprBuf
	ld hl, ms1_1 + 1 : inc (hl)
ms1_1	ld de, #40a0
	call dispSprBuff
	jp rrSprBuf
ms2	and %00000111 : jr nz, ms2_1
	call prepareSprBuf 
	call prepDispSprBuff
ms2_1	ld de, #40a0
	call dispSprBuff
	jp rrSprBuf

prepareSprBuf	ld hl, SPRITE
	ld de, SPR_BUFF
	ld bc, 3*3*8*4
	ldir
	ret

rrSprBuf	ld hl, SPR_BUFF
	ld a, 3*8*4
1	scf : ccf ; reset carry
	dup 3
	rr (hl)
	inc hl
	edup
	dec a : jr nz, 1b
	ret

prepDispSprBuff	ld a, 3
	or a : jr z, $+6
	dec a : ld (prepDispSprBuff+1), a

	ld (dsBuff2+1), a

	ld hl, dsBuff3+1
	ld (hl), a
	inc hl

	ld c, a
	ld a, 3
	sub c
	ld (dsBuff1+1), a
	ret

dispSprBuff	ld a, 0 : inc a : and 3 : ld (dispSprBuff+1), a
dsBuff3	ld hl, SPR_BUFF	
	ld bc, 3*3*8
_nextFrm1	or a : jr z, _nextFrm2
	add hl, bc
	dec a 
	jr _nextFrm1
_nextFrm2	push de
	ld a, 3*8
1	push af
	push de
	ld b, 0
dsBuff1	ld c, 3
	ldir
dsBuff2	ld bc, 0
	add hl, bc
	pop de
	call lib.DownDE
	pop af
	dec a : jr nz, 1b
	pop de
	ret

prepareBuf	ld hl, SCR
	ld de, BUFF
	ld bc, LOGO_WIDTH*LOGO_HEIGHT*8
	ldir
	ret

rrBuf	ld hl, BUFF
	ld a, LOGO_HEIGHT*8
1	scf : ccf ; reset carry
	dup LOGO_WIDTH
	rr (hl)
	inc hl
	edup
	dec a : jr nz, 1b
	ret

prepDispBuff	ld a, LOGO_WIDTH
	or a : jr z, $+6
	dec a : ld (prepDispBuff+1), a

	ld (dBuff2+1), a

	ld hl, dBuff3+1
	ld (hl), a
	inc hl

	ld c, a
	ld a, LOGO_WIDTH
	sub c
	ld (dBuff1+1), a
	ret

dispBuff	push de
dBuff3	ld hl, BUFF	
	ld a, 8*LOGO_HEIGHT
1	push af
	push de
	ld b, 0
dBuff1	ld c, LOGO_WIDTH
	ldir
dBuff2	ld bc, 0
	add hl, bc
	pop de
	call lib.DownDE
	pop af
	dec a : jr nz, 1b
	pop de
	ret

ATTR1	incbin "res/attr1"
SCR	incbin "res/otsiders.bin"
SPRITE	incbin "res/sprite.bin"
CMDC	incbin "res/cmdc.bin"
	align #100
SPR_BUFF	block 3 * 3 * 8 * 4
	align #100

BUFF	block (LOGO_WIDTH + 3) * LOGO_HEIGHT * 8 * 4

