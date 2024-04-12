	ld (sDataAddr), hl

transStages	equ $+1	
	ld bc, L8LAT + LLAT * 4 + 16
1	push bc

	ld b, NUMCUBES ; количество кубиков в сцене
sDataAddr	equ $+2
                ld iy, 0
                call lib.PlayCubes  

	halt
	pop bc
	dec bc : ld a, b : or c : jr nz, 1b

	ret

NUMCUBES	equ 40
LLAT2	equ 20
LLAT	equ 12
LLAT3	equ 20
L1LAT 	equ 0
L2LAT 	equ 10
L3LAT 	equ 20
L4LAT 	equ 30
L5LAT 	equ 40
L6LAT 	equ 50
L7LAT 	equ 60
L8LAT 	equ 70

SDATA1          db 0, 15, L5LAT/2 + LLAT2 * 0 : dw #4000
	db 0, 15, L5LAT/2 + LLAT2 * 1 : dw #4004
	db 0, 15, L5LAT/2 + LLAT2 * 2 : dw #4008
	db 0, 15, L5LAT/2 + LLAT2 * 3 : dw #400c
	db 0, 15, L5LAT/2 + LLAT2 * 4 : dw #4010
	db 0, 15, L5LAT/2 + LLAT2 * 5 : dw #4014
	db 0, 15, L5LAT/2 + LLAT2 * 6 : dw #4018
	db 0, 15, L5LAT/2 + LLAT2 * 7 : dw #401c
	
	db 0, 15, L4LAT/2 + LLAT2 * 0 : dw #4080
	db 0, 15, L4LAT/2 + LLAT2 * 1 : dw #4084
	db 0, 15, L4LAT/2 + LLAT2 * 2 : dw #4088
	db 0, 15, L4LAT/2 + LLAT2 * 3 : dw #408c
	db 0, 15, L4LAT/2 + LLAT2 * 4 : dw #4090
	db 0, 15, L4LAT/2 + LLAT2 * 5 : dw #4094
	db 0, 15, L4LAT/2 + LLAT2 * 6 : dw #4098
	db 0, 15, L4LAT/2 + LLAT2 * 7 : dw #409c

	db 0, 15, L3LAT/2 + LLAT2 * 0 : dw #4800
	db 0, 15, L3LAT/2 + LLAT2 * 1 : dw #4804
	db 0, 15, L3LAT/2 + LLAT2 * 2 : dw #4808
	db 0, 15, L3LAT/2 + LLAT2 * 3 : dw #480c
	db 0, 15, L3LAT/2 + LLAT2 * 4 : dw #4810
	db 0, 15, L3LAT/2 + LLAT2 * 5 : dw #4814
	db 0, 15, L3LAT/2 + LLAT2 * 6 : dw #4818
	db 0, 15, L3LAT/2 + LLAT2 * 7 : dw #481c

	db 0, 15, L2LAT/2 + LLAT2 * 0 : dw #4880
	db 0, 15, L2LAT/2 + LLAT2 * 1 : dw #4884
	db 0, 15, L2LAT/2 + LLAT2 * 2 : dw #4888
	db 0, 15, L2LAT/2 + LLAT2 * 3 : dw #488c
	db 0, 15, L2LAT/2 + LLAT2 * 4 : dw #4890
	db 0, 15, L2LAT/2 + LLAT2 * 5 : dw #4894
	db 0, 15, L2LAT/2 + LLAT2 * 6 : dw #4898
	db 0, 15, L2LAT/2 + LLAT2 * 7 : dw #489c

	db 0, 15, L1LAT/2 + LLAT2 * 0 : dw #5000
	db 0, 15, L1LAT/2 + LLAT2 * 1 : dw #5004
	db 0, 15, L1LAT/2 + LLAT2 * 2 : dw #5008
	db 0, 15, L1LAT/2 + LLAT2 * 3 : dw #500c
	db 0, 15, L1LAT/2 + LLAT2 * 4 : dw #5010
	db 0, 15, L1LAT/2 + LLAT2 * 5 : dw #5014
	db 0, 15, L1LAT/2 + LLAT2 * 6 : dw #5018
	db 0, 15, L1LAT/2 + LLAT2 * 7 : dw #501c	
_s0data_e	

SDATA2          db 15, 31, L1LAT + LLAT * 0 : dw #4000
	db 15, 31, L2LAT + LLAT * 0 : dw #4004
	db 15, 31, L3LAT + LLAT * 0 : dw #4008
	db 15, 31, L4LAT + LLAT * 0 : dw #400c
	db 15, 31, L5LAT + LLAT * 0 : dw #4010
	db 15, 31, L6LAT + LLAT * 0 : dw #4014
	db 15, 31, L7LAT + LLAT * 0 : dw #4018
	db 15, 31, L8LAT + LLAT * 0 : dw #401c
	
	db 15, 31, L1LAT + LLAT * 1 : dw #4080
	db 15, 31, L2LAT + LLAT * 1 : dw #4084
	db 15, 31, L3LAT + LLAT * 1 : dw #4088
	db 15, 31, L4LAT + LLAT * 1 : dw #408c
	db 15, 31, L5LAT + LLAT * 1 : dw #4090
	db 15, 31, L6LAT + LLAT * 1 : dw #4094
	db 15, 31, L7LAT + LLAT * 1 : dw #4098
	db 15, 31, L8LAT + LLAT * 1 : dw #409c

	db 15, 31, L1LAT + LLAT * 2 : dw #4800
	db 15, 31, L2LAT + LLAT * 2 : dw #4804
	db 15, 31, L3LAT + LLAT * 2 : dw #4808
	db 15, 31, L4LAT + LLAT * 2 : dw #480c
	db 15, 31, L5LAT + LLAT * 2 : dw #4810
	db 15, 31, L6LAT + LLAT * 2 : dw #4814
	db 15, 31, L7LAT + LLAT * 2 : dw #4818
	db 15, 31, L8LAT + LLAT * 2 : dw #481c

	db 15, 31, L1LAT + LLAT * 3 : dw #4880
	db 15, 31, L2LAT + LLAT * 3 : dw #4884
	db 15, 31, L3LAT + LLAT * 3 : dw #4888
	db 15, 31, L4LAT + LLAT * 3 : dw #488c
	db 15, 31, L5LAT + LLAT * 3 : dw #4890
	db 15, 31, L6LAT + LLAT * 3 : dw #4894
	db 15, 31, L7LAT + LLAT * 3 : dw #4898
	db 15, 31, L8LAT + LLAT * 3 : dw #489c

	db 15, 31, L1LAT + LLAT * 4 : dw #5000
	db 15, 31, L2LAT + LLAT * 4 : dw #5004
	db 15, 31, L3LAT + LLAT * 4 : dw #5008
	db 15, 31, L4LAT + LLAT * 4 : dw #500c
	db 15, 31, L5LAT + LLAT * 4 : dw #5010
	db 15, 31, L6LAT + LLAT * 4 : dw #5014
	db 15, 31, L7LAT + LLAT * 4 : dw #5018
	db 15, 31, L8LAT + LLAT * 4 : dw #501c

SDATA3          db 0, 15, L1LAT + LLAT3 * 0 : dw #4000
	db 0, 15, L2LAT + LLAT3 * 0 : dw #4004
	db 0, 15, L3LAT + LLAT3 * 0 : dw #4008
	db 0, 15, L4LAT + LLAT3 * 0 : dw #400c
	db 0, 15, L4LAT + LLAT3 * 0 : dw #4010
	db 0, 15, L3LAT + LLAT3 * 0 : dw #4014
	db 0, 15, L2LAT + LLAT3 * 0 : dw #4018
	db 0, 15, L1LAT + LLAT3 * 0 : dw #401c
	
	db 0, 15, L1LAT + LLAT3 * 1 : dw #4080
	db 0, 15, L2LAT + LLAT3 * 1 : dw #4084
	db 0, 15, L3LAT + LLAT3 * 1 : dw #4088
	db 0, 15, L4LAT + LLAT3 * 1 : dw #408c
	db 0, 15, L4LAT + LLAT3 * 1 : dw #4090
	db 0, 15, L3LAT + LLAT3 * 1 : dw #4094
	db 0, 15, L2LAT + LLAT3 * 1 : dw #4098
	db 0, 15, L1LAT + LLAT3 * 1 : dw #409c

	db 0, 15, L1LAT + LLAT3 * 2 : dw #4800
	db 0, 15, L2LAT + LLAT3 * 2 : dw #4804
	db 0, 15, L3LAT + LLAT3 * 2 : dw #4808
	db 0, 15, L4LAT + LLAT3 * 2 : dw #480c
	db 0, 15, L4LAT + LLAT3 * 2 : dw #4810
	db 0, 15, L3LAT + LLAT3 * 2 : dw #4814
	db 0, 15, L2LAT + LLAT3 * 2 : dw #4818
	db 0, 15, L1LAT + LLAT3 * 2 : dw #481c

	db 0, 15, L1LAT + LLAT3 * 3 : dw #4880
	db 0, 15, L2LAT + LLAT3 * 3 : dw #4884
	db 0, 15, L3LAT + LLAT3 * 3 : dw #4888
	db 0, 15, L4LAT + LLAT3 * 3 : dw #488c
	db 0, 15, L4LAT + LLAT3 * 3 : dw #4890
	db 0, 15, L3LAT + LLAT3 * 3 : dw #4894
	db 0, 15, L2LAT + LLAT3 * 3 : dw #4898
	db 0, 15, L1LAT + LLAT3 * 3 : dw #489c

	db 0, 15, L1LAT + LLAT3 * 4 : dw #5000
	db 0, 15, L2LAT + LLAT3 * 4 : dw #5004
	db 0, 15, L3LAT + LLAT3 * 4 : dw #5008
	db 0, 15, L4LAT + LLAT3 * 4 : dw #500c
	db 0, 15, L4LAT + LLAT3 * 4 : dw #5010
	db 0, 15, L3LAT + LLAT3 * 4 : dw #5014
	db 0, 15, L2LAT + LLAT3 * 4 : dw #5018
	db 0, 15, L1LAT + LLAT3 * 4 : dw #501c		