	device zxspectrum128

	page 0

	define EXTERNAL_PART_START #7500
	; define _DEBUG_ 1
	define _MUSIC_ 1

	define P_INTRO 4 ; "OUTSIDERS" intro
	define P_TRACK 1 ; трек и плеер лежат здесь
	define P_START_SCR 7

	org #6000

page0s	module lib
	include "lib/shared.asm"	
	endmodule

	di : ld sp, page0s
	xor a : out (#fe), a 
	call lib.SetScreenAttr
	ld a,#5c : ld i,a : ld hl,interr : ld (#5cff),hl : im 2 : ei

	call musicStart
	ld hl, 0 : ld (INTS_COUNTER), hl

	; jp .tmp

	ld b, 255 : halt : djnz $-1

	call PART_INTRO
	ld b, 20 : halt : djnz $-1

	call PART_SCR1
	ld b, 50 : halt : djnz $-1
	call PART_SCR1 + 3
	ld b, 200 : halt : djnz $-1
	call PART_SCR1 + 6

	ld b, 40 : halt : djnz $-1

	ld hl, PART_SPRMS
	ld de, EXTERNAL_PART_START
	call lib.Depack

	ld a, 5 : call lib.SetPage
	xor a : call lib.SetScreen
	xor a : call lib.SetScreenAttrA
	call lib.ClearScreenA

	call EXTERNAL_PART_START ; hl - адрес процедуры на прерываниях
	call interrStart	
	call EXTERNAL_PART_START + 3
	ld b, 160 : halt : djnz $-1
	call interrStop

	xor a : call lib.SetPage
	ld hl, PART_SCR2
	ld de, EXTERNAL_PART_START
	call lib.Depack

	xor a : call lib.SetScreen

	call EXTERNAL_PART_START
	call EXTERNAL_PART_START + 3
	ld b, 200 : halt : djnz $-1
	call EXTERNAL_PART_START + 6

	ld b, 60 : halt : djnz $-1

	xor a : call lib.SetPage
	ld hl, PART_WORMS
	ld de, EXTERNAL_PART_START
	call lib.Depack
	include "src/pipeline.worms.asm"

.tmp	

	ld b, 160 : halt : djnz $-1

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

	display /d, '[page 0] bytes before overlap external parts: ', EXTERNAL_PART_START - $

	org EXTERNAL_PART_START
PART_INTRO	include "part.intro/part.intro.asm"
PART_SCR1	include "part.scr1/part.scr1.asm"
PART_SPRMS	incbin "build/part.sprms.bin.zx0"
PART_SCR2	incbin "build/part.scr2.bin.zx0"
PART_WORMS	incbin "build/part.worms.bin.zx0"

page0e	display /d, '[page 0] free: ', #ffff - $, ' (', $, ')'	

	define _page1 : page 1 : org #c000
page1s	
PT3PLAY	include "lib/PTxPlay.asm"
	incbin "res/nq-oops-intro-2.pt3"
page1e	display /d, '[page 1] free: ', 65536 - $, ' (', $, ')'

	include "src/builder.asm"
