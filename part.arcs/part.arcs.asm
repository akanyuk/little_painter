	jp init     		; $+0   
	jp init2     		; $+3 
	; $+6  
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
	
	; a - Сдвиг в анимации между линиями
	; c - background color
init	call initLineStep
	ld a, c : call lib.SetScreenAttr
	push af
	ld hl, SDATA1 : call transition1
	halt
	pop af
	
	; paper -> inc
	and %00000111 : push af : rla : rla : rla : pop bc : or b : or %01000000
	push af
	call lib.SetScreenAttr
	call lib.ClearScreen
	pop af 
	and %11111000 : or %00000111
	call lib.SetScreenAttr

	ret

	; a - Сдвиг в анимации между линиями
init2	call initLineStep
	ld a, %01010010
	call lib.SetScreenAttr
	call fillScreen
	ld a, %01000010
	call lib.SetScreenAttr
	ld hl, SDATA2 : call transition1
	xor a
	call lib.SetScreenAttr	
	call lib.ClearScreen
	ld hl, bg1 : ld de, #5800 : ld bc, 512+(32*4) : ldir
	ret

initLineStep	ld b, a
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

transition1	include "transition.asm"
play	include "memsave-player.asm"	
bg1	incbin "res/bg4.scr", 6144

