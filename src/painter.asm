Init	
	ld a, %00000101 : call SetScreenAttr
                ld iy, TRANSITION0_DATA : call Transition
	ld a, %00101101 : call SetScreenAttr
	xor a : ld (FillScreenBy), a : call FillScreen
	ld a, %00101000 : call SetScreenAttr
	ld hl, #4000 : ld de, #c000 : ld bc, #1b00 : ldir
	ret

End	xor a : call lib.SetScreen
	ld a, %00101101 : call SetScreenAttr
	ld a, #ff : ld (FillScreenBy), a : call FillScreen
	ld a, %00000101 : call SetScreenAttr
	ld iy, TRANSITION1_DATA : call Transition
	ret

FillScreen	ld hl, #5080
	ld a, 32
1	push af
	push hl
	ld d, h : ld e, l : inc e
	ld bc, #001f 
FillScreenBy	equ $+1
	ld (hl), 0
	ldir
	pop hl
	call lib.DownHL
	pop af : dec a : jr nz, 1b
	ret
SetScreenAttr	ld hl, #5a80 : ld de, #5a81 : ld bc, #007f : ld (hl), a : ldir
	ret

CopyAltScr
	ld hl, #5080
	ld de, #d080	
	ld a, 32
1	push af
	push hl, de
	ld bc, #0020
	ldir
	pop de, hl
	call lib.DownHL
	call lib.DownDE
	pop af
	dec a
	jr nz, 1b
	ret

Interrupts	include "painter_interrupts.asm"
Transition	include "src/painter_transitions.asm"

	module slow_player
	include "res/painter-anima/player.asm"
	endmodule