	jp interruptsAddr ; возвращает адрес процедуры на прерываниях

	; $+3 main 
	ld hl, #d900
	ld a, %01000111
	call fillAttr8x8
	ld a, 4 : ld bc, 0*256 + 1 : call PLAYER + 3
	ld a, 4 + 12 : ld bc, 2*256 + 1 : call PLAYER + 3

	ld b, 160 : halt : djnz $-1

	ld hl, #d908
	ld a, %01000011
	call fillAttr8x8
	ld a, 5 : ld bc, 0*256 + 1 : call PLAYER + 3
	ld a, 5 + 12 : ld bc, 2*256 + 1 : call PLAYER + 3

	ld b, 160 : halt : djnz $-1

	ld hl, #d910
	ld a, %01000100
	call fillAttr8x8
	ld a, 6 : ld bc, 0*256 + 1 : call PLAYER + 3
	ld a, 6 + 12 : ld bc, 2*256 + 1 : call PLAYER + 3

	ld b, 160 : halt : djnz $-1

	ld hl, #d918
	ld a, %01000110
	call fillAttr8x8
	ld a, 7 : ld bc, 0*256 + 1 : call PLAYER + 3
	ld a, 7 + 12 : ld bc, 2*256 + 1 : call PLAYER + 3

	ld b, 200 : halt : djnz $-1

	ld hl, #d900 : xor a : call fillAttr8x8
	ld b, 40 : halt : djnz $-1

	ld hl, #d908 : xor a : call fillAttr8x8
	ld b, 40 : halt : djnz $-1

	ld hl, #d910 : xor a : call fillAttr8x8
	ld b, 40 : halt : djnz $-1

	ld hl, #d918 : xor a : call fillAttr8x8
	ld b, 40 : halt : djnz $-1

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
