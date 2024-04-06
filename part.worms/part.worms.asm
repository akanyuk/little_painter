	define DIRECTION_LEFT 0
	define DIRECTION_RIGHT 1
	define DIRECTION_UP 2
	define DIRECTION_DOWN 3
	define DIRECTION_UNKNOWN 255

DotTable	equ consts.WormsTables 	; 1k + 256 bytes
RndTable	equ consts.WormsTables + #500 	; 256 bytes
PillarsTable	equ consts.WormsTables + #600 	; 1024 bytes
WormsTable	equ consts.WormsTables + #a00 	; 512 bytes

	jp init.Init     	; $+0   
	jp main     		; $+3
	jp worm.Stop     	; $+6
	jp init.Scene1     	; $+9
	jp init.Scene2     	; $+12
	jp init.Scene3     	; $+15
	jp init.Scene4     	; $+18
	jp init.Scene5     	; $+21

	module init
	include "modules/init.asm"
	endmodule

	module dot2x2
	include "modules/dot2x2.asm"
	endmodule

	module pillars
	include "modules/pillars.asm"
	endmodule

	module pillars_data
	include "modules/pillars_data.asm"
	endmodule

	module worm
	include "modules/worm.asm"
	endmodule

	module worms_data
	include "modules/worms_data.asm"
	endmodule

@NUM_WORMS	db 20
@SPEED	db 2

main	ld a, (NUM_WORMS) : ld b, a
	ld ix, WormsTable
1	push bc
	ld a, (SPEED)
2	push af
	call worm.Move
	pop af : dec a : jr nz, 2b

	ld de, worms_data.WORM_DATA_LEN : add ix, de
	pop bc : djnz 1b
	ret

	; RETURNS: 
	; A, B, C - random bytes
@Rnd	ld h, RndTable / 256 ; 256-байтовая таблица
.curnd	ld a,0
	inc a
	ld (.curnd +1 ), a 	; не случайный номер, а лишь указатель в таблице
	ld l, a
	ld b,(hl)
	add a,55-24
	ld l, a
	ld c,(hl)
	add a, 24
	ld l, a
	ld a, b
	add a, c
	ld (hl),a
	ret

	; Convert X/Y coordinates to attribute address
	; 
	; PARAMS:
	; B - x coordinate;
	; C - y coordinate;
	; 
	; RETURNS:
	; hl - memory address
@AttrAddr	ld a, c
	and %11111000
	ld h, 0 : ld l, a
	add hl, hl
	add hl, hl

	ld a, b
	and %11111000
	rrca : rrca : rrca
	ld d, 0 : ld e, a
	add hl, de
	
	ld de, #5800
	add hl, de
	ret