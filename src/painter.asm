Init	ld a, %00000101 : call SetScreenAttr

	ld bc, L2LAT + LLAT * 15 + 8
1	push bc
	ld b, (_s0data_e - _s0data) / 5 ; количество кубиков в сцене
                ld iy,_s0data
                call lib.PlayCubes  
	halt
	pop bc
	dec bc : ld a, b : or c : jr nz, 1b

	ld a, %00101101 : call SetScreenAttr
	call ClearScreen
	ld a, %00101000 : call SetScreenAttr

	ld hl, #4000 : ld de, #c000 : ld bc, #1b00 : ldir
	ret

SHIFT16 	equ -#21
LLAT	equ 6
L1LAT 	equ 0
L2LAT 	equ 12
_s0data
	db 0, 7, L1LAT + LLAT * 00 : dw SHIFT16 + #5080
	db 0, 7, L1LAT + LLAT * 01 : dw SHIFT16 + #5082
	db 0, 7, L1LAT + LLAT * 02 : dw SHIFT16 + #5084
	db 0, 7, L1LAT + LLAT * 03 : dw SHIFT16 + #5086
	db 0, 7, L1LAT + LLAT * 04 : dw SHIFT16 + #5088
	db 0, 7, L1LAT + LLAT * 05 : dw SHIFT16 + #508a
	db 0, 7, L1LAT + LLAT * 06 : dw SHIFT16 + #508c
	db 0, 7, L1LAT + LLAT * 07 : dw SHIFT16 + #508e
	db 0, 7, L1LAT + LLAT * 08 : dw SHIFT16 + #5090
	db 0, 7, L1LAT + LLAT * 09 : dw SHIFT16 + #5092
	db 0, 7, L1LAT + LLAT * 10 : dw SHIFT16 + #5094
	db 0, 7, L1LAT + LLAT * 11 : dw SHIFT16 + #5096
	db 0, 7, L1LAT + LLAT * 12 : dw SHIFT16 + #5098
	db 0, 7, L1LAT + LLAT * 13 : dw SHIFT16 + #509a
	db 0, 7, L1LAT + LLAT * 14 : dw SHIFT16 + #509c
	db 0, 7, L1LAT + LLAT * 15 : dw SHIFT16 + #509e

	db 0, 7, L2LAT + LLAT * 00 : dw SHIFT16 + #50c0
	db 0, 7, L2LAT + LLAT * 01 : dw SHIFT16 + #50c2
	db 0, 7, L2LAT + LLAT * 02 : dw SHIFT16 + #50c4
	db 0, 7, L2LAT + LLAT * 03 : dw SHIFT16 + #50c6
	db 0, 7, L2LAT + LLAT * 04 : dw SHIFT16 + #50c8
	db 0, 7, L2LAT + LLAT * 05 : dw SHIFT16 + #50ca
	db 0, 7, L2LAT + LLAT * 06 : dw SHIFT16 + #50cc
	db 0, 7, L2LAT + LLAT * 07 : dw SHIFT16 + #50ce
	db 0, 7, L2LAT + LLAT * 08 : dw SHIFT16 + #50d0
	db 0, 7, L2LAT + LLAT * 09 : dw SHIFT16 + #50d2
	db 0, 7, L2LAT + LLAT * 10 : dw SHIFT16 + #50d4
	db 0, 7, L2LAT + LLAT * 11 : dw SHIFT16 + #50d6
	db 0, 7, L2LAT + LLAT * 12 : dw SHIFT16 + #50d8
	db 0, 7, L2LAT + LLAT * 13 : dw SHIFT16 + #50da
	db 0, 7, L2LAT + LLAT * 14 : dw SHIFT16 + #50dc
	db 0, 7, L2LAT + LLAT * 15 : dw SHIFT16 + #50de
_s0data_e

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
	ld (hl), 0
	ldir
	pop hl
	call lib.DownHL
	pop af : dec a : jr nz, 1b
	ret

SetScreenAttr
	ld hl, #5a80 : ld de, #5a81 : ld bc, #007f : ld (hl), a : ldir
	ret