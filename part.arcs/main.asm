	device zxspectrum128
	page 0

	; define DEBUG 1

A_PART_ARCS  	equ #7500
A_PART_ARCS_INIT 	equ A_PART_ARCS
A_PART_ARCS_INIT2 	equ A_PART_ARCS + 3
A_PART_ARCS_MAIN   	equ A_PART_ARCS + 6

	org #6000
start
	module lib
	include "../lib/shared.asm"	
	endmodule

	di : ld sp, start
	xor a : out #fe, a
	call lib.SetScreenAttr

	ld a,#5c : ld i,a : ld hl,interr : ld (#5cff),hl : im 2 : ei

	ld a, 2 : ld c, %01001111 : call A_PART_ARCS_INIT
	ld b, 240 
1	push bc
	call A_PART_ARCS_MAIN
	halt
	pop bc : djnz 1b
	
	ld b, 50 : halt : djnz $-1

	ld a, 2 : ld c, %01010111 : ld a, 4 : call A_PART_ARCS_INIT
	ld bc, 320
1	push bc
	call A_PART_ARCS_MAIN
	halt
	pop bc 
	dec bc : ld a, b : or c : jr nz, 1b


	ld b, 100 : halt : djnz $-1

	ld a, 8 : call A_PART_ARCS_INIT2
1	call A_PART_ARCS_MAIN
	halt
	jr 1b

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
