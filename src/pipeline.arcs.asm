	ld a, 3 : call lib.SetPage
	ld hl, PART_ARCS
	ld de, EXTERNAL_PART_START
	call lib.Depack

A_PART_ARCS	equ EXTERNAL_PART_START

	call A_PART_ARCS + 3
 	ld a, 25 : call A_PART_ARCS
	ld bc, 100 : call A_PART_ARCS + 12
	
	call A_PART_ARCS + 6
	ld a, %01000110 : call lib.SetScreenAttr	
 	ld a, 6 : call A_PART_ARCS
	ld bc, 20 : call A_PART_ARCS + 12	

	ld a, %01000111 : call lib.SetScreenAttr	
 	ld a, 4 : call A_PART_ARCS
	ld bc, 20 : call A_PART_ARCS + 12	

	ld a, %01000011 : call lib.SetScreenAttr	
 	ld a, 2 : call A_PART_ARCS
	ld bc, 20 : call A_PART_ARCS + 12	

	ld a, 16 : call A_PART_ARCS
	call A_PART_ARCS + 9
	ld bc, 800 : call A_PART_ARCS + 12
