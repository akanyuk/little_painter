	call PART_SCR1
	ifndef _NOPAUSE_ : ld b, 50 : halt : djnz $-1 : endif
	call PART_SCR1 + 3
	ifndef _NOPAUSE_ : ld b, 200 : halt : djnz $-1 : endif
	call PART_SCR1 + 6
