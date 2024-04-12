	device zxspectrum128
	page 0

	; define DEBUG 1

A_PART_ARCS  	equ #7500
	org #6000
start
	module lib
	include "../lib/shared.asm"	
	endmodule

	di : ld sp, start
	ld a, 0 : out #fe, a
	call lib.SetScreenAttr

	ld a,#5c : ld i,a : ld hl,interr : ld (#5cff),hl : im 2 : ei

	; painter placeholder
	ld hl, ppPlaceholder
1	ld a, (hl) : or a : jr z, _ppPlaceholder
	inc hl
	rst 16
	jr 1b

ppPlaceholder 	db 22, 1, 1, "Pocket Painter"
	db 22, 2, 6, "Pocket Painter"
	db 22, 3, 11, "Pocket Painter"
	db 22, 4, 16, "Pocket Painter"
	db 0
_ppPlaceholder
	ld hl, #5a80
	ld de, #5a81
	ld bc, #007f
	ld (hl), %00101000
	ldir

	call A_PART_ARCS + 3
 	ld a, 25 : call A_PART_ARCS
	ld bc, 100 : call A_PART_ARCS + 12
	
	call A_PART_ARCS + 6
	ld a, %01000110 : call lib.SetScreenAttr	
 	ld a, 6 : call A_PART_ARCS
	ld bc, 20 : call A_PART_ARCS + 12	

	ld a, %01000111 : call lib.SetScreenAttr	
 	ld a, 4 : call A_PART_ARCS
	ld bc, 20 : call A_PART_ARCS + 12	

	ld a, %01000011 : call lib.SetScreenAttr	
 	ld a, 2 : call A_PART_ARCS
	ld bc, 20 : call A_PART_ARCS + 12	

	ld a, 16 : call A_PART_ARCS
	call A_PART_ARCS + 9
	ld bc, 800 : call A_PART_ARCS + 12

	di : halt


interr	ei : ret

	org A_PART_ARCS
	include "part.arcs.asm"
	display /d, 'Part length: ', $ - A_PART_ARCS
	display 'Part ended at: ', $
PART_ARCS_END	equ $

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	;  LABELSLIST "user.l"
	  savesna SNA_FILENAME, start	         	; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, A_PART_ARCS, PART_ARCS_END-A_PART_ARCS 	; BIN_FILENAME defined in Makefile
	endif
