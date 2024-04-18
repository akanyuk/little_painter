	device zxspectrum128

PART_START  	equ #7500

	org #6000
start	module lib
	include "../lib/shared.asm"	
	endmodule
	
	ei
	ld sp, start
	ld a, 0 : out (#fe), a

	; prepare screen from previous part
	ld hl, #5800 : ld de, #5801 : ld bc, #02ff : ld (hl), %01000110 : ldir

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

	; prepare screen from previous part
	ld hl, #5900 : ld de, #5901 : ld bc, #00ff : ld (hl), %01000110 : ldir
	
	ld a, 32
	ld hl, #4800
1	push af
	push hl
	ld d, h
	ld e, l
	inc de
	ld (hl), #ff
	ld bc, #001f
	ldir
	pop hl
	call lib.DownHL
	pop af : dec a : jr nz, 1b

	ld a, 7 : call lib.SetPage
	ld hl, #4000 : ld de, #c000 : ld bc, #1b00 : ldir
	ld a, 0 : call lib.SetPage

	call PART_START
	
	ld b, 100
1	push bc
	call PART_START + 3
	halt
	pop bc
	djnz 1b

	ld b, 150
1	push bc
	call PART_START + 3
	call PART_START + 3
	halt
	pop bc
	djnz 1b

	ld b, 50
1	push bc
	call PART_START + 3
	call PART_START + 3
	call PART_START + 3
	halt
	pop bc
	djnz 1b

	ld a, 1 : out (#fe), a

	di : halt

	org PART_START
	include "part.lastcit.asm"
	display /d, 'Part length: ', $ - PART_START

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	;  LABELSLIST "user.l"
	  savesna SNA_FILENAME, start	      ; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, PART_START, $-PART_START  ; BIN_FILENAME defined in Makefile
	endif
	