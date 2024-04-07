Init	ld a, %00000101 : call SetScreenAttr
                ld iy, TRANSITION0_DATA : call transition
	ld a, %00101101 : call SetScreenAttr
	call ClearScreen
	ld a, %00101000 : call SetScreenAttr

	ld hl, #4000 : ld de, #c000 : ld bc, #1b00 : ldir
	ret

End	xor a : call lib.SetScreen
	ld a, %00101101 : call SetScreenAttr
	ld a, #ff : ld (FillScreen), a : call ClearScreen
	xor a : ld (FillScreen), a	
	ld a, %00000101 : call SetScreenAttr
	ld iy, TRANSITION1_DATA : call transition
	ret

	; Процедура на прерываниях
Interrupts	
_is	ld a, 0 : inc a : and 7 : ld (_is + 1), a : or a : ret nz

_i1	ld hl, #0000 : inc l : ld (_i1 + 1), hl
	ld de, #549b
	ld a, 24
1	push af
	push hl
	push de
	ld bc, 4 : ldir
	
	; move to alt screen
	pop de
	pop hl
	push hl
	push de
	ld a, d : or #80 : ld d, a
	ld bc, 4 : ldir

	pop de
	call lib.DownDE
	pop hl
	inc hl
	pop af : dec a : jr nz, 1b
	
	ret

ClearScreen	ld hl, #5080
	ld a, 32
1	push af
	push hl
	ld d, h : ld e, l : inc e
	ld bc, #001f 
FillScreen	equ $+1
	ld (hl), 0
	ldir
	pop hl
	call lib.DownHL
	pop af : dec a : jr nz, 1b
	ret

SetScreenAttr
	ld hl, #5a80 : ld de, #5a81 : ld bc, #007f : ld (hl), a : ldir
	ret

	include "src/painter_transitions.asm"