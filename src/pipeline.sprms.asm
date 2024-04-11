	xor a : call lib.SetPage
	ld hl, PART_SPRMS
	ld de, EXTERNAL_PART_START
	call lib.Depack

	xor a : call lib.SetScreen
	ld a, %01111111 : call lib.SetScreenAttr
	call lib.ClearScreen

	call EXTERNAL_PART_START ; hl - адрес процедуры на прерываниях
	call interrStart	
	call EXTERNAL_PART_START + 3
	ifndef _NOPAUSE_ : ld b, 160 : halt : djnz $-1 : endif
	ifndef _NOPAUSE_ : ld b, 160 : halt : djnz $-1 : endif
	ld b, 50 : call EXTERNAL_PART_START + 6
	call interrStop

	xor a : call lib.SetScreenAttr
	call lib.ClearScreen
