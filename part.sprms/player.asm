	jp play

	; start/stop animation
	; a - index 0-11 for snake1 or 12-23 for snake2
	; b - set frame number [0-80]
	; c - state [1|0]
changeState	add a : add a : ld l, a
	ld h, high(FRAME_STATES)
	ld (hl), c

	; selecting player1 / player2
	ld d, low(player2.FRAMES)
	cp 12*4 
	jr c, $+4
	ld d, low(player1.FRAMES)
	ld a, b : add a : add d
	inc hl : ld (hl), a
	ret

	; playing one tick
play	ld ix, FRAME_STATES
	call player2Play

	; player1Play
	ld b, 12
.cycle1	push bc
	ld a, (ix + 0)
	or a : jp z, .skip1 // animation stopped
	
	; next frame
	ld a, (ix + 1)
	inc a : inc a
	cp low(player1.FRAMES_END)
	jr nz, $+4
	ld a, low(player1.FRAMES)
	ld (ix + 1), a
	ld l, a
	ld h, high(player1.FRAMES)
	ld e, (hl) : inc hl : ld d, (hl) : ex de, hl

	; screen address
	ld e, (ix + 2)
	ld d, (ix + 3)
	call player1.DisplayFrame

.skip1	ld de, 4 : add ix, de
	pop bc
	djnz .cycle1
	ret

player2Play	ld b, 12
.cycle2	push bc
	ld a, (ix + 0)
	or a : jp z, .skip2 // animation stopped
	
	; next frame
	ld a, (ix + 1)
	inc a : inc a
	cp low(player2.FRAMES_END)
	jr nz, $+4
	ld a, low(player2.FRAMES)
	ld (ix + 1), a
	ld l, a
	ld h, high(player2.FRAMES)
	ld e, (hl) : inc hl : ld d, (hl) : ex de, hl

	; screen address
	ld e, (ix + 2)
	ld d, (ix + 3)
	call player2.DisplayFrame

.skip2	ld de, 4 : add ix, de
	pop bc
	djnz .cycle2
	ret

	align #100
FRAME_STATES 	
	; snake_anima1
	db 0, low(player1.FRAMES) : dw #4000
	db 0, low(player1.FRAMES) : dw #4008
	db 0, low(player1.FRAMES) : dw #4010
	db 0, low(player1.FRAMES) : dw #4018

	db 0, low(player1.FRAMES) : dw #4800
	db 0, low(player1.FRAMES) : dw #4808
	db 0, low(player1.FRAMES) : dw #4810
	db 0, low(player1.FRAMES) : dw #4818

	db 0, low(player1.FRAMES) : dw #5000
	db 0, low(player1.FRAMES) : dw #5008
	db 0, low(player1.FRAMES) : dw #5010
	db 0, low(player1.FRAMES) : dw #5018

	; snake_anima2
	db 0, low(player2.FRAMES) : dw #4000
	db 0, low(player2.FRAMES) : dw #4008
	db 0, low(player2.FRAMES) : dw #4010
	db 0, low(player2.FRAMES) : dw #4018

	db 0, low(player2.FRAMES) : dw #4800
	db 0, low(player2.FRAMES) : dw #4808
	db 0, low(player2.FRAMES) : dw #4810
	db 0, low(player2.FRAMES) : dw #4818

	db 0, low(player2.FRAMES) : dw #5000
	db 0, low(player2.FRAMES) : dw #5008
	db 0, low(player2.FRAMES) : dw #5010
	db 0, low(player2.FRAMES) : dw #5018

	module player1
 	include "snake_anima1/player.asm"
	endmodule

	module player2
 	include "snake_anima2/player.asm"
	endmodule

