	jp init
	jp fadeIn
	; fadeOut
	ld b, 6
mainLoop2	push bc

_curColorTbl2	ld hl, COLOR_TABLE + 24*16
	ld b, 16
1	ld a, b : dec a : xor %00001111 : ld c, a
	ld a, (hl)
	push hl
	call lib.ChunksView + 6
	pop hl
	inc hl
	djnz 1b
	ld (_curColorTbl2 + 1), hl

	ld de, #c040 : call lib.ChunksView + 3
	halt
	call lib.SwapScreen

	pop bc : djnz mainLoop2
	ret
fadeIn
	ld b, 24
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

	ld de, #c040 : call lib.ChunksView + 3
	halt
	call lib.SwapScreen

	pop bc : djnz mainLoop
	ret

init	xor a : call lib.SetScreen
	ld a, 7 : call lib.SetPage
	call lib.ClearScreenA
	ld a, #47 : call lib.SetScreenAttrA
	call lib.SwapScreen
	call lib.ClearScreenA
	ld a, #47 : call lib.SetScreenAttrA	
	ld hl, CHNK_DATA
	jp lib.ChunksView

COLOR_TABLE	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1
	db 0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1
	db 0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1
	db 0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,2
	db 0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,2
	db 0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,2
	db 0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2
	db 0,0,0,0,0,0,0,0,1,1,1,1,1,1,2,2
	db 0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2
	db 0,0,0,0,0,0,1,1,1,1,1,1,1,1,2,2
	db 0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2
	db 0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,3
	db 0,0,0,0,0,1,1,1,1,1,1,1,1,2,2,3
	db 0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,3
	db 0,0,0,0,1,1,1,1,1,1,1,1,2,2,2,3
	db 0,0,0,0,1,1,1,1,1,1,1,1,2,2,3,3
	db 0,0,0,0,1,1,1,1,1,1,1,2,2,2,3,3
	db 0,0,0,0,1,1,1,1,1,1,2,2,2,2,3,3
	db 0,0,0,1,1,1,1,1,1,1,2,2,2,2,3,3
	db 0,0,0,1,1,1,1,1,1,2,2,2,2,3,3,3
	db 0,0,0,1,1,1,1,1,2,2,2,2,3,3,3,3
	db 0,0,0,1,1,1,1,2,2,2,2,2,3,3,3,3

	db 0,0,0,1,1,1,1,2,2,2,3,3,3,3,3,3
	db 0,0,0,1,1,1,1,2,3,3,3,3,3,3,3,3
	db 0,0,0,1,1,1,3,3,3,3,3,3,3,3,3,3
	db 0,0,0,1,3,3,3,3,3,3,3,3,3,3,3,3
	db 0,0,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3

CHNK_DATA	include "res/3.data.asm"
