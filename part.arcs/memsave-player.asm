	ld iy, LINES_STATE
	ld b, 8
linesCicle	push bc
	ld a, (iy + 3)
	or a : jr z, 2f
	dec a : ld (iy + 3), a
	jr linesCicleEnd
2	ld e, (iy + 0)
	ld d, (iy + 1)
	ld a, (iy + 2)
	call lineStep
	ld (iy + 2), a

linesCicleEnd	ld de, 4 : add iy, de
	pop bc 
	djnz linesCicle
	ret

LINES_STATE	dw line1.data
	db #ff	; cur frame (#ff - firts)
	db 0	; delay before start

	dw line2.data
	db #ff	
	db 0	

	dw line3.data
	db #ff	
	db 0	

	dw line4.data
	db #ff	
	db 0	

	dw line5.data
	db #ff	
	db 0	

	dw line6.data
	db #ff	
	db 0	

	dw line7.data
	db #ff	
	db 0	

	dw line8.data
	db #ff	
	db 0	

lineStep	cp 140 
	jr nz, $+4 : ld a, #ff
	inc a	

	; Конец цикла - пауза в начале следующего
	cp 75 : ret nc
	
	; "Замирание" на правой фазе
	cp 30 : jr c, 1f
	push de, af
	call fallingLineDraw
	pop af, de
	cp 46 : ret c
	push af
	sub 16
	jr 2f

1	push af
2	ld l, a : ld h, 0 : add hl, hl : add hl, de
	ld e, (hl) : inc hl : ld d, (hl)
	ex de, hl

	call playFrame
	pop af
	ret

	; hl - адрес с данными
playFrame	ld de, #4000
	ld c,(hl) : inc hl ; Screen shift
	ld b,(hl) : inc hl
	ex de,hl
	add hl,bc
	ex de,hl
	xor a : ld b,a
cycle	ld  a,(hl)
	inc hl
	ld c,a
	rla
	jp nc,2f
	rlca		; cp  #80
	ret c
	; long jump
	ld  a,c
	and #0f
	add a,d : ld d,a
	bit 4,c
	jp  z, cycle
	ld a,#80
	add e
	ld e,a
	jp nc,cycle
	inc d
	jp  cycle
2	rlca
	jp c,nearJmp
	inc c		; copy N bytes to screen
	ldir
	jp cycle
nearJmp	ld a,c
	res 6,a
	inc a
	add e
	ld e,a
	jp nc,cycle
	inc d
	jp  cycle

	; a - stage of animation
	; b - line index
fallingLineDraw	sub 30
	ret c
	sra a
	cp 8 : ret nc
	add a : ld d, 0 : ld e, a
	ld hl, fallingLineStages
	add hl, de
	ld e, (hl) : inc hl : ld d, (hl)
	ex de, hl
	; determine screen address
	ld a, b : add a
	neg : add 33 : ld e, a
	ld d, #50
	dup 5
	ldi : dec de : inc d
	edup
	ret

fallingLineStages	dw fallingLineData
	dw fallingLineData
	dw fallingLineData + 5
	dw fallingLineData + 5
	dw fallingLineData + 10
	dw fallingLineData + 5
	dw fallingLineData
	dw fallingLineData + 15

	; Прогибающаяся линия: 5 байт на кадр
fallingLineData	db %00000000
	db %11111111
	db %11111111
	db %00000000
	db %00000000

	db %00000000
	db %00000000
	db %11111111
	db %11111111
	db %00000000

	db %00000000
	db %00000000
	db %10000001
	db %11111111
	db %01111110

	db %11111111
	db %11111111
	db %00000000
	db %00000000
	db %00000000

	module line1
data	include "line1/player.asm"	
	endmodule

	module line2
data	include "line2/player.asm"
	endmodule

	module line3
data	include "line3/player.asm"
	endmodule

	module line4
data	include "line4/player.asm"
	endmodule

	module line5
data	include "line5/player.asm"
	endmodule

	module line6
data	include "line6/player.asm"
	endmodule

	module line7
data	include "line7/player.asm"
	endmodule

	module line8
data	include "line8/player.asm"
	endmodule
	