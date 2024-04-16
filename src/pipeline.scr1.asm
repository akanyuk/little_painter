	call PART_SCR1
	ifndef _NOPAUSE_ : ld b, 30 : halt : djnz $-1 : endif
	call PART_SCR1 + 3
	ifndef _NOPAUSE_ : ld b, 120 : halt : djnz $-1 : endif
	call PART_SCR1 + 6
