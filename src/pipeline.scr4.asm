	ld a, 3 : call lib.SetPage
	ld hl, PART_SCR4
	ld de, EXTERNAL_PART_START
	call lib.Depack

	xor a : call lib.SetScreen

	call EXTERNAL_PART_START
	call EXTERNAL_PART_START + 3
	ifndef _NOPAUSE_ : ld b, 100 : halt : djnz $-1 : endif
	call EXTERNAL_PART_START + 6
	ifndef _NOPAUSE_ : ld b, 30 : halt : djnz $-1 : endif
	call EXTERNAL_PART_START + 9
