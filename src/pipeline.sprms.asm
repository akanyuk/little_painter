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
	ld b, 160 : halt : djnz $-1
	ld b, 50 : call EXTERNAL_PART_START + 6
	call interrStop
