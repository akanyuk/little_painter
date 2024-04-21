Init	
	ld a, %00000101 : call SetScreenAttr
                call TransitionIn
	ld hl, #4000 : ld de, #c000 : ld bc, #1b00 : ldir
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

DispBG	ld hl, bg
	ld de, #5080
	ld a, 32
1	push af
	push de
	ld bc, 32
	ldir
	pop de
	call lib.DownDE
	pop af
	dec a
	jr nz, 1b
	ret

	; a - col
DispBgCol	ld hl, bg
	ld d, 0 : ld e, a
	add hl, de
	ld de, #5080
	add e
	ld e, a
	ld a, 32
1	push af
	push de
	ld a, (hl)
	ld (de), a
	ld de, 32
	add hl, de
	pop de
	call lib.DownDE
	pop af
	dec a
	jr nz, 1b
	ret

	; hl - sprite
	; a - x-coord
DispSpr48x24	ld d, #50
	ld e, #a0 : add e : ld e, a
	ld a, 24
1	push af
	push de
	ld bc, 48/8
	ldir
	pop de
	call lib.DownDE
	pop af
	dec a
	jr nz, 1b
	ret

	; hl - sprite
	; a - x-coord
DispSpr32x24	ld d, #50
	ld e, #a0 : add e : ld e, a
	ld a, 24
1	push af
	push de
	ldi : ldi : ldi : ldi
	pop de
	call lib.DownDE
	pop af
	dec a
	jr nz, 1b
	ret

	; hl - sprite
	; a - x-coord
DispSpr24x24	ld d, #50
	ld e, #a0 : add e : ld e, a
	ld a, 24
1	push af
	push de
	ldi : ldi : ldi
	inc hl
	pop de
	call lib.DownDE
	pop af
	dec a
	jr nz, 1b
	ret

	; hl - sprite
	; a - x-coord
DispSpr16x24	ld d, #50
	ld e, #a0 : add e : ld e, a
	ld a, 24
1	push af
	push de
	ldi : ldi
	pop de
	call lib.DownDE
	pop af
	dec a
	jr nz, 1b
	ret

Interrupts	include "painter_interrupts.asm"
	include "src/painter_transitions.asm"

bg	incbin "res/painter/bg.pcx", 128

stay0_16x24	incbin "res/painter/stay-00.pcx", 128
stay1_16x24	incbin "res/painter/stay-01.pcx", 128

stay2_0_16x24	incbin "res/painter/stay2-0.pcx", 128
stay2_1_16x24	incbin "res/painter/stay2-1.pcx", 128

sPnt0_32x24	incbin "res/painter/painting-00-32x24.pcx", 128
sPnt1_32x24	incbin "res/painter/painting-01-32x24.pcx", 128
sPnt2_32x24	incbin "res/painter/painting-02-32x24.pcx", 128
sPnt3_32x24	incbin "res/painter/painting-03-32x24.pcx", 128

gym1_32x24	incbin "res/painter/gym1.pcx", 128
gym2_32x24	incbin "res/painter/gym2.pcx", 128
gym3_32x24	incbin "res/painter/gym3.pcx", 128

bed0_48x24	incbin "res/painter/bed-00.pcx", 128
bed1_48x24	incbin "res/painter/bed-01.pcx", 128
bed3_48x24	incbin "res/painter/bed-03.pcx", 128
bed4_48x24	incbin "res/painter/bed-04.pcx", 128
bed5_16x24	incbin "res/painter/bed-05.pcx", 128

eat1_24x24	incbin "res/painter/eat1.pcx", 128
eat2_24x24	incbin "res/painter/eat2.pcx", 128
eat3_24x24	incbin "res/painter/eat3.pcx", 128
eat4_24x24	incbin "res/painter/eat4.pcx", 128
eat5_24x24	incbin "res/painter/eat5.pcx", 128