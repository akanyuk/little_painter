	device zxspectrum128

	org #6000
start	module lib
	include "../lib/shared.asm"	
	endmodule

	define VIEWER_START     lib.ChunksView
	define VIEWER_INIT      VIEWER_START
	define VIEWER_DISPLAY   VIEWER_START + 3
	define VIEWER_BRIGHT    VIEWER_START + 6

	ei
	ld sp, start
	xor a : out (#fe), a

	call PART_SCR1
	call PART_SCR1 + 3
	ld b, 200 : halt : djnz $-1
	call PART_SCR1 + 6

	di : halt

PART_SCR1	include "part.scr1.asm"

	display /d, 'Part length: ', $ - VIEWER_START

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	;  LABELSLIST "user.l"
	  savesna SNA_FILENAME, start	      ; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, VIEWER_START, $-VIEWER_START  ; BIN_FILENAME defined in Makefile
	endif
	