	ld a, 3 : call lib.SetPage
	ld hl, PART_LASTCIT
	ld de, EXTERNAL_PART_START
	call lib.Depack

	call EXTERNAL_PART_START
	
	ld b, 100
1	push bc
	call EXTERNAL_PART_START + 3
	halt
	pop bc
	djnz 1b

	ld b, 150
1	push bc
	call EXTERNAL_PART_START + 3
	call EXTERNAL_PART_START + 3
	halt
	pop bc
	djnz 1b

	ld b, 50
1	push bc
	call EXTERNAL_PART_START + 3
	call EXTERNAL_PART_START + 3
	call EXTERNAL_PART_START + 3
	halt
	pop bc
	djnz 1b