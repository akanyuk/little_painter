	jp init

_xorAddr	ld hl, xorDB 
	inc hl 
	ld a, (hl) : or a : jr nz, 1f
	ld hl, xorDB 
1	ld a, (hl)
	ld (_xorAddr + 1), hl
	ld (copyOneMask), a

seed0 	ld hl, RND
	ld b, 0
	call copyOne 
seed1 	ld hl, RND + 17
	ld b, 1
	call copyOne 
seed2 	ld hl, RND + 22
	ld b, 2
	call copyOne 
seed4 	ld hl, RND
	ld b, 4
	call copyOne 
seed5 	ld hl, RND + 89
	ld b, 5
	call copyOne 
seed6 	ld hl, RND + 178
	ld b, 6
	call copyOne 
seed7 	ld hl, RND + 219
	ld b, 7
	call copyOne 
seed3 	ld hl, RND + 77
	ld b, 3
	call copyOne 
	ld hl, seed0 + 1 : inc (hl)
	ld hl, seed1 + 1 : inc (hl)
	ld hl, seed2 + 1 : inc (hl)
	ld hl, seed3 + 1 : inc (hl)
	ld hl, seed4 + 1 : inc (hl)
	ld hl, seed5 + 1 : inc (hl)
	ld hl, seed6 + 1 : inc (hl)
	ld hl, seed7 + 1 : inc (hl)
	ret

xorDB	
	db %11000000
	db %00000011
	db %00011000
	; db %00101001
	; db %01001001

	; db %00000010
	; db %00100000
	; db %00010000
	; db %00000010
	; db %00000001
	; db %10000000
	; db %00001000
	; db %00001000
	; db %00000100
	; db %00000100
	; db %01000000
	
	; db %11111111
	db 0

copyOne	push hl, bc

	pop bc, hl
	ld c, (hl)
	ld hl, #4800
	add hl, bc
	ex de, hl

	ld hl, BUFF 
	add hl, bc

	ld a, (de) 
copyOneMask	equ $+1	
	and 1
	or (hl)
	ld (de), a
	ret

init	ld a, 32
	ld hl, LAST_CIT
	ld de, BUFF
1	push af
	push de
	ld bc, #0020 : ldir
	pop de
	call lib.DownDE
	pop af : dec a : jr nz, 1b
	ret

LAST_CIT	incbin "res/last_cit.pcx", 128
	align #100
RND	db 68, 255, 114, 63, 233, 41, 212, 90, 134, 217, 179, 158, 205, 28, 126, 147, 117, 186, 52, 216, 78, 198, 207, 183, 105, 32, 252, 161, 197, 93
	db 200, 56, 178, 75, 168, 189, 185, 103, 38, 145, 245, 42, 130, 139, 190, 151, 12, 17, 120, 199, 89, 228, 127, 163, 160, 47, 46, 71, 53, 169, 148, 26, 80, 111, 194, 253, 208, 242, 155, 124, 87, 121, 35, 250, 113, 118, 36, 69, 156, 84, 30, 131, 215, 64, 248, 23, 16, 240, 174, 236, 95, 39, 249, 13, 203, 106, 100, 55, 239, 94, 43, 184, 234, 116, 132, 51, 49, 223, 125, 99, 22, 201, 122, 221, 102, 153, 2, 232, 60, 34, 193, 15, 254, 115, 37, 166, 98, 213, 238, 128, 40, 83, 140, 142, 4, 66, 244, 230, 241, 0, 149, 165
	db 65, 3, 141, 231, 85, 45, 170, 33, 129, 173, 251, 11, 175, 91, 74, 81, 137, 88, 62, 50, 92, 154, 176, 181, 157, 222, 196, 5, 112, 27, 73, 133, 162, 110, 86, 31, 107, 146, 206, 135, 150, 218, 167, 191, 235, 246, 48, 96, 195, 152, 220, 171, 1, 14, 21, 59, 192, 225, 61, 18, 20, 243, 8, 76, 209, 67, 24, 108, 188, 25, 136, 7, 180, 187, 58, 226, 182, 177, 224, 229, 101, 211, 159, 109, 9, 123, 247, 29, 19, 72, 6, 54, 138, 82, 219, 227, 44, 104, 172, 119, 79, 202, 97, 77, 237, 57, 164, 204, 70, 143, 210, 10, 214, 144 
	align #800
BUFF	block 2048