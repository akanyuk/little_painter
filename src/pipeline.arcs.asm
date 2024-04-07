	ld a, 3 : call lib.SetPage
	ld hl, PART_ARCS
	ld de, EXTERNAL_PART_START
	call lib.Depack

 	xor a : call lib.SetScreen
	ld c, %01000001 : ld a, 25 : call EXTERNAL_PART_START
	ld bc, 100 : call EXTERNAL_PART_START + 6
	
 	ld c, %01001010 : ld a, 5 : call EXTERNAL_PART_START
	ld bc, 300 : call EXTERNAL_PART_START + 6

	ld a, 16 : call EXTERNAL_PART_START + 3
	ld bc, 800 : call EXTERNAL_PART_START + 6
