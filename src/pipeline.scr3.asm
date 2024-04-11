	ld a, 3 : call lib.SetPage
	ld hl, PART_SCR3
	ld de, EXTERNAL_PART_START
	call lib.Depack
	
	call EXTERNAL_PART_START
	call EXTERNAL_PART_START + 3
	ifndef _NOPAUSE_ : ld b, 200 : halt : djnz $-1 : endif
	call EXTERNAL_PART_START + 6

	call lib.ClearScreen