	ifdef _NO_PAINTER_TRANSITION_ : ret : endif
	ld bc, L2LAT + LLAT * 15 + 8
1	push bc
	ld b, (_s0data_e - TRANSITION0_DATA) / 5 ; количество кубиков в сцене
                push iy
                call lib.PlayCubes  
	pop iy
	halt
	pop bc
	dec bc : ld a, b : or c : jr nz, 1b
	ret

SHIFT16 	equ -#21
LLAT	equ 6
L1LAT 	equ 0
L2LAT 	equ 12

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
	db 23, 31, L1LAT + LLAT * 00 : dw SHIFT16 + #5080
	db 23, 31, L1LAT + LLAT * 01 : dw SHIFT16 + #5082
	db 23, 31, L1LAT + LLAT * 02 : dw SHIFT16 + #5084
	db 23, 31, L1LAT + LLAT * 03 : dw SHIFT16 + #5086
	db 23, 31, L1LAT + LLAT * 04 : dw SHIFT16 + #5088
	db 23, 31, L1LAT + LLAT * 05 : dw SHIFT16 + #508a
	db 23, 31, L1LAT + LLAT * 06 : dw SHIFT16 + #508c
	db 23, 31, L1LAT + LLAT * 07 : dw SHIFT16 + #508e
	db 23, 31, L1LAT + LLAT * 08 : dw SHIFT16 + #5090
	db 23, 31, L1LAT + LLAT * 09 : dw SHIFT16 + #5092
	db 23, 31, L1LAT + LLAT * 10 : dw SHIFT16 + #5094
	db 23, 31, L1LAT + LLAT * 11 : dw SHIFT16 + #5096
	db 23, 31, L1LAT + LLAT * 12 : dw SHIFT16 + #5098
	db 23, 31, L1LAT + LLAT * 13 : dw SHIFT16 + #509a
	db 23, 31, L1LAT + LLAT * 14 : dw SHIFT16 + #509c
	db 23, 31, L1LAT + LLAT * 15 : dw SHIFT16 + #509e

	db 23, 31, L2LAT + LLAT * 00 : dw SHIFT16 + #50c0
	db 23, 31, L2LAT + LLAT * 01 : dw SHIFT16 + #50c2
	db 23, 31, L2LAT + LLAT * 02 : dw SHIFT16 + #50c4
	db 23, 31, L2LAT + LLAT * 03 : dw SHIFT16 + #50c6
	db 23, 31, L2LAT + LLAT * 04 : dw SHIFT16 + #50c8
	db 23, 31, L2LAT + LLAT * 05 : dw SHIFT16 + #50ca
	db 23, 31, L2LAT + LLAT * 06 : dw SHIFT16 + #50cc
	db 23, 31, L2LAT + LLAT * 07 : dw SHIFT16 + #50ce
	db 23, 31, L2LAT + LLAT * 08 : dw SHIFT16 + #50d0
	db 23, 31, L2LAT + LLAT * 09 : dw SHIFT16 + #50d2
	db 23, 31, L2LAT + LLAT * 10 : dw SHIFT16 + #50d4
	db 23, 31, L2LAT + LLAT * 11 : dw SHIFT16 + #50d6
	db 23, 31, L2LAT + LLAT * 12 : dw SHIFT16 + #50d8
	db 23, 31, L2LAT + LLAT * 13 : dw SHIFT16 + #50da
	db 23, 31, L2LAT + LLAT * 14 : dw SHIFT16 + #50dc
	db 23, 31, L2LAT + LLAT * 15 : dw SHIFT16 + #50de
