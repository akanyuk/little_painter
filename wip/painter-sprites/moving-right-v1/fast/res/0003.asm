	ld a, 31
	ld hl, #4061
	ld (hl), a
	inc h
	ld (hl), a
	inc h
	ld (hl), a
	ld a, 159
	ld (#4461), a
	ld a, 111
	ld (#4561), a
	ld a, 15
	ld (#4661), a
	ret
