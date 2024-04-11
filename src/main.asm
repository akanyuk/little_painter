	device zxspectrum128

	page 0

	define _DEBUG_ 1
	; define _NOPAUSE_
	; define _MUSIC_ 1
	define EXTERNAL_PART_START #7500
	define P_TRACK 1 ; track and player here
	org #6000

page0s	module lib
	include "lib/shared.asm"	
	endmodule

	di : ld sp, page0s
	xor a : out (#fe), a 
	ld hl, #4000 : ld de, #4001 : ld bc, #1aff : ld (hl), a : ldir
	ld a,#5c : ld i,a : ld hl,interr : ld (#5cff),hl : im 2 : ei

	call musicStart
	ld hl, 0 : ld (INTS_COUNTER), hl

	jp _tmp

	ifndef _NOPAUSE_ : ld b, 255 : halt : djnz $-1 : endif
	call PART_INTRO
	ifndef _NOPAUSE_ : ld b, 20 : halt : djnz $-1 : endif

_tmp	ld a, 7 : call lib.SetPage : call painter.Init
	ld a, #01 : ld (PAINTER_STATE), a ; start painter animation

	include "src/pipeline.scr1.asm"

	ifndef _NOPAUSE_ : ld b, 40 : halt : djnz $-1 :	endif

	include "src/pipeline.arcs.asm"
	include "src/pipeline.scr2.asm"
	include "src/pipeline.sprms.asm"
	
	ifndef _NOPAUSE_ : ld b, 100 : halt : djnz $-1 : endif

	include "src/pipeline.scr3.asm"
	include "src/pipeline.worms.asm"

	ifndef _NOPAUSE_ : ld b, 100 : halt : djnz $-1 : endif

	include "src/pipeline.scr4.asm"

	ifndef _NOPAUSE_ : ld b, 100 : halt : djnz $-1 : endif

	xor a : ld (PAINTER_STATE), a ; stop painter animation
	ld a, 7 : call lib.SetPage : call painter.End

	ifndef _NOPAUSE_ : ld b, 100 : halt : djnz $-1 : endif

	; STOP HERE
	ifdef _MUSIC_
	ld a, P_TRACK : call lib.SetPage
	call PT3PLAY + 8
	xor a : ld (MUSIC_STATE), a
	endif

	jr $

musicStart	ifdef _MUSIC_
	ld a, P_TRACK : call lib.SetPage
	call PT3PLAY
	ld a, #01 : ld (MUSIC_STATE), a
	endif
	ret

	; запуск нужной процедуры на прерываниях
	; HL - адрес процедура
interrStart	ld de, interrCurrent
	ex de, hl
	ld (hl), #c3 ; jp
	inc hl : ld (hl), e
	inc hl : ld (hl), d
	ret

	; остановка процедуры на прерываниях
interrStop	ld hl, interrCurrent
	ld (hl), #c9 ; ret
	ret

interrCurrent	ret
	nop
	nop

painterCurrent	ret
	nop
	nop

interr	di
	push af,bc,de,hl,ix,iy
	exx : ex af, af'
	push af,bc,de,hl,ix,iy
	ifdef _DEBUG_ : ld a, #01 : out (#fe), a : endif ; debug

	ifdef _MUSIC_
MUSIC_STATE	equ $+1	
	ld a, #00 : or a : jr z, 1f
	ld a, (lib.CUR_SCREEN) : ld b, a
	ld a, P_TRACK : or b : or %00010000
	ld bc, #7ffd : out (c), a
	call PT3PLAY + 5	
	// Restore page
	ld a, (lib.CUR_SCREEN) : ld b, a 
	ld a, (lib.CUR_PAGE) : or b : or %00010000
	ld bc, #7ffd : out (c), a
1	
	endif

PAINTER_STATE	equ $+1	
	ld a, #00 : or a : jr z, 1f
	ld a, (lib.CUR_SCREEN) : ld b, a
	ld a, 7 : or b : or %00010000
	ld bc, #7ffd : out (c), a
	call painter.Interrupts	
	// Restore page
	ld a, (lib.CUR_SCREEN) : ld b, a 
	ld a, (lib.CUR_PAGE) : or b : or %00010000
	ld bc, #7ffd : out (c), a
1	

	call interrCurrent

	; счетчик интов
INTS_COUNTER	equ $+1
	ld hl, #0000 : inc hl : ld ($-3), hl

	ifdef _DEBUG_ : xor a : out (#fe), a : endif ; debug
	pop iy,ix,hl,de,bc,af
	exx : ex af, af'
	pop iy,ix,hl,de,bc,af
	ei
	ret

	display /d, 'Free page pefore EXTERNAL_PART_START: ', EXTERNAL_PART_START - $

PART_INTRO	include "part.intro/part.intro.asm"
PART_SCR1	include "part.scr1/part.scr1.asm"
	org #c000 + 4000
PART_SPRMS	incbin "build/part.sprms.bin.zx0"
page0e	display /d, '[page 0] free: ', #ffff - $, ' (', $, ')'	

	define _page1 : page 1 : org #c000
page1s	
PT3PLAY	include "lib/PTxPlay.asm"
	incbin "res/nq-oops-intro-2.pt3"
page1e	display /d, '[page 1] free: ', 65536 - $, ' (', $, ')'

	define _page3 : page 3 : org #c000
page3s	
PART_ARCS	incbin "build/part.arcs.bin.zx0"
PART_SCR2	incbin "build/part.scr2.bin.zx0"
PART_SCR3	incbin "build/part.scr3.bin.zx0"
PART_SCR4	incbin "build/part.scr4.bin.zx0"
PART_WORMS	incbin "build/part.worms.bin.zx0"
page3e	display /d, '[page 3] free: ', 65536 - $, ' (', $, ')'

	define _page7 : page 7 : org #db00
page7s	
	module painter
	include "src/painter.asm"
	endmodule
page7e	display /d, '[page 7] free: ', 65536 - $, ' (', $, ')'

	include "src/builder.asm"
