	jp init     		; $+0   
	jp init2     		; $+3 
	; $+6  
	include "memsave-player.asm"	

	; a - Сдвиг в анимации между линиями
	; c - background color
init	call initLineStep
	ld hl, #5800 : ld de, #5801 : ld (hl), c : ld bc, #01ff : ldir
	ret

	; a - Сдвиг в анимации между линиями
init2	call initLineStep
	ld hl, bg1 : ld de, #5800 : ld bc, 768 : ldir
	ld hl, #5000 : ld de, #5001 : ld (hl), #ff : ld bc, #001f : ldir
	ld hl, #5100 : ld de, #5101 : ld (hl), #ff : ld bc, #001f : ldir
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
	ret

bg1	incbin "res/bg4.scr", 6144

