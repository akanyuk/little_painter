	ld bc, LLAT * 40 + 16
1	push bc
	ld b, NUMCUBES ; количество кубиков в сцене
                ld iy,_s0data
                call lib.PlayCubes  
	halt
	pop bc
	dec bc : ld a, b : or c : jr nz, 1b
	ret

NUMCUBES	equ 40
LLAT	equ 6

_s0data         db 15, 31, LLAT * 0 : dw #4000
	db 15, 31, LLAT * 1 : dw #4004
	db 15, 31, LLAT * 2 : dw #4008
	db 15, 31, LLAT * 3 : dw #400c
	db 15, 31, LLAT * 4 : dw #4010
	db 15, 31, LLAT * 5 : dw #4014
	db 15, 31, LLAT * 6 : dw #4018
	db 15, 31, LLAT * 7 : dw #401c
	
	db 15, 31, LLAT * 21 : dw #4080
	db 15, 31, LLAT * 22 : dw #4084
	db 15, 31, LLAT * 23 : dw #4088
	db 15, 31, LLAT * 24 : dw #408c
	db 15, 31, LLAT * 25 : dw #4090
	db 15, 31, LLAT * 26 : dw #4094
	db 15, 31, LLAT * 27 : dw #4098
	db 15, 31, LLAT * 8 : dw #409c

	db 15, 31, LLAT * 20 : dw #4800
	db 15, 31, LLAT * 35 : dw #4804
	db 15, 31, LLAT * 36 : dw #4808
	db 15, 31, LLAT * 37 : dw #480c
	db 15, 31, LLAT * 38 : dw #4810
	db 15, 31, LLAT * 39 : dw #4814
	db 15, 31, LLAT * 28 : dw #4818
	db 15, 31, LLAT * 9 : dw #481c

	db 15, 31, LLAT * 19 : dw #4880
	db 15, 31, LLAT * 34 : dw #4884
	db 15, 31, LLAT * 33 : dw #4888
	db 15, 31, LLAT * 32 : dw #488c
	db 15, 31, LLAT * 31 : dw #4890
	db 15, 31, LLAT * 30 : dw #4894
	db 15, 31, LLAT * 29 : dw #4898
	db 15, 31, LLAT * 10 : dw #489c

	db 15, 31, LLAT * 18 : dw #5000
	db 15, 31, LLAT * 17 : dw #5004
	db 15, 31, LLAT * 16 : dw #5008
	db 15, 31, LLAT * 15 : dw #500c
	db 15, 31, LLAT * 14 : dw #5010
	db 15, 31, LLAT * 13 : dw #5014
	db 15, 31, LLAT * 12 : dw #5018
	db 15, 31, LLAT * 11 : dw #501c	