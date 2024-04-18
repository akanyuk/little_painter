	ld bc, LLAT * 16 + 16
1	push bc
	ld b, NUMCUBES ; количество кубиков в сцене
                ld iy,_s0data
                call lib.PlayCubes  
	halt
	pop bc
	dec bc : ld a, b : or c : jr nz, 1b
	ret

NUMCUBES	equ 32
LLAT	equ 10

_s0data         db 15, 31, LLAT * 0 : dw #4000
	db 15, 31, LLAT * 1 : dw #4004
	db 15, 31, LLAT * 2 : dw #4008
	db 15, 31, LLAT * 3 : dw #400c
	db 15, 31, LLAT * 4 : dw #4010
	db 15, 31, LLAT * 5 : dw #4014
	db 15, 31, LLAT * 6 : dw #4018
	db 15, 31, LLAT * 7 : dw #401c
	
	db 15, 31, LLAT * 15 : dw #4080
	db 15, 31, LLAT * 14 : dw #4084
	db 15, 31, LLAT * 13 : dw #4088
	db 15, 31, LLAT * 12 : dw #408c
	db 15, 31, LLAT * 11 : dw #4090
	db 15, 31, LLAT * 10 : dw #4094
	db 15, 31, LLAT * 9 : dw #4098
	db 15, 31, LLAT * 8 : dw #409c

	db 15, 31, LLAT * 8 : dw #4880
	db 15, 31, LLAT * 9 : dw #4884
	db 15, 31, LLAT * 10 : dw #4888
	db 15, 31, LLAT * 11 : dw #488c
	db 15, 31, LLAT * 12 : dw #4890
	db 15, 31, LLAT * 13 : dw #4894
	db 15, 31, LLAT * 14 : dw #4898
	db 15, 31, LLAT * 15 : dw #489c

	db 15, 31, LLAT * 7 : dw #5000
	db 15, 31, LLAT * 6 : dw #5004
	db 15, 31, LLAT * 5 : dw #5008
	db 15, 31, LLAT * 4 : dw #500c
	db 15, 31, LLAT * 3 : dw #5010
	db 15, 31, LLAT * 2 : dw #5014
	db 15, 31, LLAT * 1 : dw #5018
	db 15, 31, LLAT * 0 : dw #501c	