	device zxspectrum128
	page 0

A_PART_INTRO  	equ #7000

	org #6000

start	module lib
	include "../lib/shared.asm"	
	endmodule

	di : ld sp, start
	ld a, 0 : out #fe, a

	ld a,#5c : ld i,a : ld hl,interr : ld (#5cff),hl : im 2 : ei

	call A_PART_INTRO
	
	di : halt

interr	di
	push af,bc,de,hl,ix,iy
	exx : ex af, af'
	push af,bc,de,hl,ix,iy

	nop

	pop iy,ix,hl,de,bc,af
	exx : ex af, af'
	pop iy,ix,hl,de,bc,af
	ei
	ret

	org A_PART_INTRO
	include "part.intro.asm"
	display /d, 'Part length: ', $ - A_PART_INTRO
A_PART_INTRO_END	equ $

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	;  LABELSLIST "user.l"
	  savesna SNA_FILENAME, start	         	; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, A_PART_INTRO, A_PART_INTRO_END - A_PART_INTRO ; BIN_FILENAME defined in Makefile
	endif
