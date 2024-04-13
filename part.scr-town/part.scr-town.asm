init	ld hl, CHNK_DATA
	call lib.ChunksView

	ld b, (_FADE_IN_TABLE - FADE_IN_TABLE) / 16
mainLoop	push bc

_curColorTbl	ld hl, FADE_IN_TABLE
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
	call lib.SwapScreen

	pop bc : djnz mainLoop
	ret

FADE_IN_TABLE
	db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 2,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 3,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0
_FADE_IN_TABLE
CHNK_DATA	
	;include "res/parsed.data.asm"
	include "res/town-inv.data.asm"