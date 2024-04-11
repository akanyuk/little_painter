	ld a, 3 : call lib.SetPage
	ld hl, PART_SCR4
	ld de, EXTERNAL_PART_START
	call lib.Depack

	xor a : call lib.SetScreen

	call EXTERNAL_PART_START
	call EXTERNAL_PART_START + 3
	ld b, 100 : halt : djnz $-1
	call EXTERNAL_PART_START + 6
	ld b, 30 : halt : djnz $-1
	call EXTERNAL_PART_START + 9
