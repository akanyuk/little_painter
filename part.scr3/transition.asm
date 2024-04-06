	xor a : call lib.SetScreen
	ld a, 7 : call lib.SetPage		
	ld a, #43 : call lib.SetScreenAttr

	ld bc, L5LAT + LLAT * 3 + 16
1	push bc

	ld b, NUMCUBES ; количество кубиков в сцене
                ld iy,_s0data
                call lib.PlayCubes  

	halt
	pop bc
	dec bc : ld a, b : or c : jr nz, 1b

	ld hl, #4000
	ld de, #c000
	ld bc, #1b00
	ldir

	ret

NUMCUBES	equ 40
LLAT	equ 12
L1LAT 	equ 0
L2LAT 	equ 20
L3LAT 	equ 20*2
L4LAT 	equ 20*3
L5LAT 	equ 20*4

_s0data         db 0, 15, L1LAT + LLAT * 3 : dw #4000
	db 0, 15, L1LAT + LLAT * 2 : dw #4004
	db 0, 15, L1LAT + LLAT * 1 : dw #4008
	db 0, 15, L1LAT + LLAT * 0 : dw #400c
	db 0, 15, L1LAT + LLAT * 0 : dw #4010
	db 0, 15, L1LAT + LLAT * 1 : dw #4014
	db 0, 15, L1LAT + LLAT * 2 : dw #4018
	db 0, 15, L1LAT + LLAT * 3 : dw #401c
	
	db 0, 15, L2LAT + LLAT * 3 : dw #4080
	db 0, 15, L2LAT + LLAT * 2 : dw #4084
	db 0, 15, L2LAT + LLAT * 1 : dw #4088
	db 0, 15, L2LAT + LLAT * 0 : dw #408c
	db 0, 15, L2LAT + LLAT * 0 : dw #4090
	db 0, 15, L2LAT + LLAT * 1 : dw #4094
	db 0, 15, L2LAT + LLAT * 2 : dw #4098
	db 0, 15, L2LAT + LLAT * 3 : dw #409c

	db 0, 15, L3LAT + LLAT * 3 : dw #4800
	db 0, 15, L3LAT + LLAT * 2 : dw #4804
	db 0, 15, L3LAT + LLAT * 1 : dw #4808
	db 0, 15, L3LAT + LLAT * 0 : dw #480c
	db 0, 15, L3LAT + LLAT * 0 : dw #4810
	db 0, 15, L3LAT + LLAT * 1 : dw #4814
	db 0, 15, L3LAT + LLAT * 2 : dw #4818
	db 0, 15, L3LAT + LLAT * 3 : dw #481c

	db 0, 15, L4LAT + LLAT * 3 : dw #4880
	db 0, 15, L4LAT + LLAT * 2 : dw #4884
	db 0, 15, L4LAT + LLAT * 1 : dw #4888
	db 0, 15, L4LAT + LLAT * 0 : dw #488c
	db 0, 15, L4LAT + LLAT * 0 : dw #4890
	db 0, 15, L4LAT + LLAT * 1 : dw #4894
	db 0, 15, L4LAT + LLAT * 2 : dw #4898
	db 0, 15, L4LAT + LLAT * 3 : dw #489c

	db 0, 15, L5LAT + LLAT * 3 : dw #5000
	db 0, 15, L5LAT + LLAT * 2 : dw #5004
	db 0, 15, L5LAT + LLAT * 1 : dw #5008
	db 0, 15, L5LAT + LLAT * 0 : dw #500c
	db 0, 15, L5LAT + LLAT * 0 : dw #5010
	db 0, 15, L5LAT + LLAT * 1 : dw #5014
	db 0, 15, L5LAT + LLAT * 2 : dw #5018
	db 0, 15, L5LAT + LLAT * 3 : dw #501c	