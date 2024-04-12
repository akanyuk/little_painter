	jp initAnima   		; $+0
	jp init1     		; $+3   
	jp init2     		; $+6 
	jp init3     		; $+9
	; $+12
1	push bc
	call play : halt
	pop bc 
	dec bc : ld a, b : or c : jr nz, 1b

	ld a, 100 : ld (noMoreAnima + 1), a

1	call play : halt
	ld hl, LINES_STATE + 2
	ld de, 4
	ld b, 8
2	ld a, (hl) : cp #48 : jr c, 1b
	add hl, de
	djnz 2b
	ret
	
init1	ld a, %00000101  : call lib.SetScreenAttr
	
	ld hl, L5LAT/2 + LLAT2 * 7 + 10
	ld (transStages), hl	
	ld hl, SDATA1 : call transition1

	ld a, %00101101 : call lib.SetScreenAttr
	call lib.ClearScreen
	ld a, %00101000 : call lib.SetScreenAttr
	call lib.SetScreenAttr
	ret

init2	ld a, %0101101 : call lib.SetScreenAttr
	call fillScreen
	ld a, %00000101
	call lib.SetScreenAttr

	ld hl, L8LAT + LLAT * 4 + 16
	ld (transStages), hl
	ld hl, SDATA2 : call transition1
	ret

init3	ld a, %00000001 : call lib.SetScreenAttr

	ld hl, L4LAT + LLAT3 * 4 + 16
	ld (transStages), hl
	ld hl, SDATA3 : call transition1

	ld a, %00001001 : call lib.SetScreenAttr
	call lib.ClearScreen
	ld hl, bg1 : ld de, #5800 : ld bc, 512+(32*4) : ldir

	ld b, 56
1	push bc
	call dispBgOut
	halt
	pop bc
	djnz 1b

	ret

	; a - Сдвиг в анимации между линиями
initAnima	ld b, a
	add a
	ld (LINES_STATE + 3), a
	add b : ld (LINES_STATE + 7), a
	add b : ld (LINES_STATE + 11), a
	add b : ld (LINES_STATE + 15), a
	add b : ld (LINES_STATE + 19), a
	add b : ld (LINES_STATE + 23), a
	add b : ld (LINES_STATE + 27), a
	add b : ld (LINES_STATE + 31), a

	ld a, #ff : ld (noMoreAnima + 1), a
	ld (LINES_STATE + 2), a
	ld (LINES_STATE + 6), a
	ld (LINES_STATE + 10), a
	ld (LINES_STATE + 14), a	
	ld (LINES_STATE + 18), a
	ld (LINES_STATE + 22), a
	ld (LINES_STATE + 26), a
	ld (LINES_STATE + 30), a
	ret

	; a - color
fillScreen	ld hl, #4000 : ld de, #4001 : ld bc, #0fff : ld (hl), #ff : ldir
	ld hl, #5000
	ld a, 32
1	push af
	push hl
	ld d, h : ld e, l : inc e
	ld bc, #001f 
_fillScreenA	ld (hl), #ff
	ldir
	pop hl
	call lib.DownHL
	pop af : dec a : jr nz, 1b
	ret

dispBgOut	ld hl, bgOut + (32 * 8 * 14) - (32*2)
	ld de, #4000
_dispBgOutA	ld a, 2
1	push af
	push de
	ld bc, #0020
	ldir
	pop de
	call lib.DownDE
	pop af
	dec a
	jr nz, 1b
	
	ld hl, (dispBgOut + 1)
	ld de, 32*2
	sbc hl, de
	ld (dispBgOut + 1), hl
	
	ld a, (_dispBgOutA + 1)
	add 2
	ld (_dispBgOutA + 1), a

	ret

transition1	include "transition.asm"
play	include "memsave-player.asm"	
bg1	incbin "res/bg5.scr", 6144
bgOut	incbin "res/bg-out.bin"

