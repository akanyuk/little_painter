	jp init
	jp fadeIn
	; fadeOut
	ld b, (_FADE_OUT_TABLE - FADE_OUT_TABLE) / 16
mainLoop2	push bc

_curColorTbl2	ld hl, FADE_OUT_TABLE
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
	call lib.SwapScreen

	pop bc : djnz mainLoop2
	ret
fadeIn
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

init	ld hl, CHNK_DATA
	call lib.ChunksView

	; transition skipper
	; ld a, 7 : call lib.SetPage		
	; xor a : call lib.SetScreen
	; ld a, %00000100 : call lib.SetScreenAttr
	; ld hl, #4000
	; ld de, #c000
	; ld bc, #1b00
	; ldir
	; ret	

	include "transition.asm"

FADE_IN_TABLE
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 0,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 0,0,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 0,0,0,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 0,0,0,2,3,3,3,3,3,3,3,3,3,3,3,3
	db 0,0,0,1,3,3,3,3,3,3,3,3,3,3,3,3
	db 0,0,0,1,1,3,3,3,3,3,3,3,3,3,3,3
	db 0,0,0,1,1,1,3,3,3,3,3,3,3,3,3,3
	db 0,0,0,1,1,1,1,2,3,3,3,3,3,3,3,3
	db 0,0,0,0,1,1,1,2,2,2,3,3,3,3,3,3
	
_FADE_IN_TABLE

FADE_OUT_TABLE
	db 0,0,0,0,0,1,1,1,2,2,3,3,3,3,3,3
	db 0,0,0,0,1,1,1,1,1,1,2,2,2,2,3,3
	db 0,0,0,0,1,1,1,1,1,1,2,2,2,2,3,3
	db 0,0,0,0,1,1,1,1,1,1,1,1,2,2,3,3
	db 0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,3
	db 0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,3
	db 0,0,0,0,0,0,0,0,1,1,1,1,1,1,2,2
	db 0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,2
	db 0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,2
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1
_FADE_OUT_TABLE


; parsed.data.asm (Сара Коннор)
; FADE_IN_TABLE
; 	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
; 	db 0,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
; 	db 0,0,3,3,3,3,3,3,3,3,3,3,3,3,3,3
; 	db 0,0,0,3,3,3,3,3,3,3,3,3,3,3,3,3
; 	db 0,0,0,2,3,3,3,3,3,3,3,3,3,3,3,3
; 	db 0,0,0,1,3,3,3,3,3,3,3,3,3,3,3,3
; 	db 0,0,0,1,1,3,3,3,3,3,3,3,3,3,3,3
; 	db 0,0,0,1,1,1,3,3,3,3,3,3,3,3,3,3
; 	db 0,0,0,1,1,1,1,2,3,3,3,3,3,3,3,3
; 	db 0,0,0,0,1,1,1,2,2,2,3,3,3,3,3,3
; 	db 0,0,0,0,0,1,1,1,2,2,3,3,3,3,3,3
; _FADE_IN_TABLE

; FADE_OUT_TABLE
; 	db 0,0,0,0,1,1,1,1,1,1,2,2,2,2,3,3
; 	db 0,0,0,0,1,1,1,1,1,1,1,1,2,2,3,3
; 	db 0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,3
; 	db 0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,3
; 	db 0,0,0,0,0,0,0,0,1,1,1,1,1,1,2,2
; 	db 0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,2
; 	db 0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,2
; 	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1
; _FADE_OUT_TABLE

CHNK_DATA	
	include "res/mountains.data.asm"
	; include "res/parsed.data.asm"
