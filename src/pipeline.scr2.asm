	call PART_SCR2
	ld b, 50 : halt : djnz $-1
	call PART_SCR2 + 3
	ld b, 200 : halt : djnz $-1
	call PART_SCR2 + 6
