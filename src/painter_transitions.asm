TransitionIn	ld iy, TRANSITION0_DATA
	ld bc, L2LAT + LLAT * 15 + 8
tloop	push bc
	ld b, (_s0data_e - TRANSITION0_DATA) / 5 ; количество кубиков в сцене
                push iy
                call lib.PlayCubes  
	pop iy
	halt

_bgcnt1	ld a, 255 : inc a 
	cp 6 : jr nz, 1f
	call dispBgLine1
	xor a
1	ld (_bgcnt1 + 1), a

_bgcnt2	ld a, 243 : inc a 
	cp 6 : jr nz, 1f
	call dispBgLine2
	xor a
1	ld (_bgcnt2 + 1), a

	pop bc	
	dec bc : ld a, b : or c : jr nz, tloop
	ret

	
dispBgLine1	ld hl, bg
	ld de, #5080
	ld a, e : cp #a0 : ret z
	ld a, 2
1	push af
	push de
	push hl
	ld a, 16
	ld bc, 32
2	push af
	ld a, (hl)
	ld (de), a
	add hl, bc
	call lib.DownDE
	pop af
	dec a
	jr nz, 2b
	pop hl : inc hl
	pop de : inc de
	pop af : dec a : jr nz, 1b

	ld hl, (dispBgLine1 + 1) : inc hl : inc hl : ld (dispBgLine1 + 1), hl

	ld a, (dispBgLine1 + 5) 
	rrca : rrca : rrca : and 3 : or #58 : ld h, a
	ld a, (dispBgLine1 + 4) : ld l, a
	ld (hl), %00101000
	inc hl : ld (hl), %00101000
	ld de, #001f : add hl, de
	ld (hl), %00101000
	inc hl : ld (hl), %00101000
	ld hl, dispBgLine1 + 4 : inc (hl) : inc (hl)
	ret

dispBgLine2	ld hl, bg + 32 *16
	ld de, #50c0
	ld a, e : cp #e0 : ret z
	ld a, 2
1	push af
	push de
	push hl
	ld a, 16
	ld bc, 32
2	push af
	ld a, (hl)
	ld (de), a
	add hl, bc
	call lib.DownDE
	pop af
	dec a
	jr nz, 2b
	pop hl : inc hl
	pop de : inc de
	pop af : dec a : jr nz, 1b

	ld hl, (dispBgLine2 + 1) : inc hl : inc hl : ld (dispBgLine2 + 1), hl

	ld a, (dispBgLine2 + 5) 
	rrca : rrca : rrca : and 3 : or #58 : ld h, a
	ld a, (dispBgLine2 + 4) : ld l, a
	ld (hl), %00101000
	inc hl : ld (hl), %00101000
	ld de, #001f : add hl, de
	ld (hl), %00101000
	inc hl : ld (hl), %00101000
	ld hl, dispBgLine2 + 4 : inc (hl) : inc (hl)
	ret

TransitionOut	ld iy, TRANSITION1_DATA
	ld b, (_s0data_e - TRANSITION0_DATA) / 5 ; количество кубиков в сцене
                jp lib.PlayCubes  

SHIFT16 	equ -#21
LLAT	equ 6
L1LAT 	equ 0
L2LAT 	equ 12
L22LAT 	equ 8

TRANSITION0_DATA
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

TRANSITION1_DATA
	db 0, 7, L1LAT + LLAT * 15 : dw SHIFT16 + #5080
	db 0, 7, L1LAT + LLAT * 14 : dw SHIFT16 + #5082
	db 0, 7, L1LAT + LLAT * 13 : dw SHIFT16 + #5084
	db 0, 7, L1LAT + LLAT * 12 : dw SHIFT16 + #5086
	db 0, 7, L1LAT + LLAT * 11 : dw SHIFT16 + #5088
	db 0, 7, L1LAT + LLAT * 10 : dw SHIFT16 + #508a
	db 0, 7, L1LAT + LLAT * 09 : dw SHIFT16 + #508c
	db 0, 7, L1LAT + LLAT * 08 : dw SHIFT16 + #508e
	db 0, 7, L1LAT + LLAT * 07 : dw SHIFT16 + #5090
	db 0, 7, L1LAT + LLAT * 06 : dw SHIFT16 + #5092
	db 0, 7, L1LAT + LLAT * 05 : dw SHIFT16 + #5094
	db 0, 7, L1LAT + LLAT * 04 : dw SHIFT16 + #5096
	db 0, 7, L1LAT + LLAT * 03 : dw SHIFT16 + #5098
	db 0, 7, L1LAT + LLAT * 02 : dw SHIFT16 + #509a
	db 0, 7, L1LAT + LLAT * 01 : dw SHIFT16 + #509c
	db 0, 7, L1LAT + LLAT * 00 : dw SHIFT16 + #509e

	db 0, 7, L22LAT + LLAT * 15 : dw SHIFT16 + #50c0
	db 0, 7, L22LAT + LLAT * 14 : dw SHIFT16 + #50c2
	db 0, 7, L22LAT + LLAT * 13 : dw SHIFT16 + #50c4
	db 0, 7, L22LAT + LLAT * 12 : dw SHIFT16 + #50c6
	db 0, 7, L22LAT + LLAT * 11 : dw SHIFT16 + #50c8
	db 0, 7, L22LAT + LLAT * 10 : dw SHIFT16 + #50ca
	db 0, 7, L22LAT + LLAT * 09 : dw SHIFT16 + #50cc
	db 0, 7, L22LAT + LLAT * 08 : dw SHIFT16 + #50ce
	db 0, 7, L22LAT + LLAT * 07 : dw SHIFT16 + #50d0
	db 0, 7, L22LAT + LLAT * 06 : dw SHIFT16 + #50d2
	db 0, 7, L22LAT + LLAT * 05 : dw SHIFT16 + #50d4
	db 0, 7, L22LAT + LLAT * 04 : dw SHIFT16 + #50d6
	db 0, 7, L22LAT + LLAT * 03 : dw SHIFT16 + #50d8
	db 0, 7, L22LAT + LLAT * 02 : dw SHIFT16 + #50da
	db 0, 7, L22LAT + LLAT * 01 : dw SHIFT16 + #50dc
	db 0, 7, L22LAT + LLAT * 00 : dw SHIFT16 + #50de
