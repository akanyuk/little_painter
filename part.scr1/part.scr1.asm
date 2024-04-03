	jp init
	jp fadeIn
	; fadeOut
	ld b, 13
mainLoop2	push bc

_curColorTbl2	ld hl, COLOR_TABLE + 9*16
	ld b, 16
1	ld a, b : dec a : xor %00001111 : ld c, a
	ld a, (hl)
	push hl
	call lib.ChunksView + 6
	pop hl
	inc hl
	djnz 1b
	ld (_curColorTbl2 + 1), hl

	ld de, #c000 : call lib.ChunksView + 3
	halt
	call lib.SwapScreen

	pop bc : djnz mainLoop2
	ret
fadeIn
	ld b, 9
mainLoop	push bc

_curColorTbl	ld hl, COLOR_TABLE
	ld b, 16
1	ld a, b : dec a : xor %00001111 : ld c, a
	ld a, (hl)
	push hl
	call lib.ChunksView + 6
	pop hl
	inc hl
	djnz 1b
	ld (_curColorTbl + 1), hl

	ld de, #c000 : call lib.ChunksView + 3
	halt
	call lib.SwapScreen

	pop bc : djnz mainLoop
	ret

init	ld hl, CHNK_DATA
	call lib.ChunksView
	include "transition.asm"

COLOR_TABLE	
	; reverse order
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,0,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,0,0,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 0,0,0,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 0,0,0,2,3,3,3,3,3,3,3,3,3,3,3,3
	db 0,0,0,1,3,3,3,3,3,3,3,3,3,3,3,3
	db 0,0,0,1,1,3,3,3,3,3,3,3,3,3,3,3
	db 0,0,0,1,1,1,3,3,3,3,3,3,3,3,3,3
	db 0,0,0,1,1,1,1,2,3,3,3,3,3,3,3,3

	db 0,0,0,1,1,1,1,2,2,2,3,3,3,3,3,3
	db 0,0,0,1,1,1,1,2,2,2,2,2,3,3,3,3
	db 0,0,0,1,1,1,1,1,1,2,2,2,2,3,3,3
	db 0,0,0,0,1,1,1,1,1,1,2,2,2,2,3,3
	db 0,0,0,0,1,1,1,1,1,1,1,1,2,2,3,3
	db 0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,3
	db 0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,3
	db 0,0,0,0,0,0,1,1,1,1,1,1,1,1,2,2
	db 0,0,0,0,0,0,0,0,1,1,1,1,1,1,2,2
	db 0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,2
	db 0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,2
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1

CHNK_DATA	include "res/3.data.asm"
