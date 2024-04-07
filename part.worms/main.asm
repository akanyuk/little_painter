	device zxspectrum128
	page 0

	; define DEBUG 1

A_PART_WORMS  	equ #7500
A_PART_WORMS_INIT   	equ A_PART_WORMS 
A_PART_WORMS_MAIN 	equ A_PART_WORMS + 3
A_PART_WORMS_STOP   	equ A_PART_WORMS + 6
A_PART_WORMS_SCENE1 	equ A_PART_WORMS + 9
A_PART_WORMS_SCENE2	equ A_PART_WORMS + 12
A_PART_WORMS_SCENE3	equ A_PART_WORMS + 15
A_PART_WORMS_SCENE4 	equ A_PART_WORMS + 18
A_PART_WORMS_SCENE5 	equ A_PART_WORMS + 21

	module consts
WormsTables	equ #7c00
	endmodule

	org #6000
start
	module lib
	include "../lib/shared.asm"	
	endmodule

	di : ld sp, start
	xor a : out (#fe), a

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

	ld a,#5c : ld i,a : ld hl,interr : ld (#5cff),hl : im 2 : ei

	call A_PART_WORMS_INIT
.loop	
	call lib.ClearScreen
	ld a, %01000000 : call lib.SetScreenAttr

	call A_PART_WORMS_SCENE1
	ld a, 15 : call mainShow

	call lib.ClearScreen
	ld a, %01000000 : call lib.SetScreenAttr

	call A_PART_WORMS_SCENE2
	ld a, 15 : call mainShow

	call lib.ClearScreen
	ld a, %01000000 : call lib.SetScreenAttr

	call A_PART_WORMS_SCENE3
	ld a, 15 : call mainShow

	ld a, %00111111 : call lib.SetScreenAttr
	ld a, #07 : out (#fe), a
	call lib.ClearScreen
	halt : halt
	ld a, %01000000 : call lib.SetScreenAttr
	xor a : out (#fe), a

	call A_PART_WORMS_SCENE4
	ld a, 10 : call mainShow

	ld a, %00111111 : call lib.SetScreenAttr
	ld a, #07 : out (#fe), a
	call lib.ClearScreen
	halt : halt
	ld a, %01000000 : call lib.SetScreenAttr
	xor a : out (#fe), a

	call A_PART_WORMS_SCENE5
	ld a, 10 : call mainShow

	jr .loop

	; PARAMS:
	; A - frames to end moving
mainShow	ld (mainStopWaiter + 1), a

1	halt
	ifdef DEBUG : ld a, #01 : out (#fe), a : endif
	call A_PART_WORMS_MAIN
	ifdef DEBUG : ld a, #01 : out (#fe), a : endif
	; exit on "SPACE" or "0"
	ld a, #7f : in a, (#fe) ; "space"
	and #01 : cp #01 : jr z, 1b

	call A_PART_WORMS_STOP
	
mainStopWaiter	ld b, #00
1	push bc
	halt
	call A_PART_WORMS_MAIN
	pop bc 
	djnz 1b
	ret

interr	ei
	ret

	org A_PART_WORMS
	include "part.worms.asm"
	display /d, 'Part length: ', $ - A_PART_WORMS
	display 'Part ended at: ', $

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	;  LABELSLIST "user.l"
	  savesna SNA_FILENAME, start	         ; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, A_PART_WORMS, $-A_PART_WORMS ; BIN_FILENAME defined in Makefile
	endif
