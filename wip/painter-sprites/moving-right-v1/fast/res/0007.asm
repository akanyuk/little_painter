	ld a, 7
	ld hl, #4061
	ld (hl), a
	inc h
	ld (hl), a
	inc h
	ld (hl), a
	ld a, 39
	ld (#4461), a
	ld a, 219
	ld (#4561), a
	ld a, 3
	ld (#4661), a
	ret
