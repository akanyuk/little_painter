	ld a, 3 : call lib.SetPage
	ld hl, PART_SCR3
	ld de, EXTERNAL_PART_START
	call lib.Depack
	
	xor a : call lib.SetScreen

	call EXTERNAL_PART_START
	call EXTERNAL_PART_START + 3
	ld b, 200 : halt : djnz $-1
	call EXTERNAL_PART_START + 6

	call lib.ClearScreen