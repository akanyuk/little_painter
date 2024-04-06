	device zxspectrum128

PART_START  	equ #7500

	org #6000
start	module lib
	include "../lib/shared.asm"	
	endmodule
	
	ei
	ld sp, start

	ld a, 0 : out (#fe), a

	call PART_START
	call PART_START + 3
	ld b, 200 : halt : djnz $-1
	call PART_START + 6

	xor a : out (#fe), a

	di : halt

	org PART_START
	include "part.scr3.asm"
	display /d, 'Part length: ', $ - PART_START

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	;  LABELSLIST "user.l"
	  savesna SNA_FILENAME, start	      ; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, PART_START, $-PART_START  ; BIN_FILENAME defined in Makefile
	endif
	