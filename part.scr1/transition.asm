	xor a : call lib.SetScreen
	ld a, 7 : call lib.SetPage		
	ld a, 7 : call lib.SetScreenAttr

	ld b, 146
1	push bc

	ld b,40 ; количество кубиков в сцене
                ld iy,_s0data
                call lib.PlayCubes  

	halt
	pop bc
	djnz 1b

	ld hl, #4000
	ld de, #c000
	ld bc, #1b00
	ldir

	ret

_s0data         db 0, 15, 91 : dw #4000
	db 0, 15, 78 : dw #4004
	db 0, 15, 65 : dw #4008
	db 0, 15, 52 : dw #400c
	db 0, 15, 39 : dw #4010
	db 0, 15, 26 : dw #4014
	db 0, 15, 13 : dw #4018
	db 0, 15, 00 : dw #401c
	
	db 0, 15, 101 : dw #4080
	db 0, 15, 88 : dw #4084
	db 0, 15, 75 : dw #4088
	db 0, 15, 62 : dw #408c
	db 0, 15, 49 : dw #4090
	db 0, 15, 36 : dw #4094
	db 0, 15, 23 : dw #4098
	db 0, 15, 10 : dw #409c

	db 0, 15, 111 : dw #4800
	db 0, 15, 98 : dw #4804
	db 0, 15, 85 : dw #4808
	db 0, 15, 72 : dw #480c
	db 0, 15, 59 : dw #4810
	db 0, 15, 46 : dw #4814
	db 0, 15, 33 : dw #4818
	db 0, 15, 20 : dw #481c

	db 0, 15, 121 : dw #4880
	db 0, 15, 108 : dw #4884
	db 0, 15, 95 : dw #4888
	db 0, 15, 82 : dw #488c
	db 0, 15, 69 : dw #4890
	db 0, 15, 56 : dw #4894
	db 0, 15, 43 : dw #4898
	db 0, 15, 30 : dw #489c

	db 0, 15, 131 : dw #5000
	db 0, 15, 118 : dw #5004
	db 0, 15, 105 : dw #5008
	db 0, 15, 92 : dw #500c
	db 0, 15, 79 : dw #5010
	db 0, 15, 66 : dw #5014
	db 0, 15, 53 : dw #5018
	db 0, 15, 40 : dw #501c	