	device zxspectrum128

PART_START  	equ #7500

	org #6000
start	module lib
	include "../lib/shared.asm"	
	endmodule
	
	ei
	ld sp, start
	ld a, 0 : out (#fe), a

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

	call PART_START
	; call PART_START + 3
	; ld b, 200 : halt : djnz $-1
	call PART_START + 6
	; ld b, 20 : halt : djnz $-1
	call PART_START + 9	

	xor a : out (#fe), a

	di : halt

	org PART_START
	include "part.scr4.asm"
	display /d, 'Part length: ', $ - PART_START

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	;  LABELSLIST "user.l"
	  savesna SNA_FILENAME, start	      ; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, PART_START, $-PART_START  ; BIN_FILENAME defined in Makefile
	endif
	