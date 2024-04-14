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

CopyAltScr	ld hl, #5080
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

	; hl - sprite
	; a - x-coord
DispSpr96x32	ld d, #51
	ld e, #80 : add e : ld e, a
	ld a, 31
1	push af
	push de
	ld bc, 96/8
	ldir
	pop de
	call lib.DownDE
	pop af
	dec a
	jr nz, 1b
	ret

	; hl - sprite
	; a - x-coord
DispSpr32x32	ld d, #51
	ld e, #80 : add e : ld e, a
	ld a, 31
1	push af
	push de
	ld bc, 32/8
	ldir
	pop de
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

bgBiblio_96x32	incbin "res/painter/bg-biblio-01-96x32.pcx", 128
sPnt0_32x32	incbin "res/painter/spr-painting-00-32x-32.pcx", 128
sPnt1_32x32	incbin "res/painter/spr-painting-01-32x-32.pcx", 128
sPnt2_32x32	incbin "res/painter/spr-painting-02-32x-32.pcx", 128