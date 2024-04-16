	ld a, 3 : call lib.SetPage
	ld hl, PART_SCR_TOWN
	ld de, EXTERNAL_PART_START
	call lib.Depack

	ld a, 7 : call lib.SetPage
	ld a, %01111111
	call lib.SetScreenAttr
	call lib.SetScreenAttrA
	call lib.ClearScreen
	call lib.ClearScreenA
	
	ld a, %01111000
	call lib.SetScreenAttr
	call lib.SetScreenAttrA

	call EXTERNAL_PART_START

	xor a : call lib.SetPage
	ld hl, PART_SPRMS
	ld de, EXTERNAL_PART_START
	call lib.Depack

	call EXTERNAL_PART_START ; hl - адрес процедуры на прерываниях
	call interrStart	
	call EXTERNAL_PART_START + 3
	ifndef _NOPAUSE_ : ld b, 160 : halt : djnz $-1 : endif
	ifndef _NOPAUSE_ : ld b, 160 : halt : djnz $-1 : endif
	ld b, 50 : call EXTERNAL_PART_START + 6
	call interrStop

	xor a : call lib.SetScreenAttr
	call lib.ClearScreen
