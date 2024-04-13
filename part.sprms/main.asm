	device zxspectrum128

	; define DEBUG 1

PART_START	equ  #7500

	org #6000
start	module lib
	include "../lib/shared.asm"	
	endmodule

	di : ld sp, start
	ld a, 0 : out #fe, a

	; painter placeholder
	ld hl, ppPlaceholder
1	ld a, (hl) : or a : jr z, _ppPlaceholder
	inc hl : rst 16 : jr 1b
ppPlaceholder 	db 22, 1, 1, "Pocket Painter"
	db 22, 2, 6, "Pocket Painter"
	db 22, 3, 11, "Pocket Painter"
	db 22, 4, 16, "Pocket Painter"
	db 0
_ppPlaceholder
	ld hl, #5a80 : ld de, #5a81 : ld bc, #007f : ld (hl), %00101000 : ldir
	ld a, 7 : call lib.SetPage
	ld hl, #4000 : ld de, #c000 : ld bc, #1b00 : ldir
	ld a, 0 : call lib.SetPage

	ld a,#5c, i,a, hl,interr, (#5cff),hl : im 2 : ei

	call PART_START ; hl - адрес процедуры на прерываниях
	call interrStart	
	call PART_START + 3

	; ld b, 160 : halt : djnz $-1
	ld b, 160 : halt : djnz $-1
	
	ld b, 50 : call PART_START + 6

	jr $

	; запуск нужной процедуры на прерываниях
	; HL - адрес процедура
interrStart	ld a, #cd : ld (interrCurrent), a ; call
	ld a, l : ld (interrCurrent + 1), a
	ld a, h : ld (interrCurrent + 2), a
	ret

interr	di
	push af,bc,de,hl,ix,iy
	exx : ex af, af'
	push af,bc,de,hl,ix,iy

	ifdef DEBUG
	ld a, #01 : out (#fe), a
	endif

interrCurrent	nop : nop : nop

	ifdef DEBUG
	ld a, #02 : out (#fe), a
	endif

	pop iy,ix,hl,de,bc,af
	exx : ex af, af'
	pop iy,ix,hl,de,bc,af
	ei
	ret

	display $

	org PART_START
	module sprms
	include "part.sprms.asm"
	endmodule
	
	display /d, 'Part length: ', $ - PART_START
	display 'Part ended at: ', $

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	  savesna SNA_FILENAME, start	  ; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, PART_START, $-PART_START  ; BIN_FILENAME defined in Makefile
	endif
