	device zxspectrum128
	page 0

	define DEBUG 1

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
	ld a,#5c : ld i,a : ld hl,interr : ld (#5cff),hl : im 2 : ei

	call A_PART_WORMS_INIT
.loop	
	call lib.ClearScreen
	ld a, %01000000 : call lib.SetScreenAttr

	call painterPlaceholder

	call A_PART_WORMS_SCENE1
	ld a, 15 : call mainShow

	call lib.ClearScreen
	ld a, %01000000 : call lib.SetScreenAttr

	call painterPlaceholder

	call A_PART_WORMS_SCENE2
	ld a, 15 : call mainShow

	call lib.ClearScreen
	ld a, %01000000 : call lib.SetScreenAttr

	call painterPlaceholder

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

painterPlaceholder
	ld a, %01101000
	ld (#5aff), a
	ld (#5afe), a
	ld (#5afd), a
	ld (#5adf), a
	ld (#5ade), a
	ld (#5add), a
	ld (#5abf), a
	ld (#5abe), a
	ld (#5abd), a
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
